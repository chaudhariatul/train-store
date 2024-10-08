#!/bin/bash

git clone https://github.com/chaudhariatul/train-store
cd train-store
docker-compose up -d

# Wait for 5mins for the train_store container to be ready
echo "Waiting for train store on port 8080 to become available..."

while ! curl --silent --head --fail http://localhost:8080 >/dev/null 2>&1; do
  echo -n "."
  sleep 2
done
hostip=`hostname -I | awk '{print $1}'`
echo "Train store website now available on http://localhost:8080 or http://$hostip:8080"