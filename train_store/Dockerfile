FROM python:3.9-slim as base
WORKDIR /usr/train_store/
COPY requirements.txt /requirements.txt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y && apt install curl -y && pip3 -q install --upgrade pip && pip install --no-cache-dir -U torch==2.4.0 --index-url https://download.pytorch.org/whl/cpu && pip3 -q install --no-cache-dir -r /requirements.txt 
EXPOSE 8080
HEALTHCHECK CMD curl --fail http://localhost:8080/_stcore/health