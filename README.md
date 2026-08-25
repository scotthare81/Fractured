# Fractured

**Survive the Wild. Corrupt. Break. Wake in Sanctuary and go again.**

Fractured is a private friend-project: horror survival on the AzerothCore
Wrath of the Lich King 3.3.5a engine. Player-facing content is original IP.
No Star Wars. No World of Warcraft names in what players see.

This repository is completely separate from AICraft (AiCraft-WotLK). Do not
add Fractured content there, do not mix ops, and do not configure or build
AzerothCore from this repo unless Scott asks later.

## Status

Documentation first. Design is locked in these files before any engine work.
v1.0 content ships complete before friend launch. Pacing is discovery and
gates, not content patches after people are already playing.

Repair broken docs: `bash bootstrap.sh`

## Team

Scott + about six friends. Async. Rarely online together. The loop has to
work when you play alone, and still work when two to four people happen to
be on.

## Engine

AzerothCore WotLK 3.3.5a — **engine only**. Custom items, instances, the Gate
script, Journal UI, and survival meters are Fractured work. They do not land
in AiCraft-WotLK.

## Core loop

**Survival is the tax.** Hunger, Thirst, and Corruption. Tight bags.
Forage-heavy. You are always managing a short clock and a small pack.

**The rest is the dividend.** Mystery. Sanctuary upgrades. Leads. Extraction.
The district network. The stalker.

You enter the Wild, learn something, haul what you can, and get out — or you
break, wake in the morgue, and go again. Character persists. Haul does not.

## Pillars (short)

- Discovery-first — no tutorial quest chain
- Everything findable uses or breaks into something that uses — no dead loot
- Journal Record logs what you learned, never what to do next
- Sanctuary = bots allowed; Wild = humans only, 2–4 co-op instanced
- Not permadeath — death has teeth, character persists

## Docs

| File | What it is |
|------|------------|
| [DESIGN.md](DESIGN.md) | Systems, design locks L1–L15, gate flow |
| [WORLD.md](WORLD.md) | District network, gates, expedition flow |
| [CONTENT.md](CONTENT.md) | Items, clones, crafting chains, MPQ |
| [docs/TODO.md](docs/TODO.md) | Open work |
| [docs/BRAINSTORM.md](docs/BRAINSTORM.md) | Conversation archive / repair reference |
| [docs/AGENT-INSTRUCTIONS.md](docs/AGENT-INSTRUCTIONS.md) | How future agents should work this repo |

`bootstrap.sh` regenerates the markdown files and `.gitignore` from the
canonical heredocs in this repo. If a paste handoff truncates a table, run
the seeder instead of repairing by hand.
