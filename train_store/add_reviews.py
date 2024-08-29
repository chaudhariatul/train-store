from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.core import StorageContext, VectorStoreIndex, Settings, Document
from llama_index.core.vector_stores import VectorStoreQuery
from llama_index.core.vector_stores.types import MetadataFilter, MetadataFilters, ExactMatchFilter
from llama_index.core.schema import TextNode
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
from datetime import datetime, timedelta, date
import time
import re
import random


warnings.filterwarnings("ignore", category=FutureWarning)


def random_date(start_date, end_date):
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + timedelta(days=random_number_of_days)
    return random_date


def context_engine(em,  db, ollama_host='ollama_container', llm_model='gemma2:2b'):
    embed_model_name = em['embed_model_name']
    embed_dimension = em['embed_dimension']
    table_name = 'review_embeddings'
    
    try:
        embed_model = HuggingFaceEmbedding(
            model_name=f"./models/{embed_model_name}", 
            trust_remote_code=True,
        )
        print(f"\n  Using {llm_model} language model with {embed_model_name} embedding model.\n")
        print("-"*100)
    except:
        download_model = SentenceTransformer(
            embed_model_name, 
            trust_remote_code=True,
        )
        download_model.save(f'models/{embed_model_name}')
        embed_model = HuggingFaceEmbedding(
            model_name=f"./models/{embed_model_name}", 
            trust_remote_code=True,
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
            "hnsw_ef_construction": 100,
            "hnsw_ef_search": 100,
            "hnsw_dist_method": "vector_cosine_ops",
        },
    )
    storage_context = StorageContext.from_defaults(vector_store=vector_store)
    vector_index = VectorStoreIndex.from_vector_store(
        vector_store=vector_store, 
        storage_context=storage_context,
    )
    query_engine = vector_index.as_query_engine()

    return storage_context, query_engine, vector_index, vector_store


def review_embeddings(review, storage_context):
    ## Storing embeddings in Postgres database
    documents = [Document(text=review)]
    vector_index = VectorStoreIndex.from_documents(
        documents, 
        storage_context=storage_context, 
        show_progress=False,
    )
    return vector_index

embed_models = [{"embed_model_name": 'Alibaba-NLP/gte-large-en-v1.5', "embed_dimension": 1024}]

db = {
    'db_host':      'postgres', 
    'db_port':      '5432', 
    'db_name':      'postgres', 
    'db_user':      'postgres', 
    'db_password':  'P0stGr3sP@ss', 
}

storage_context, query_engine, vector_index, vector_store = context_engine(embed_models[0], db, ollama_host='localhost', llm_model='gemma2:2b')

def review_embeddings(review, review_date,  product, product_id, vector_store):
    review_node = [
                    TextNode(text=review,
                        metadata={
                            "review_date": datetime.strftime(review_date, "%Y-%m-%d"),
                            "product": product,
                            "product_id": product_id,
                        },
                    )
                ]
    vector_index = VectorStoreIndex.from_vector_store(vector_store=vector_store)
    vector_index.insert_nodes(review_node)
    return review_node


with open("./reviews.json", 'r') as rf:
    product_reviews_json = json.load(rf)

start_date = date(2022, 1, 1)
end_date = date(2024, 5, 31)

for product in product_reviews_json:
    for review in product['product_reviews']:
        random_date_result = random_date(start_date, end_date)
        review_embeddings(review, random_date_result, product['product_name'], product['product_id'], vector_store)        