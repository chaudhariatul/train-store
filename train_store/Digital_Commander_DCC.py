
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import StorageContext, VectorStoreIndex, Settings, get_response_synthesizer, Document
from llama_index.core.vector_stores.types import MetadataFilter, MetadataFilters, ExactMatchFilter
from llama_index.core.vector_stores import VectorStoreQuery
from llama_index.core.schema import TextNode
from llama_index.core.query_engine import RetrieverQueryEngine
from llama_index.vector_stores.postgres import PGVectorStore
from llama_index.llms.ollama import Ollama
from llama_index.core.llms import ChatMessage
from sentence_transformers import SentenceTransformer



import pandas as pd
import textwrap
import os

import psycopg2 as pg

import streamlit as st

import requests
from PIL import Image
import traceback
from urllib.parse import quote_plus
import warnings


import json
from datetime import datetime, timedelta
import time
import re


warnings.filterwarnings("ignore", category=FutureWarning)

class pgDb:

    @st.cache_resource(ttl=300)
    def get_db_cursor(db):
        # Connect to the database
        conn = pg.connect(
            database=db['db_name'],
            user=db['db_user'], 
            password=db['db_password'],
            host=db['db_host'], 
            port=db['db_port'],
        )

        # Create a cursor object
        cursor = conn.cursor()
        return (conn, cursor)

def ask_question(llm, question, interesting_phenomenon):
    messages = [
        ChatMessage(role="system", content=interesting_phenomenon),
        ChatMessage(role="user", content=question),
    ]
    stream_response = llm.stream_chat(messages)
    for r in stream_response:
        yield r.delta + " "

def context_engine(em,  db, ollama_host='ollama_container', llm_model='gemma2:2b'):
    product = {"product_id": 1, "product_name": "Digital Commander DCC Equipped Ready To Run Electric Train Set - HO Scale"}
    embed_model_name = em['embed_model_name']
    embed_dimension = em['embed_dimension']
    # table_name = re.sub("[-.:#@\\/\\\]","_",embed_model_name)
    table_name = 'review_embeddings'
    start_date = datetime.strftime(datetime.today()-timedelta(365), "%Y-%m-%d")
    end_date = datetime.strftime(datetime.today(), "%Y-%m-%d")
    filters = MetadataFilters(
        filters=[
            ExactMatchFilter(key="product", value=product['product_name']),
            # MetadataFilter(key="review_date", value=start_date, operator=">="),
            # MetadataFilter(key="review_date", value=end_date, operator="<="),
        ],
        condition="and",
    )    
    try:
        embed_model = HuggingFaceEmbedding(
            model_name=f"./models/{embed_model_name}", 
            trust_remote_code=True,
            revision='104333d'
        )
        print(f"\n  Using {llm_model} language model with {embed_model_name} embedding model.\n")
        print("-"*100)
    except:
        download_model = SentenceTransformer(
            embed_model_name, 
            trust_remote_code=True,
            revision='104333d'
        )
        download_model.save(f'models/{embed_model_name}')
        embed_model = HuggingFaceEmbedding(
            model_name=f"./models/{embed_model_name}", 
            trust_remote_code=True,
            revision='104333d'
        )

    llm = Ollama(model=llm_model, request_timeout=900.0, base_url=f"http://{ollama_host}:11434")
    Settings.llm = llm
    Settings.embed_model = embed_model
    vector_store = PGVectorStore.from_params(
        database=db['db_name'],
        host=db['db_host'],
        password=quote_plus(db['db_password']),
        port=db['db_port'],
        user=db['db_user'],
        table_name=table_name,
        embed_dim=embed_dimension,
        hnsw_kwargs={
            "hnsw_m": 16,
            "hnsw_ef_construction": 64,
            "hnsw_ef_search": 40,
            "hnsw_dist_method": "vector_cosine_ops",
        },
    )
    storage_context = StorageContext.from_defaults(vector_store=vector_store)

    vector_index = VectorStoreIndex.from_vector_store(
        vector_store=vector_store, 
        storage_context=storage_context,
    )
    query_engine = vector_index.as_query_engine(
        filters=filters
    )

    return storage_context, query_engine, vector_index, vector_store

def review_embeddings(review, review_date, product, product_id, vector_store):
    review_node = [
                    TextNode(text=review,
                        metadata={
                            "review_date": review_date,
                            "product": product,
                            "product_id": product_id,
                        },
                    )
                ]
    vector_index = VectorStoreIndex.from_vector_store(vector_store=vector_store)
    vector_index.insert_nodes(review_node)
    return review_node

