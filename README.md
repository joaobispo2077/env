# env

## Windows

1. Run `Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine`

### ai-memory

Persistent brain lives outside Docker at `C:\ai-memory-data` by default.

This line in `docker-compose.yml` chooses the brain folder:

```yaml
volumes:
  - "${AI_MEMORY_HOST_DATA_DIR:-C:/ai-memory-data}:/data"
```

Meaning:

- default: use `C:\ai-memory-data`
- override: set `AI_MEMORY_HOST_DATA_DIR=H:/ai-memory-data` to use `H:\ai-memory-data`

This is manual failover, not automatic failover. Docker Compose will not switch from C to H by itself.

Start or recreate:

```powershell
cd C:\Users\vitor\dev\tools\env
docker compose up -d ai-memory
& .\windows\ai-memory-http-proxy.ps1
```

Agents and hooks stay on `http://127.0.0.1:49374`. Compose publishes the container on `127.0.0.1:49375`. The proxy script listens on 49374 and repairs Docker Desktop responses that claim chunked encoding and then send a raw body. Run the script again after a reboot; it exits if the proxy is already listening.

Shutdown behavior: Docker sends SIGTERM to ai-memory and waits `30s` (`stop_grace_period`) before force-kill. `restart: unless-stopped` brings it back when Docker Desktop starts again.

Use another brain path on another PC by copying `.env.example` to `.env` and changing `AI_MEMORY_HOST_DATA_DIR`.

Mirror C brain to H brain:

```powershell
& C:\Users\vitor\dev\tools\env\windows\ai-memory-backup-to-H.ps1
```

That script stops ai-memory, mirrors only durable state (`auth.json` + `db` + `wiki`) from `C:\ai-memory-data` to `H:\ai-memory-data`, then starts ai-memory again. This is the part that makes H have the same important data as C.

End-of-session habit: run this backup script before closing the day so `H:` has the latest brain.

Start from H brain if C dies:

```powershell
& C:\Users\vitor\dev\tools\env\windows\ai-memory-start-from-H.ps1
```

Learning uses the pinned image `akitaonrails/ai-memory:3.1.2`. Copy `.env.example` to `.env` and set `AI_MEMORY_LLM_PROVIDER=openai-oauth`. The ChatGPT account on this machine rejects `gpt-5.5`, `gpt-5.4-mini`, and `gpt-5-mini`. `AI_MEMORY_LLM_MODEL=gpt-6.1-sol` is the slug Codex already uses and the one `llm-test` accepted. `AI_MEMORY_EMBEDDING_PROVIDER=local` embeds the wiki without an API key. `AI_MEMORY_CONSOLIDATE_ON_SESSION_END=true` asks that model to rewrite a substantive session when it ends. Run `ai-memory auth login openai-oauth` once so the token lands in the data dir.

Recovery examples:

```powershell
# Use C: brain
$env:AI_MEMORY_HOST_DATA_DIR = "C:/ai-memory-data"
docker compose up -d ai-memory
& C:\Users\vitor\dev\tools\env\windows\ai-memory-http-proxy.ps1

# Use H: backup brain
$env:AI_MEMORY_HOST_DATA_DIR = "H:/ai-memory-data"
docker compose up -d ai-memory
& C:\Users\vitor\dev\tools\env\windows\ai-memory-http-proxy.ps1
```

## Ubuntu

1. Run `sudo apt-get update` and `sudo apt-get upgrade`
