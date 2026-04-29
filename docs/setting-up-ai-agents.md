# Setting Up AI Agents

Single guide to set up two AI agents (`Cursor`, `GitHub Copilot`) with three feature tracks:
- SDD
- RTK AI
- caveman

Supports:
- Ubuntu
- Windows native (PowerShell/CMD)
- Windows with WSL (recommended for RTK)

## Section Index

- [1) Prerequisites](#1-prerequisites)
- [2) Setup Model (No Repetition)](#2-setup-model-no-repetition)
  - [2.1 SDD by Agent](#21-sdd-by-agent)
  - [2.2 RTK by Shell + Agent Delta](#22-rtk-by-shell--agent-delta)
  - [2.3 Caveman by Agent](#23-caveman-by-agent)
  - [2.4 Quick Matrix](#24-quick-matrix)
- [5) Copilot-Only Instructions](#5-copilot-only-instructions)
- [6) Verification Checklists](#6-verification-checklists)
- [7) Troubleshooting](#7-troubleshooting)

## 1) Prerequisites

- Git installed
- Node.js + npm/npx installed
- Terminal access (`bash` on Ubuntu/WSL, `PowerShell` or `CMD` on Windows native)

### SDD Source Links

- Cursor SDD source: [madebyaris/spec-kit-command-cursor](https://github.com/madebyaris/spec-kit-command-cursor?utm_source=chatgpt.com)
- Copilot SDD source: [github/spec-kit](https://github.com/github/spec-kit?utm_source=chatgpt.com)

### Prerequisite Bootstrap (if tools missing)

If `uv` is not installed:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

If `specify` is not installed:

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### SDD Init Command (Copilot flow)

Run in project root for Spec Kit (Copilot integration):

```bash
specify init --here --integration copilot
```

## 2) Setup Model

Pick shell context first:
- Ubuntu -> use `bash`
- Windows native -> use `PowerShell`/`CMD` (RTK limited)
- Windows WSL -> use `bash` (recommended for RTK)

### 2.1 SDD by Agent

#### Cursor (SDD toolkit model)

Reference:
- [madebyaris/spec-kit-command-cursor](https://github.com/madebyaris/spec-kit-command-cursor?utm_source=chatgpt.com)

```bash
git clone https://github.com/madebyaris/spec-kit-command-cursor.git
cd spec-kit-command-cursor
```

Open Cursor in repo, then run chat commands:
`/brief`, `/research`, `/plan`, `/tasks`, `/implement`

#### GitHub Copilot (Spec Kit CLI model)

Reference:
- [github/spec-kit](https://github.com/github/spec-kit?utm_source=chatgpt.com)

```bash
specify init --here --integration copilot
```

### 2.2 RTK by Shell + Agent Delta

Common install (Ubuntu/WSL, and optional on Windows native):

```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
rtk init -g
```

Agent delta:

```bash
# Cursor
rtk init -g --agent cursor

# Copilot
rtk init -g --copilot
```

Telemetry checks (both agents):

```bash
rtk telemetry status
rtk telemetry disable
rtk telemetry forget
rtk telemetry status
```

Windows native note:
> RTK has limited power on native Windows. Prefer WSL flow for full capability.

### 2.3 Caveman by Agent

```bash
# Cursor
npx skills add JuliusBrussee/caveman -a cursor

# GitHub Copilot
npx skills add JuliusBrussee/caveman -a github-copilot
```

### 2.4 Quick Matrix

| Area | Cursor | GitHub Copilot |
|------|--------|----------------|
| SDD source | `madebyaris/spec-kit-command-cursor` | `github/spec-kit` |
| SDD setup action | clone repo + use Cursor slash commands | `specify init --here --integration copilot` |
| RTK agent init | `rtk init -g --agent cursor` | `rtk init -g --copilot` |
| caveman install | `npx skills add JuliusBrussee/caveman -a cursor` | `npx skills add JuliusBrussee/caveman -a github-copilot` |

## 5) Copilot-Only Instructions

Use this section only for GitHub Copilot agent setup and behavior.

Full sample file in repo:
[`docs/samples/md/copilot-instructions.md`](samples/md/copilot-instructions.md)

## 6) Verification Checklists

### Agent Checklist

#### Cursor
- [ ] SDD toolkit repo cloned: `git clone https://github.com/madebyaris/spec-kit-command-cursor.git`
- [ ] Cursor opened in `spec-kit-command-cursor`
- [ ] SDD slash commands available (`/brief`, `/research`, `/plan`, `/tasks`, `/implement`)
- [ ] RTK initialized: `rtk init -g --agent cursor`
- [ ] caveman installed: `npx skills add JuliusBrussee/caveman -a cursor`
- [ ] telemetry sequence verified

#### GitHub Copilot
- [ ] SDD initialized: `specify init --here --integration copilot`
- [ ] RTK initialized: `rtk init -g --copilot`
- [ ] caveman installed: `npx skills add JuliusBrussee/caveman -a github-copilot`
- [ ] Copilot-only instructions applied
- [ ] telemetry sequence verified

### Shell/OS Checklist

- [ ] Ubuntu: use `bash`
- [ ] Windows native: use `PowerShell`/`CMD`, acknowledge RTK limitations
- [ ] Windows WSL: use `bash`, preferred path for full RTK capability

## 7) Troubleshooting

### `npx: command not found`

- Install Node.js and npm first.
- Restart shell and run:

```bash
npx --version
```

### `uv: command not found`

- Install `uv` and restart shell:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### `specify: command not found`

- Install Specify CLI with `uv`, then verify:

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify version
```

### `rtk: command not found`

- Re-run RTK install in shell where you plan to use it:

```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
```

- Restart shell session.

### Telemetry status not changing

- Re-run commands in order:

```bash
rtk telemetry status
rtk telemetry disable
rtk telemetry forget
rtk telemetry status
```

### Command works in WSL, fails in native Windows

- Expected for some RTK features.
- Use WSL for full RTK capability.

### Wrong shell context

- Ubuntu/WSL commands use `bash`.
- Windows native commands use `PowerShell` or `CMD`.
- If command fails, confirm shell type before retry.
