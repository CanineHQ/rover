# Rover Sidecar

`rover` is Canine's managed coding-agent sidecar image.

It is designed to:

- mount the same writable workspace volume as the user's development container
- stay alive and ready for Canine to exec coding-agent commands into it
- include a broad set of common developer tools without coupling the sidecar to a specific app stack
- provide pre-installed coding agents (Claude Code, Codex)

## Pre-installed Coding Agents

| Agent | Command |
|-------|---------|
| Claude Code | `claude` |
| Codex | `codex` |

## Key Defaults

- entrypoint: `rover-entrypoint`
- default command: `sleep infinity`

## Build

```bash
docker build -f Dockerfile.sidecar -t canine/rover-sidecar:dev .
```

## Usage

```bash
docker run -d canine/rover-sidecar:dev
```

Then exec into the running container to invoke agents:

```bash
docker exec -it <container> claude --print "fix the failing tests"
docker exec -it <container> codex --quiet "add input validation"
```
