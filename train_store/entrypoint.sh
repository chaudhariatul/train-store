#!/usr/bin/env bash
set -x
pid=0
term_handler() {
  if [ $pid -ne 0 ]; then
    echo "Stopping Train Store"
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

trap 'kill ${!}; term_handler' SIGTERM
/usr/bin/curl -s http://ollama_container:11434/api/pull -d '{"name":"gemma2:2b","stream":false}'
/usr/bin/curl -s http://ollama_container:11434/api/pull -d '{"name":"gemma2:9b","stream":false}'
/usr/bin/curl -s http://ollama_container:11434/api/pull -d '{"name":"gemma2:2b-instruct-q3_K_L","stream":false}'
/usr/bin/curl -s http://ollama_container:11434/api/pull -d '{"name":"gemma2:2b-instruct-q8_0","stream":false}'
/usr/bin/curl -s http://ollama_container:11434/api/pull -d '{"name":"llama3.1:8b-instruct-q4_K_M","stream":false}'
/usr/local/bin/streamlit run /usr/train_store/Digital_Commander_DCC.py --server.port=8080 --server.address=0.0.0.0 --browser.gatherUsageStats=false &
pid="$!"

while true
do
  sleep infinity & wait ${!}
done