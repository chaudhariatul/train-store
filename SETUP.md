# Steps to setup up Local dev environment

This document is intended to setup a linux host as a local development machine for the **tech16-llm4biz-summer24** final project.

## Recommended hardware
||**Device**|**Recommended Config**|
|-|-|-|
|1.|Linux Host|Ubuntu 22.04|
|2.|CPU|4 cores or more|
|3.|Memory|16GB or more|
|4.|Storage|128GB or more|
|5.|GPU|12GB VRAM or more (eg. RTX3060)|

> [!NOTE]
> Follow the Ollama documentation for more details to setup on MacOS or Windows
> https://github.com/ollama/ollama

## Running Gemma2:2b and Llama3.1:8b models using Ollama

1. Verify docker service is running.
   ```bash
   docker info
   ```
2. Download ollama docker image.
   ```bash
   docker pull ollama/ollama:0.3.3
   ```
3. Start the ollama docker container.
   ```bash
   docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama_container ollama/ollama:0.3.3
   ```
4. Download `gemma2:2b` and `llama3.1:8b-instruct-q4_K_M` models.
    ```
    docker exec ollama_container ollama pull gemma2:2b
    docker exec ollama_container ollama pull llama3.1:8b-instruct-q4_K_M
    ```

## Test your local environment

1. Clone this repository
   ```bash
   git clone https://github.com/chaudhariatul/train-store.git
   ```
2. Setup local python dev environment
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install --upgrade pip
   pip install -r requirements.txt
   ```
3. Run the script to test your local environment
   ```bash
   python crepuscular_rays.py
   ```
    <details>
    <summary><b>A successful execution should look as shown below.</b> (Click to expand)</summary>

    > You're in luck! San Jose experiences beautiful sunsets with a good chance to catch some impressive crepuscular rays. Here's when and where:  
    >   
    > **Timing:**   
    >   
    > * **Dusk (Late Afternoon):**  This is the ideal time. You'll want to be heading out to places with clear skies around sunset, typically between 5 PM and 8 PM during the cooler months of October through May, and from 6 PM to 9 PM in June through September.  
    > * **Sunrise:** Depending on the season, you might get lucky and catch a glimpse of crepuscular rays as early as just before sunrise!   
    >   
    > **Where to Look:**  
    >   
    > Here are some spots known for good viewing:  
    >   
    > * **The San Francisco Bay Area:** Being so close to the coast, you can find great views in places like Shoreline Amphitheatre (especially during spring and fall), Coyote Hills Park, or even along Highway 1.  
    > * **Monterey Bay:** A bit of a drive, but worth it! The bay offers stunning sunsets with a chance for crepuscular rays.    
    > * **Open Areas:** Parks, beaches, and open fields offer expansive views for catching the best light during twilight hours.   
    >   
    > **Tips:**  
    >   
    > * **Check the Weather:** Clear skies are crucial! Look for reports of good conditions in the area.   
    > * **Time Your Visit:** Head out right after sunset for optimal viewing.   
    > * **Use Google Maps/Apps:**  You can see satellite imagery that shows you which direction the sun is setting from, and plan your route accordingly.  
    >   
    >   
    > Remember, these phenomena are a bit unpredictable. Be patient, keep an eye on the sky, and enjoy the wonder! Let me know if you have any other questions about San Jose or California!  
    </details>

4. Check processes running on the GPU and GPU memory usage with `nvidia-smi` command.
   ```
   +-----------------------------------------------------------------------------------------+
   | NVIDIA-SMI 550.54.15              Driver Version: 550.54.15      CUDA Version: 12.4     |
   |-----------------------------------------+------------------------+----------------------+
   | GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
   |                                         |                        |               MIG M. |
   |=========================================+========================+======================|
   |   0  NVIDIA GeForce RTX 3060        Off |   00000000:0B:00.0 Off |                  N/A |
   | 65%   59C    P2             66W /  170W |   10749MiB /  12288MiB |      0%      Default |
   |                                         |                        |                  N/A |
   +-----------------------------------------+------------------------+----------------------+
   
   +-----------------------------------------------------------------------------------------+
   | Processes:                                                                              |
   |  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
   |        ID   ID                                                               Usage      |
   |=========================================================================================|
   |    0   N/A  N/A    120709      C   ...unners/cuda_v11/ollama_llama_server       7842MiB |
   |    0   N/A  N/A    120829      C   ...unners/cuda_v11/ollama_llama_server       2900MiB |
   +-----------------------------------------------------------------------------------------+
   ```
