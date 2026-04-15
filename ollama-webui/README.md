# Local LLM Setup with Ollama + Open Web UI

### Install System Dependencies
I'm more of Arch-based OS guy, so I'll be using either `pacman` or `yay` to install the dependencies.
```
# Update system
sudo pacman -Syu

# Install Docker and NVIDIA Container Toolkit
sudo pacman -S docker nvidia-container-toolkit docker-compose

# Enable and start Docker service
sudo systemctl enable --now docker

# Configure NVIDIA container runtime
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

### Verify GPU Support in Docker
`docker run --rm --gpus all nvidia/cuda:12.4.1-runtime-ubuntu22.04 nvidia-smi`

### Launch the stack
```
docker compose up -d
docker ps
```

### Installing models
```
docker exec -it ollama ollama pull qwen2.5-coder:7b    # coding model
docker exec -it ollama ollama pull llama3.1:8b         # chat / reasoning
docker exec -it ollama ollama pull nomic-embed-text   # embeddings / RAG
```

### Verify Models and GPU
```
docker exec -it ollama ollama list
nvidia-smi
docker logs -f ollama

```

### Logs
```
docker logs -f open-webui 
docker logs -f ollama
```
