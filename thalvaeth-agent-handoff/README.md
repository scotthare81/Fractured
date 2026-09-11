# Thal'vaeth — Fractured

Survival-horror extraction on AzerothCore 3.3.5a.

**Git home:** [Fractured](https://github.com/scotthare81/Fractured) — **not** AiCraft-WotLK. See [docs/REPO.md](../docs/REPO.md).

## Quick start

```bash
chmod +x bootstrap.sh thalvaeth-agent-handoff/scripts/push-fractured.sh
./bootstrap.sh /path/to/Fractured ~/Wow/Interface/AddOns
```

## Layout

| Path | Contents |
|------|----------|
| `docs/` | Design + [NAMES.md](../docs/NAMES.md) + [CREATURES.md](../docs/CREATURES.md) |
| `server/sql/` | Pending world + characters SQL |
| `server/scripts/` | Creature AI, journal, Director stub |
| `client/addons/ThalvaethUI/` | Journal addon stub |
| `client/mpq/` | Sleeper recolor notes |

Agents: [docs/AGENT-INSTRUCTIONS.md](../docs/AGENT-INSTRUCTIONS.md)
