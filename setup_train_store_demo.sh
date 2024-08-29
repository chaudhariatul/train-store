#!/bin/bash

git clone https://github.com/chaudhariatul/train-store
cd train-store
python3 -m venv .venv
source .venv/bin/activate
pip install --no-cache-dir -U torch==2.4.0 --index-url https://download.pytorch.org/whl/cpu
pip install --no-cache-dir -r train_store/requirements.txt
docker-compose up -d
cd train_store
python add_reviews.py
docker-compose down && docker-compose up -d