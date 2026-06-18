$ErrorActionPreference = "Stop"

$env:AI_MEMORY_HOST_DATA_DIR = "H:/ai-memory-data"
Set-Location "C:\Users\vitor\dev\tools\env"
docker compose up -d ai-memory
