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
import json
from datetime import datetime
import random
import queue
from flask import Flask, request
import requests as r
app = Flask(__name__)


def random_date(start_date, end_date):
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + timedelta(days=random_number_of_days)
    return random_date


def qna_context_engine(product, em,  db, ollama_host='ollama_container', llm_model='gemma2:2b'):
    embed_model_name = em['embed_model_name']
    embed_dimension = em['embed_dimension']
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



embed_models = [{"embed_model_name": 'Alibaba-NLP/gte-large-en-v1.5', "embed_dimension": 1024}]

db = {
    'db_host':      'localhost', 
    'db_port':      '5432', 
    'db_name':      'postgres', 
    'db_user':      'postgres', 
    'db_password':  'P0stGr3sP@ss', 
}
product = {"product_id": 1, "product_name": "Digital Commander DCC Equipped Ready To Run Electric Train Set - HO Scale"}
storage_context, query_engine, vector_index, vector_store = qna_context_engine(product, embed_models[0], db, ollama_host='localhost', llm_model='gemma2:2b')


def generate_response():
    prompt = f"""
    You are an expert sentiment analyst and a toy train enthusiast who wants to help new customers.
    You are responsible to analyze the reviews written for the product {product['product_name']}.
    Ensure the response is relevant and appropriate and find the answer to : {q} to help the new customer.
    Limit the response to 10 words.
    """
    q_response = query_engine.query(q)
    pass

@app.route("/api/qna")
def qna():
    session_id = request.args.get("session_id")
    question_id = request.args.get("question_id")
    question = request.args.get("question")
    prompt = request.args.get("prompt")
    llm_model = request.args.get("llm_model")
    embed_model = request.args.get("embed_model")

    if not session_id:
        session_id = random.randint(1,10)
    if not question_id:
        question_id = random.randint(1,10)
    if not question:
        question = "What is the best number?"
    if not prompt:
        prompt = f"You are awesome. Find the answer to {question}"
    if not llm_model:
        llm_model = "gemma2:2b"
    if not embed_model:
        embed_model = "Alibaba-NLP/en"

    answer = generate_response(question)
    data = {
        "question": question,
        "answer": answer,
        "session_id": session_id,
    }
    return json.dumps(data)

@app.route("/api/active_sessions")
def active_sessions():
    return json.dumps({"active_sessions": random.randint(1,10)})


@app.route("/api/queue_length")
def queue_length():
    session_count = r.get('http://localhost:5000/api/active_sessions').json()['active_sessions']
    return json.dumps({"active_sessions":session_count, "queue_length": session_count*random.randint(1,10)})