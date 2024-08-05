from llama_index.llms.ollama import Ollama
from llama_index.core.llms import ChatMessage
import json

def learn_something(about):
    creative_thinking_llm = Ollama(model="llama3.1:8b-instruct-q4_K_M", request_timeout=120.0)
    interesting_phenomenon_response = creative_thinking_llm.complete(about)
    interesting_phenomenon = json.loads(interesting_phenomenon_response.json())['text']
    return interesting_phenomenon

def ask_question(question):
    streamchat_llm = Ollama(model="gemma2:2b", request_timeout=120.0)
    messages = [
        ChatMessage(role="system", content=interesting_phenomenon),
        ChatMessage(role="user", content=question),
    ]
    stream_response = streamchat_llm.stream_chat(messages)
    for r in stream_response:
        print(r.delta, end="")


tellme_about = "Tell me about crepuscular and anticrepuscular rays in 500 words."
interesting_phenomenon = learn_something(tellme_about)
ask_question("When and where can someone see crepuscular rays in San Jose, California?")