embed_models = [{"embed_model_name": 'Alibaba-NLP/gte-large-en-v1.5', "embed_dimension": 1024}]

st.set_page_config(
    page_title="TrainStore",
    page_icon=":train:",
    initial_sidebar_state="expanded",
    layout='wide'    
    )


db = {
    'db_host': os.environ.get('db_host'), 
    'db_port': os.environ.get('db_port'), 
    'db_name': os.environ.get('db_name'), 
    'db_user': os.environ.get('db_user'), 
    'db_password': os.environ.get('POSTGRES_PASSWORD'), 
}

@st.cache_data(persist="disk")
def text_generation_with_gemma(_llm, about):
    interesting_info_response = _llm.complete(about)
    interesting_info = json.loads(interesting_info_response.json())['text']
    return interesting_info

@st.cache_data(persist="disk")
def create_review_summary(_vector_index):
    response_synthesizer = get_response_synthesizer(response_mode="tree_summarize")
    retriever = _vector_index.as_retriever()
    summary_engine = RetrieverQueryEngine(
        retriever=retriever,
        response_synthesizer=response_synthesizer,
    )
    response = summary_engine.query("""
                        Summarize the reviews with 5 point rating for Ease of assembly, Value for money, Good starter set, Functionality, Accessories included.
                        Generate response in this format: 
                            Ease of assembly : (rating/5) | Value for money : (rating/5) | Starter set : (rating/5) | Functionality : (rating/5) | Accessories included : (rating/5)
                    """)
    return response.response


@st.dialog(f"Write a review :")
def write_review(product_name, product_id, vector_store):
    review = st.text_area(product_name)
    if st.button("Submit Review"):
        st.session_state.review = {"product": product_name, "review": review}
        review_embeddings(
            review, 
            datetime.strftime(datetime.today(), "%Y-%m-%d"), 
            product_name, 
            product_id, 
            vector_store
        )
        st.rerun()


## Show the models downloaded to ollama
with st.sidebar.container(border=True):
    # st.dataframe(pd.DataFrame(models_available())['name'])
    if st.button("Tell me more!", on_click=text_generation_with_gemma.clear):
        text_generation_with_gemma.clear()

