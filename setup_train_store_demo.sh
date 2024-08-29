#!/bin/bash

git clone https://github.com/chaudhariatul/train-store
cd train-store
docker-compose up -d
docker exec -it train_store bash -c "cd /usr/train_store/ && python add_reviews.py"