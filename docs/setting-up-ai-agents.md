# Setting Up AI Agents

Tools for ChatGPT (Codex), Cursor, and Claude Code in this repo:

- [Spec Kit](https://github.com/github/spec-kit) — spec-driven development for ChatGPT (Codex) and Claude Code
- [Spec Kit for Cursor](https://github.com/madebyaris/spec-kit-command-cursor) — Cursor commands such as `/brief`, `/plan`, and `/implement`
- [caveman](https://github.com/juliusbrussee/caveman) — short replies, same technical content
- [RTK](https://github.com/rtk-ai/rtk) — compressed shell output
- [ponytail](https://github.com/dietrichgebert/ponytail) — smallest change that still solves the task

ChatGPT’s coding agent is Codex. There is no separate ChatGPT skill installer.

## Already installed here

| Tool | ChatGPT (Codex) | Cursor | Claude Code |
|------|-----------------|--------|-------------|
| Spec Kit | `.agents/skills/speckit-*` | [madebyaris/spec-kit-command-cursor](https://github.com/madebyaris/spec-kit-command-cursor) in `.cursor/commands`, `.cursor/agents`, `.cursor/skills/sdd-*`, and `.sdd` | `.claude/skills/speckit-*` |
| caveman | `~/.agents/skills/caveman*` | `~/.agents/skills/caveman*` | `~/.claude/skills/caveman*` |
| ponytail | `~/.agents/skills/ponytail*` | `~/.agents/skills/ponytail*` | `~/.claude/skills/ponytail*` |
| RTK | `~/.codex` hook + `RTK.md` | `~/.cursor/hooks.json` | `~/.claude/settings.json` hook |

Spec Kit lives in this repo. caveman, ponytail, and RTK are installed for the user, so they apply in this repo and in other repos.

Open a new chat after installing skills. The session that installed them does not load them until it restarts.

## Install again

Prerequisites: Git, Node.js, and `uv`.

```powershell
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

Windows RTK:

```powershell
winget install rtk-ai.rtk
```

### Spec Kit

ChatGPT (Codex) and Claude Code use GitHub Spec Kit. From the repo root:

```powershell
specify init --here --integration claude --force --ignore-agent-tools --script ps
specify integration install codex --force --script ps --integration-options="--skills"
specify integration status
```

In those agents, use `/speckit-constitution`, `/speckit-specify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-implement`, and `/speckit-converge`.

Cursor uses [spec-kit-command-cursor](https://github.com/madebyaris/spec-kit-command-cursor). Copy its `.cursor` commands, agents, rules, and `sdd-*` skills, plus `.sdd` and `.cursor-plugin`, into this repo. Do not install the `cursor-agent` Spec Kit integration; that is a different command set.

```powershell
git clone --depth 1 https://github.com/madebyaris/spec-kit-command-cursor.git $env:TEMP\spec-kit-command-cursor
```

In Cursor chat, start with `/brief`, then `/implement`. Larger work uses `/research`, `/specify`, `/plan`, `/tasks`, and `/implement`.

### caveman and ponytail

```powershell
npx skills add JuliusBrussee/caveman -g -a cursor -a claude-code -a codex -s * -y --copy
npx skills add DietrichGebert/ponytail -g -a cursor -a claude-code -a codex -s * -y --copy
```

Say `/caveman` or `/ponytail` in chat. `stop caveman` and `/ponytail off` turn them off.

### RTK

```powershell
rtk init -g --agent cursor
rtk init -g --agent claude --auto-patch
rtk init -g --codex
```

Cursor and Claude rewrite shell commands through a hook. Codex is told to prefix commands with `rtk`.

Telemetry stays off unless you opt in:

```powershell
rtk telemetry status
rtk telemetry disable
```

## Check

- [ ] `specify integration status` lists `claude` and `codex`, and not `cursor-agent`
- [ ] `.cursor/commands/brief.md` and `.cursor/skills/sdd-planning/SKILL.md` exist
- [ ] `rtk --version` and `rtk gain` both run
- [ ] `~/.agents/skills` and `~/.claude/skills` contain `caveman` and `ponytail`
- [ ] A new Cursor chat in this repo can see `/brief`. Claude and Codex can see `/speckit-specify`, `/caveman`, and `/ponytail`
