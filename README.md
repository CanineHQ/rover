# Rover Sidecar

`rover` is Canine's managed coding-agent sidecar image.

It is designed to:

- mount the same writable workspace volume as the user's development container
- stay alive and ready for Canine to exec coding-agent commands into it
- include a broad set of common developer tools without coupling the sidecar to a specific app stack
- provide pre-installed coding agents (Claude Code, Codex)

## Pre-installed Coding Agents

| Agent | Command | Required Env Var |
|-------|---------|-----------------|
| Claude Code | `claude` | `ANTHROPIC_API_KEY` |
| Codex | `codex` | `OPENAI_API_KEY` |

## Key Defaults

- workspace: `/workspace`
- entrypoint: `rover-entrypoint`
- default command: `sleep infinity`

## Build

```bash
docker build -f resources/sidecars/rover/Dockerfile.sidecar -t canine/rover-sidecar:dev resources/sidecars/rover
```

## Usage

API keys should be injected as environment variables when running the container:

```bash
docker run -d \
  -e ANTHROPIC_API_KEY=sk-ant-... \
  -e OPENAI_API_KEY=sk-... \
  -v workspace:/workspace \
  canine/rover-sidecar:dev
```

Then exec into the running container to invoke agents:

```bash
docker exec -it <container> claude --print "fix the failing tests"
docker exec -it <container> codex --quiet "add input validation"
```