def main():
    ollama_address = 'ollama_container'
    slm = 'gemma2:2b'
    text_llm = Ollama(model=slm, request_timeout=300.0, base_url=f"http://{ollama_address}:11434", additional_kwargs={"low_vram": True})
    storage_context, query_engine, vector_index, vector_store  = context_engine(embed_models[0], db, ollama_host=ollama_address, llm_model=slm)
    with open('./products.json', 'r') as pf:
        products = json.load(pf)
    product = products[0]
    st.subheader(product['Name'])
    col01, col02, col03 = st.columns([4,3,3])

    with col02:
        with st.container(height=50, border=False):
            st.empty()
        with st.container(height=1100, border=True):
            col02_1, col02_2 = st.columns([1,1])
            with col02_1:
                st.metric(label="Price", value=f"${product['Price']}")
            with col02_2:
                if st.button(label="BuyNow"):
                    st.balloons()
            product_table = {
                "Manufacturer": product['Manufacturer'],
                "PartNumber": product['PartNumber'],
                "Scale": product['Scale'],
                "Type": product['Type'],
                "Weight": product['Weight'],
            }
            st.dataframe(product_table, use_container_width=True)
            st.markdown("---")
            st.subheader('Product Description')
            st.write(product['ProductDetails'])
            st.markdown("---")
            
    with col03:
        with st.container(height=50, border=False):
            st.empty()
        with st.container(height=500, border=True):
            messages = st.container(height=400)
            if prompt := st.chat_input("How can I help you?"):
                q = f"""
                You are a toy train enthusiast who wants to help new customers.
                You are responsible to analyze the reviews written for the product {product['Name']}.
                Ensure the response is relevant and appropriate and find the answer to : {prompt} to help the new customer.
                """
                q_response = query_engine.query(q)
                messages.chat_message("user").write(prompt)
                messages.chat_message("assistant").write(str(q_response))
        with st.container(border=True):
            st.html("<h4><b>Customer reviews</b></h4>")
            if "review" not in st.session_state:
                if st.button("Write a review"):
                    write_review(product['Name'], product['ProductId'], vector_store)
            else:
                f"Thank you for your review!"
                st.session_state.review = {}
            st.html("<h5>Customer ratings</h5>")
            reviews_summary = create_review_summary(vector_index)
            st.write(reviews_summary)
            
    with col01:
        tab1, tab2, tab3, tab4 = st.tabs(["Train", "Assembled", "Parts", "Box"])
        with tab1:
            placeholder_tab1 = st.empty()
            with placeholder_tab1.container(height=800, border=True):
                w1, h1 = Image.open("./images/product0/image1.png").size
                image1 = Image.open("./images/product0/image1.png").resize((int(w1*300/h1), 300))
                st.image(image1, use_column_width=True)

        with tab2:
            placeholder_tab2 = st.empty()
            with placeholder_tab2.container(height=800, border=True):
                w2, h2 = Image.open("./images/product0/image2.png").size
                image2 = Image.open("./images/product0/image2.png").resize((w2*300//h2, 300))
                st.image(image2, use_column_width=True)

        with tab3:
            placeholder_tab3 = st.empty()
            with placeholder_tab3.container(height=800, border=True):
                w3, h3 = Image.open("./images/product0/image3.png").size
                image3 = Image.open("./images/product0/image3.png").resize((int(w3*300/h3), 300))
                st.image(image3, use_column_width=True)


        with tab4:
            placeholder_tab4 = st.empty()
            with placeholder_tab4.container(height=800, border=True):
                w4, h4 = Image.open("./images/product0/image4.png").size
                image4 = Image.open("./images/product0/image4.png").resize((int(w4*300/h4), 300))
                st.image(image4, use_column_width=True)

        with placeholder_tab1.container(border=True):
            w1, h1 = Image.open("./images/product0/image1.png").size
            image1 = Image.open("./images/product0/image1.png").resize((int(w1*300/h1), 300))
            st.image(image1, use_column_width=True)
            product_size = product['Scale']
            product_cost = product['Price']
            product_type = product['Type']
            locomotive_types = product['LocomotiveType']
            with st.spinner(f"Toy Trains"):
                prompt1=f"""
                    You are helpful toy trains shopping assistant. 
                    Help this online train store visitors improve their experience with helpful information about:
                        1. size {product_size}
                        2. cost {product_cost}
                        3. train type {product_type} and {locomotive_types}
                        4. upgradeability 
                        and other important factors.
                    Limit your reponse to 300 words.
                """
                activity_description = text_generation_with_gemma(text_llm, prompt1)
                st.info(f'Things to consider when shopping for Toy train set.', icon="ℹ️")
                st.success(f'Text generated with {slm} and cached with @st.cache_data decorator. Click the button to generate new text.')
                if st.button("Tell me more!", key="AboutTrain", help="This button triggers a new text to be generated by the Language Model used in this application.", type="primary"):
                    text_generation_with_gemma.clear(text_llm, prompt1)
                st.write(activity_description)

        with placeholder_tab2.container(border=True):
            w2, h2 = Image.open("./images/product0/image2.png").size
            image2 = Image.open("./images/product0/image2.png").resize((w2*300//h2, 300))
            accessories_included = product['AccessoriesIncluded']
            st.image(image2, use_column_width=True)
            with st.spinner(f"Assembling toy train sets"):
                prompt2=f"""
                    You are helpful toy trains shopping assistant. 
                    Write a brief recommendations on how to assemble a toy train set. 
                    Describe how these accessories included in this product {accessories_included} will help customers.
                    Limit your reponse to 300 words.
                """
                activity_description = text_generation_with_gemma(text_llm, prompt2)
                st.info('Read more about assembling toy trains!', icon="ℹ️")
                if st.button("Tell me more!", key="AssembledTrain", help="This button triggers a new text to be generated by the Language Model used in this application.", type="primary"):
                    text_generation_with_gemma.clear(text_llm, prompt2)
                st.write(activity_description)

        with placeholder_tab3.container(border=True):
            w3, h3 = Image.open("./images/product0/image3.png").size
            image3 = Image.open("./images/product0/image3.png").resize((int(w3*300/h3), 300))
            st.image(image3, use_column_width=True)
            with st.spinner(f"Toy train parts"):
                prompt3=f"""
                    You are a train enthusiast shopping assistant.
                    Review the following parts included in this train set and how customers can find long term value with these parts:
                        - {accessories_included}
                        - {locomotive_types}
                    Include the value customers can find for this {product_size} for this price {product_cost}.
                    Limit your reponse to 300 words.
                """
                activity_description = text_generation_with_gemma(text_llm, prompt3)
                st.info('More details about parts and accessories included in this train set.', icon="ℹ️")
                if st.button("Tell me more!", key="TrainAccessories", help="This button triggers a new text to be generated by the Language Model used in this application.", type="primary"):
                    text_generation_with_gemma.clear(text_llm, prompt3)
                st.write(activity_description)

if __name__ == "__main__":
    main()

