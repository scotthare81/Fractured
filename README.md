# Thal'vaeth

**Solo survival-horror extraction on the AzerothCore WotLK 3.3.5a engine. Original IP.**

You are a **Remnant** — one of the last who still walks the Wild. Leave the **Thal'vaeth Monastery**, run a walled district (first: **Rotwood**), scavenge and survive, and extract before Hunger, Thirst, Infection, or a wound you can't stitch drops you. Death costs your **haul**, not your character. Then you go again.

> **Thal'vaeth** — engine only. Every player-facing name, item, and system is original IP (no WoW names in what players see).

## Design docs (canon) → [`docs/`](docs/)

**Survival & the loop**
- [SURVIVAL.md](docs/SURVIVAL.md) — Hunger · Thirst · Vigor · Infection
- [DIRECTOR.md](docs/DIRECTOR.md) — run pacing (the invisible Stress Director)
- [MAPS.md](docs/MAPS.md) · [RUN-GATES.md](docs/RUN-GATES.md) — Monastery, Rotwood, gates
- [CHAR-CREATE.md](docs/CHAR-CREATE.md) · [APTITUDES.md](docs/APTITUDES.md) — the Remnant + charms

**Creatures**
- [CREATURES.md](docs/CREATURES.md) · [CREATURE-JOURNAL.md](docs/CREATURE-JOURNAL.md)

**Items · crafting · gear · economy**
- [MATERIALS.md](docs/MATERIALS.md) → [CRAFTING.md](docs/CRAFTING.md) → [ITEMS.md](docs/ITEMS.md) → [GEAR.md](docs/GEAR.md)
- [ECONOMY.md](docs/ECONOMY.md) — no coin, tiered barter, item bulk
- [NAMES.md](docs/NAMES.md) — locked player-facing names · [CONTENT.md](docs/CONTENT.md) — item band + trades
- [TODO.md](docs/TODO.md) — open work

**Ops & process**
- [DEPLOY.md](docs/DEPLOY.md) — server isolation, ports, tree
- [REPO.md](docs/REPO.md) · [AGENT-INSTRUCTIONS.md](docs/AGENT-INSTRUCTIONS.md)

## Repo layout

| Path | What |
|------|------|
| `docs/` | Design canon (above) + ops |
| `thalvaeth-agent-handoff/` | Implementation package — C++ script stubs, pending SQL, ThalvaethUI addon (awaiting integration) |
| `src/mod-fractured/` | AzerothCore module skeleton |
| `scripts/` | Server-tree + module-link helpers |

## Build

Engine only — you need a full **AzerothCore 3.3.5a** checkout plus a client-data extract, with the Thal'vaeth module/scripts/SQL layered on top. See [`docs/DEPLOY.md`](docs/DEPLOY.md). Not buildable from this repo alone.

---

*The earlier co-op "ring network" design is retired; git history preserves it.*
