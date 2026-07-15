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
```

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

Optional GPT consolidation: copy `.env.example` to `.env`, then enable `AI_MEMORY_LLM_PROVIDER=openai-oauth` and `AI_MEMORY_LLM_MODEL=gpt-5-mini`. Run `ai-memory auth login openai-oauth` once so token lands in the same data dir.

Recovery examples:

```powershell
# Use C: brain
$env:AI_MEMORY_HOST_DATA_DIR = "C:/ai-memory-data"
docker compose up -d ai-memory

# Use H: backup brain
$env:AI_MEMORY_HOST_DATA_DIR = "H:/ai-memory-data"
docker compose up -d ai-memory
```

## Ubuntu

1. Run `sudo apt-get update` and `sudo apt-get upgrade`
