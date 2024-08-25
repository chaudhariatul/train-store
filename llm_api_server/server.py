import json
from datetime import datetime
import random
import queue
from flask import Flask, request
import requests as r
app = Flask(__name__)


def generate_response():
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

    generate_response
    answer = ""
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