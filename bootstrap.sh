#!/usr/bin/env bash
# Fractured doc seeder. Idempotent: safe to re-run. Overwrites the files below
# with the canonical design text. Does not touch AICraft / AiCraft-WotLK.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"
mkdir -p docs

# ---------------------------------------------------------------------------
# README.md
# ---------------------------------------------------------------------------
cat > README.md << 'FRACTURED_README'
# Fractured

**Survive the Wild. Corrupt. Break. Wake in Sanctuary and go again.**

Fractured is a private friend-project: horror survival on the AzerothCore
Wrath of the Lich King 3.3.5a engine. Player-facing content is original IP.
No Star Wars. No World of Warcraft names in what players see.

This repository is completely separate from AICraft (AiCraft-WotLK). Do not
add Fractured content there, do not mix ops, and do not configure or build
AzerothCore from this repo unless Scott asks later.

## Status

Design is locked enough to build a slice. The build sequence is
[docs/SLICE.md](docs/SLICE.md). **Current step: 2 — module skeleton.**
Step 1 isolation is agreed ([docs/DEPLOY.md](docs/DEPLOY.md)).

v1.0 content still ships complete before friend launch. Pacing is
discovery and gates, not content patches.

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
| [docs/SLICE.md](docs/SLICE.md) | Build sequence (one step at a time) |
| [docs/DEPLOY.md](docs/DEPLOY.md) | Step 1: isolate the server from AICraft |
| [docs/BRAINSTORM.md](docs/BRAINSTORM.md) | Conversation archive / repair reference |
| [docs/AGENT-INSTRUCTIONS.md](docs/AGENT-INSTRUCTIONS.md) | How future agents should work this repo |

`bootstrap.sh` regenerates the markdown files and `.gitignore` from the
canonical heredocs in this repo. If a paste handoff truncates a table, run
the seeder instead of repairing by hand.
FRACTURED_README

# ---------------------------------------------------------------------------
# DESIGN.md
# ---------------------------------------------------------------------------
cat > DESIGN.md << 'FRACTURED_DESIGN'
# Fractured — Design

This file is the systems source of truth. Numbers that are not decided yet
are marked TBD. Everything else is a lock or a working rule, not a stub.

Fractured is a private friend-project on AzerothCore WotLK 3.3.5a (engine
only). Player-facing names, lore, and UI copy are original IP.

## Pitch

Survive the Wild. Corrupt. Break. Wake in Sanctuary and go again.

Survival (Hunger / Thirst / Corruption, tight bags, forage-heavy) is the
**tax**. Mystery, Sanctuary upgrades, leads, extraction, the zone network,
and the stalker are the **dividend**.

Team: Scott + about six friends, async, rarely online together. Launch rule:
all v1.0 content exists before friend launch. Pacing is discovery and gates,
not drip-fed content patches.

## Pillars

### Discovery-first

There is no tutorial quest chain. The world teaches by being used. Signs,
corpses, recipes, failed gates, and the Journal Record are how you learn.
A new player is allowed to be lost. They are not allowed to be told the
checklist.

### Everything findable uses or breaks→uses

No dead loot. If it can be picked up, it has a use, or it breaks, salvages,
or cooks into something that has a use. Vendor trash as a design category
does not exist in the Wild.

### Journal Record

The Journal logs what you **learned**, after you figured it out. It never
tells you what to do next. No quest-style “go do X.” No tracked objectives
that pull you across the map. The Record is a notebook, not a quest log.

### Sanctuary vs Wild

- **Sanctuary:** bots allowed. Safe hub. Storage, crafting, morgue, Gate UI.
- **Wild:** humans only. 2–4 co-op. Instanced districts. Playerbots are
  blocked at the Gate.

### Not permadeath

Death has teeth. The character is not deleted. You lose the haul, take a
Corruption spike, wake with **Fractured** (temporary, tuning TBD), and
continue from the Sanctuary morgue.

## Death and recovery

| On death | Effect |
|----------|--------|
| Character | Not deleted |
| Haul | Lost (corpse vs morgue rules TBD) |
| Corruption | Spike |
| Debuff | Fractured (temporary, tuning TBD) |
| Wake | Sanctuary morgue |

Return paths from the Wild:

1. **Portal** — a way home you brought or found.
2. **Relay node** — a district that functions as extraction / return.
3. **Death** — wake in the Sanctuary morgue.

Corpse running vs morgue-only recovery is still open (see `docs/TODO.md`).
Until that is decided, design as if the haul is gone when you die, and the
body is not a reliable second inventory.

Death is the expensive way home. It should feel like a real failure without
ending the character.

## Survival meters

Three meters matter in the Wild: **Hunger**, **Thirst**, **Corruption**.
They are the tax. If they are generous, the dividend (mystery, extraction,
stalker, network) has nothing to push against.

### Hunger and Thirst

- Restores are **potion-like and partial**. A stew does not fill you. Water
  does not quench you for the whole expedition. You keep eating and drinking.
- Consume is **sit / channel**, not insta-chug. You are vulnerable while you
  eat. That is intentional.
- Exact restore percents, channel times, and decay rates are TBD.

### Forage

- Forage is **free everywhere**. You can always try to pull food from the
  world. Yield and risk change by district.
- Meats are **species-specific**: venison, pork, and the rest — not a single
  generic “raw meat” if the creature is a named forage beast.
- **Spoilage** exists. Raw meat goes bad. Cooked food lasts longer. Exact
  timers TBD.

### Corruption

- Rises while you are in the Wild.
- Gates may require a **tolerance** — too clean or too rotten can lock a
  path. The rule is “knowledge + loadout + Corruption,” not character level.
- **Death spikes** Corruption.
- Purification is diegetic: tea, waders, wards — not a spellbook cleanse
  button. Districts teach the methods (Ash tea chain, Drown waders, Ward
  craft).

### Bags

Start tiny. Cap still small. Stacks are hostile.

| Slot / stack | Working number |
|--------------|----------------|
| Starting bag slots | ~6 |
| Bag cap | ~20–24 |
| Meat stack | ~5 |
| Stew stack | ~3 |
| Water stack | ~4 |

These numbers can move in playtest, but the *intent* is locked: you cannot
haul a supermarket. Every slot is a decision between food, water, tools,
leads, and extraction.

## Crafting (no skill levels)

There are no cooking levels, no fieldcraft skill ranks, and no apothecary
profession grind. Quality and knowledge replace XP bars.

### Cooking

- Ingredient **quality in** shapes **quality out**.
- **Model C (weighted):** from the same recipe and quality band, results
  land roughly **70% standard / 20% good / 10% best**.
- No cooking levels. A desperate Sanctuary stew and a careful Wild cook use
  the same rules with different ingredients.

### Fieldcraft

Butcher, tan, salvage, mend. Carcasses become meat, hide, and bone. Hide
becomes wraps and leather. Salvage feeds mend and rope. Full break/make
graph is open work (`docs/TODO.md`).

### Apothecary

Tincture, tea, salve, ward. Herbs, ash, and salt are the base language.
District blooms feed gate teas. Salves and wards are how you survive Cut,
Hive, Static, Burn, and Ward without a class rotation.

## Sanctuary

Sanctuary is the safe hub. Playerbots are allowed here. This is where the
async team lives between expeditions: stash, cook, read the Record, stare
at the Gate.

Upgrades are TBD as a list, but the functions are not optional flavor:

| Function | Role |
|----------|------|
| Storage | Park haul that survived the trip |
| Crafting | Cook, fieldcraft, apothecary without Wild pressure |
| Morgue | Wake point after death |
| Gate UI | Choose / confirm an expedition |

The **Gate object** launches expeditions. Bots are **blocked at the Gate**.
They do not enter the Wild. They do not fake co-op. If you go out, you go
as a human party of one to four.

## Wild

- Humans only.
- **2–4 co-op**, instanced.
- Districts are a **parallel network**, not one linear corridor. The old
  line Threshold → Thorn → Ruins → Deep is dead. See `WORLD.md`.
- **AutoBalance** on instances. **MinPlayers = party size.**
- Gates care about **knowledge + loadout + Corruption tolerance**, not
  character level.

Instancing is how async friends share a world without sharing a session.
Two groups can be in Cut at once. They do not steal each other’s corpses
or spoil each other’s stalker.

### AutoBalance note

Wild districts use AutoBalance with MinPlayers equal to the party that
opened the expedition. AB counts **Player** objects in the instance.

Out of scope for this repo (AICraft only): Scott ran Molten Core with
himself + 9 bots and it felt too easy. That is likely a pull-time count
or AB tuning issue in **AiCraft-WotLK**, not a Fractured task. Do not
“fix AB” here by copying AICraft raid assumptions. Fractured Wild groups
are 2–4 humans and no bots.

## Journal — Record

The Record auto-logs discoveries **after** you figure them out.

Examples of what it may write:

- You butchered a deer and the meat was venison, not “meat.”
- You drank a bitter Ash tea and Corruption eased.
- A Gate refused you until your loadout included wraps.

Examples of what it must never write:

- “Go to Cut and loot three bandages.”
- “Next objective: find the Relay.”
- A glowing path to the current designer-intended beat.

Leads and mystery payoffs live in the world and in the player’s head. The
Record is evidence, not a quest helper.

## Stalker

Persistent Wild pressure. Tied to **Corruption and/or depth**. Dread over
jump-scares. The stalker is a reason to leave, not a rare spawn to farm.

Shades (working creature family) are the visible edge of this pressure.
Audio in Quiet is the first lesson. Later districts teach that ignoring
Corruption is how the stalker gets a vote.

Exact spawn rules, leash, and whether the stalker can follow through a
gate are TBD. The lock is the *role*: always-on unease, scaled with how
rotten and how deep you are.

## Design locks L1–L15

These are not suggestions. Changing one is a design meeting, not a silent
tweak in a module.

| # | Lock |
|---|------|
| L1 | No character delete on death |
| L2 | Lose haul; Corruption spike; Fractured debuff; morgue wake |
| L3 | Food/water partial restore; sit/channel consume |
| L4 | Cooking quality in → weighted out; no cooking levels |
| L5 | Free forage; species meats; spoilage |
| L6 | Minimal bags; tiny stacks |
| L7 | All findable loot uses or breaks→uses |
| L8 | Fieldcraft + Apothecary; no skill levels |
| L9 | Discovery-first; no tutorial chain |
| L10 | Journal Record — learned facts only |
| L11 | Bots Sanctuary-only; Wild humans-only |
| L12 | AutoBalance on Wild; MinPlayers = party size |
| L13 | Gates: knowledge + loadout + Corruption — not level |
| L14 | v1.0 complete before friend launch |
| L15 | Original IP player-facing |

## Gate flow (v1)

Login → Sanctuary → interact Gate → load Mouth (Threshold) → four visual
paths → Ring 1 and beyond.

| Who | How an expedition starts |
|-----|--------------------------|
| Solo | The player opens the expedition |
| Co-op | Party leader opens (confirm UX TBD) |
| Bots | Blocked at the Gate |

Return: portal, Relay, or death → morgue.

v1 Gate is a **Sanctuary object**, not a world portal spam. You commit to
an instance. The Mouth is the shared foyer: four visual paths toward Cut,
Ash, Salt, and Quiet. You still need knowledge, loadout, and Corruption
tolerance to *use* a path, even if you can see it.

Threshold layout of those four paths is open work. The flow is not.

## Relationship to AICraft

Fractured is a **separate project**. AICraft ops, modules, raid test
habits, and bot-heavy tuning live in **AiCraft-WotLK only**.

Do not:

- Commit Fractured SQL, scripts, or MPQ notes into AiCraft-WotLK.
- Treat “Scott + 9 bots in MC” as a Fractured balance target.
- Share deploy pipelines until Scott asks for a Fractured module skeleton
  with its own path.

Do:

- Use AzerothCore 3.3.5a as an engine.
- Keep this repo as documentation-first until implementation is requested.
- When implementation starts, keep it out of the AICraft tree.

## What “done” means for v1.0

Friend launch is not a slice. L14 says the content is in: districts,
gates, survival, stalker pressure, Journal Record, Sanctuary functions,
clone items, and MPQ tier A at minimum. Discovery and gates pace how
friends *find* it. We do not hold districts back as a post-launch patch
plan.
FRACTURED_DESIGN

# ---------------------------------------------------------------------------
# WORLD.md
# ---------------------------------------------------------------------------
cat > WORLD.md << 'FRACTURED_WORLD'
# Fractured — World

The Wild is a **parallel district network**, not a linear corridor.

The old line **Threshold → Thorn → Ruins → Deep** is retired. Do not
revive it as the spine. Friends should be able to commit to different
Ring 1 districts in parallel, then reconverge through knowledge, loadout,
and Corruption — not through a single mandatory hallway.

About **29 spaces** in v1.0: Sanctuary, Mouth, twelve surface districts
across Rings 1–4, and twelve underlayers (one under each Ring 1–3
surface district).

## Rings

| Ring | Districts |
|------|-----------|
| Hub | Sanctuary |
| 0 | Threshold / Mouth |
| 1 (parallel) | Cut, Ash, Salt, Quiet |
| 2 | Drown, Hive, Relay, Pit |
| 3 | Sink, Static, Burn, Ward |
| 4 | Deep, Nursery, Edge |
| Under | 12 underlayers (one under each Ring 1–3 surface district) |

Ring 1 is the fork. You can see four ways out of the Mouth. You cannot
treat them as a sequence you must finish in order. Ring 2+ opens as
knowledge, kit, and Corruption allow — including teas and tools born in
other districts.

Underlayers are not a secret 13th linear zone. Each is tied to a specific
Ring 1–3 surface. Names for the twelve underlayers are TBD (`docs/TODO.md`).

## District hooks

These hooks are play intent, not flavor blurbs. If a district does not
teach its hook, it is unfinished.

### Cut

Bleed and wraps. Bandages and salve matter here first. The district
teaches that you will leak, and that fieldcraft (hide → wraps) and
apothecary (salve) are how you stop leaking. Knife and cleaver earn their
slot.

### Ash

Ashbloom. Tea chain starts here. Purification is not a Sanctuary button;
it is a plant you had to notice, pick, and cook into tea. Ash is the
Corruption-management classroom.

### Salt

Preservation and dehydration. Salt is why meat can live in a bag longer
and why Thirst can betray you. The district teaches stacks, spoilage, and
the cost of carrying water vs carrying a preservative.

### Quiet

Stalker intro. Low audio. This is where dread is allowed to be quiet
instead of loud. You learn that the Wild is watching before later
districts make that pressure mechanical and heavy.

### Drown

Water. Waders plus purification tea. You cannot brute-force the wet
districts with food alone. Drown is the first place “loadout” means
clothes and a tea, not a bigger weapon.

### Hive

Swarm. Hive mask and spore ward. Breathing is a slot. The Mask of the
Unforgiven *model* (not the WoW name) is the clone direction for the
mask. Hive without a ward is a lesson you only want once.

### Relay

Extraction / return node. This is how you get home without dying. Relay
is a dividend space: you went deep enough, or sideways enough, to find a
door that is not the morgue. Treat it as a strategic objective, not a
vendor hub.

### Pit

Vertical space, falls, rope and salvage. Pit teaches that Fieldcraft is
not only butchering. Rope, mend, and not walking off a ledge are the
curriculum.

### Sink

Mud. Waders plus the Drown tea chain. Sink is a sequel, not a reskin:
you needed Drown’s language to stay here. Gates should be allowed to
demand that.

### Static

Sensory horror. Ward and grounding salve. Sound and sight go wrong.
This is not a jump-scare closet; it is a district that punishes an empty
apothecary pouch.

### Burn

Heat. Heat salve and water crunch. Thirst is the tax collector. Burn
should make the ~4 water stack feel cruel, and make “I brought tea
instead of a third stew” a real build.

### Ward

Protective lore and ward crafting. The district that explains why wards
are a language, not a trinket stat stick. Named with care: player-facing
copy must stay original IP even if the working title is “Ward.”

### Deep

Surface end. Multi-district tea complete. Deep is a gate that asks
whether you actually learned Ash / Drown / Ward rather than speed-ran
one favorite Ring 1.

### Nursery

Origin mystery. Dividend, not a farm. Leads should pay off here without
the Journal turning into a quest log.

### Edge

Boundary finale. The network has a wall. Edge is where the map admits it.

## Sanctuary (hub)

Not a Wild district. Bots allowed. Gate lives here. Morgue lives here.
See `DESIGN.md` for hub functions. Sanctuary is the only place the async
group is meant to overlap without an expedition.

## Gate examples

Gates are **knowledge + loadout + Corruption tolerance**, not character
level (L13). The table below is a working example set for v1, not a
final matrix. The full flag/item matrix is open work.

| From | Toward | Knowledge (Journal / world) | Loadout | Corruption tolerance |
|------|--------|-----------------------------|---------|----------------------|
| Sanctuary | Threshold / Mouth | None (always open) | None | None |
| Mouth | Cut | Saw the Cut path / bleed sign | Knife or wraps | Low |
| Mouth | Ash | Ash sign or ashbloom notice | Tea kit or empty vial | Low |
| Mouth | Salt | Salt crust / preservation sign | Spare bag slot or jar | Low |
| Mouth | Quiet | Chose the quiet path | None (first stalker lesson) | Low |
| Cut | Pit | Vertical scar / rope tale | Rope or salvage kit | Low–mid |
| Ash | Ward | Tea that was not just food | Ashbloom tea or ward focus | Mid |
| Salt | Drown | Water vs salt lesson | Waterskin | Mid |
| Quiet | Hive | Something listening / swarm hint | Cloth to cover face | Mid |
| Drown | Sink | Mud beyond water | Waders + Drown tea | Mid–high |
| Hive | Static | Spores were only the first sense | Hive mask or spore ward | Mid–high |
| Relay | Sanctuary | Found the return node | None (extraction) | Any |
| Pit | Deep approach | Survived the drop | Mend kit | High |
| Multi | Deep | Teas from more than one district | Completed tea set (working) | High |
| Multi | Nursery | Origin leads | Record has the right facts | High |
| Multi | Edge | Boundary signs | Ward + extraction plan | High |

“Low / mid / high” Corruption bands are TBD as numbers. The structure
is the lock: a Gate may refuse a character who is too clean, too rotten,
or missing a tool they should have understood by now.

Solo: the player opens the expedition. Co-op: party leader opens
(confirm UX TBD). Bots: blocked at the Gate.

## Expedition flow

```
                         +---------+
                         |  Login  |
                         +----+----+
                              |
                              v
                    +-------------------+
                    |     Sanctuary     |
                    |  bots allowed     |
                    |  storage / cook   |
                    |  morgue / Gate UI |
                    +---------+---------+
                              |
                     interact Gate object
                              |
                              v
                    +-------------------+
                    |       Gate        |
                    |  bots blocked     |
                    |  solo: player     |
                    |  co-op: leader    |
                    +---------+---------+
                              |
                        load instance
                              |
                              v
                    +-------------------+
                    | Threshold / Mouth |
                    |  four visual paths|
                    +---------+---------+
                              |
              +---------------+---------------+---------------+
              |               |               |               |
              v               v               v               v
           +-----+         +-----+         +-----+         +------+
           | Cut |         | Ash |         | Salt|         |Quiet |
           +--+--+         +--+--+         +--+--+         +--+---+
              |               |               |               |
              |               Ring 1 parallel districts       |
              +---------------+---------------+---------------+
                              |
                              v
              Ring 2: Drown, Hive, Relay, Pit
                              |
                              v
              Ring 3: Sink, Static, Burn, Ward
                              |
                              v
              Ring 4: Deep, Nursery, Edge

Return: portal -----> Sanctuary
        Relay  -----> Sanctuary
        death  -----> Sanctuary morgue
```

Each Ring 1–3 surface district has **one underlayer** beneath it (12
total). Underlayers are reached from their parent surface, not from a
global elevator in Sanctuary.

## WotLK map / instance IDs

All IDs are TBD. Do not invent live map IDs until Scott assigns them.
This table is the checklist so implementation does not “just reuse
Scarlet Monastery” without writing it down.

| Space | Ring | Map ID | Instance template | AutoBalance | Notes |
|-------|------|--------|-------------------|-------------|-------|
| Sanctuary | Hub | TBD | TBD | No (not Wild) | Hub; bots allowed |
| Threshold / Mouth | 0 | TBD | TBD | Yes | Foyer; four paths |
| Cut | 1 | TBD | TBD | Yes | Bleed / wraps |
| Ash | 1 | TBD | TBD | Yes | Ashbloom / tea |
| Salt | 1 | TBD | TBD | Yes | Preserve / dehydrate |
| Quiet | 1 | TBD | TBD | Yes | Stalker intro |
| Drown | 2 | TBD | TBD | Yes | Waders + tea |
| Hive | 2 | TBD | TBD | Yes | Mask / spore ward |
| Relay | 2 | TBD | TBD | Yes | Extraction node |
| Pit | 2 | TBD | TBD | Yes | Vertical / rope |
| Sink | 3 | TBD | TBD | Yes | Mud; Drown sequel |
| Static | 3 | TBD | TBD | Yes | Sensory horror |
| Burn | 3 | TBD | TBD | Yes | Heat / water |
| Ward | 3 | TBD | TBD | Yes | Ward craft / lore |
| Deep | 4 | TBD | TBD | Yes | Surface end |
| Nursery | 4 | TBD | TBD | Yes | Origin mystery |
| Edge | 4 | TBD | TBD | Yes | Boundary finale |
| Underlayer (×12) | 1–3 | TBD | TBD | Yes | One per Ring 1–3 surface |

MinPlayers = party size for every Wild instance. AB counts Player
objects. No bots in these instances (L11, L12).

## Player-facing naming

Working titles in this file (Cut, Ash, Mouth, Sanctuary, Fractured) are
dev names. They may ship if they stay original. They must **not** be
replaced with WoW zone names, dungeon names, or creature names in UI,
map, chat, or quest-like text.

- No “Elwynn,” “Stranglethorn,” “Scarlet,” “Lich King,” class names as
  flavor, or item names copied from Wowhead.
- Clone **models and IDs** in data; clone **names** never.
- AreaTable renames (MPQ Tier C) exist specifically so the client does
  not flash a Blizzard toponym.

If a designer needs a placeholder, use the district hook word, not a WoW
pun. See `CONTENT.md` for clone-vs-name rules.

## How the network should feel

You are not walking a theme-park queue. You are choosing a wound.

Ring 1 is four different first mistakes. Ring 2 is where those mistakes
grow tools (waders, mask, rope, Relay). Ring 3 asks you to combine them.
Ring 4 is payoff and boundary. Underlayers are the “we went back and
looked down” spaces for friends who share notes async.

Extraction (Relay / portal) is a skill. Death is always available and
always expensive.
FRACTURED_WORLD

# ---------------------------------------------------------------------------
# CONTENT.md
# ---------------------------------------------------------------------------
cat > CONTENT.md << 'FRACTURED_CONTENT'
# Fractured — Content

Items, creatures, crafting chains, and client patch (MPQ) notes. Player-
facing names and stats are original. Visuals may clone obscure WotLK
assets.

Do not commit this work into AiCraft-WotLK. Custom items SQL, instance
templates, Gate script, Journal UI, and the survival meter module are
Fractured implementation, later, in this project’s own tree.

## Visual philosophy

Clone **obscure** WotLK assets. Rename, re-stat, re-icon. Avoid iconic
WoW silhouettes that a friend will name on sight (Ashbringer-class
weapons, raid tier shapes, famous helm models).

Starter gear is **patchwork / ragged**. You look like you were issued a
Sanctuary kit or you found something that already failed once. Power
fantasy armor is a Wild dividend, and even then it should look worn.

MPQ exists so the client can lie in our favor: load screens, survival
icons, zone music, optional AreaTable renames. The engine is WotLK; the
brochure is Fractured.

Rules of thumb:

- If a friend would say the WoW item name out loud, pick a different
  model.
- If the item is a tool (knife, cleaver, waders), the silhouette should
  read as a tool, not as a dungeon drop.
- Icons for Hunger / Thirst / Corruption must not be reused Blizzard
  raid-debuff art if we can ship our own (MPQ Tier A).

## Item clone sources

IDs are WotLK 3.3.5a references for **display / starting point**, not
player-facing names. Final Fractured names TBD (`docs/TODO.md`).

| Role | WotLK ID / ref | Use |
|------|----------------|-----|
| Knife | 5278 | Butcher / fieldcraft |
| Machete | 1219 | Brush / light combat |
| Cleaver | 2827, 1292 | Heavy butcher |
| Starter armor | patchwork / ragged | Sanctuary issue or find |
| Hive mask | Mask of the Unforgiven model | Hive spore ward |
| Waders | TBD lowbie leather/cloth | Drown / Sink |
| Ward focus | TBD off-hand/trinket | Static / Ward |

Notes on the clone list:

- **5278** is a small knife energy: butcher first, fight second.
- **1219** is a brush-cutter: path-making and light combat, not a main
  tank stick.
- **2827** and **1292** are “this was a kitchen or a murder” cleavers.
  Heavy butcher. Slow. Earns the meat slot.
- Patchwork / ragged starter armor should be issuable in Sanctuary and
  findable in the Mouth so a corpse run (if any) does not require a
  fully naked tutorial.
- Hive mask uses the Unforgiven **model only**. Name it as a hive /
  spore piece in original IP. Stats are Fractured, not the dungeon item.
- Waders are a loadout Gate key for Drown and Sink. Pick the dullest
  lowbie leather/cloth that still reads as “I dressed for wet.”
- Ward focus is an off-hand or trinket that makes ward craft and Static
  survivable. TBD ID on purpose: do not grab a famous relic model.

Every findable item still obeys L7: it uses, or it breaks into something
that uses.

## Creatures

All player-facing names TBD. Stats new. Do not ship “worg” in the UI.

| Working family | Role | Notes |
|----------------|------|-------|
| Shades | Stalker edge | Persistent pressure; dread; Corruption/depth |
| Worg analogs | Wild predators | Combat tax; hides / meat if butchered |
| Spiders / swarms | Hive language | Spore, wrap, panic; mask/ward payoff |
| Boar analogs | Forage beasts | Pork; aggression while you butcher |
| Deer analogs | Forage beasts | Venison; flight more than fight |
| Rabbit analogs | Forage beasts | Small meat; teaches spoilage and tiny stacks |

Forage beasts exist so Hunger is not a vendor problem. Species-specific
meats are the point (L5). Swarms exist so Hive is not “more wolves.”
Shades exist so Quiet is not an empty audio test.

Elite / rare / named mystery creatures belong to the lead pool, not to
this table. Do not fill the Wild with rare-farm targets that ignore
bags and spoilage.

## Consumables

All sit / channel unless a later note says otherwise. Partial restore
(L3). Tiny stacks (L6).

| Consumable | Stack (working) | Role |
|------------|-----------------|------|
| Raw meat (species) | ~5 | Spoils; cooks; Hunger tax |
| Stew | ~3 | Better than raw; still partial |
| Water | ~4 | Thirst; Burn makes this cruel |
| Tea | TBD | Corruption / district gates |
| Tincture | TBD | Apothecary base / travel dose |
| Salve | TBD | Cut, Burn, Static, mend-adjacent |
| Ward | TBD | Hive, Static, Ward district language |

Raw meat spoils. Stew lasts longer. Salt (district + crafting) is how
you fight the timer without winning it. Exact timers TBD.

There is no insta-chug health potion as a primary Wild plan. If a
tincture ever breaks sit/channel, that is an exception that must be
written down — default is channel and be vulnerable.

## Fieldcraft chain (sketch)

Full break/make table is open work. This is the spine so items have
somewhere to go.

```
                    carcass (forage beast or predator)
                              |
                           butcher
                              |
              +---------------+---------------+
              |               |               |
              v               v               v
            meat            hide            bone
              |               |               |
              |               tan             salvage
              |               |               |
              v               v               v
           cook /           wraps /         needle /
           spoil            leather         broth / rope
                              |
                            mend
                              |
                              v
                    repaired kit / rope
```

Paths:

- **Butcher** — knife or cleaver. Yield depends on tool and creature.
- **Tan** — hide → wraps (Cut) and leather scraps (mend, maybe waders
  repair).
- **Salvage** — bone and junk → needle, broth base, rope bits (Pit).
- **Mend** — spend scraps to keep the loadout alive. No skill levels.

Nothing on this graph is vendor trash. If a node has no consumer, cut
it or give it a consumer (L7).

## Apothecary chain (sketch)

```
         herb + ash + salt  --->  tincture (base)
                                      |
          district blooms ------------+
                                      |
              +-----------------------+-----------------------+
              |                       |                       |
              v                       v                       v
        gate teas                  salves                   wards
     (Ash, Drown, …)         (Cut, Burn, Static)      (Hive, Static, Ward)
```

- **Tincture** — the portable apothecary unit. Travel dose, not a raid
  flask.
- **District blooms** — Ashbloom and the rest. These feed **gate teas**
  so Corruption tolerance and district doors are crafted, not dinged.
- **Salve** — bleed, heat, grounding. Sit/channel to apply unless TBD
  says combat-usable for Cut specifically.
- **Ward** — crafted protection. Hive mask is adjacent (gear) but the
  ward item is the apothecary sentence.

Deep’s “multi-district tea complete” gate is the payoff for this chain
existing across the network, not a reagent vendor in Sanctuary.

## Cooking Model C

Same recipe, same quality band of ingredients:

| Result | Weight |
|--------|--------|
| Standard | 70% |
| Good | 20% |
| Best | 10% |

Quality in still matters: a poor carcass does not roll on the same band
as a careful butcher of a fresh deer. Model C is the *weighted spit*
after the band is chosen. There are **no cooking levels** (L4).

Stew is the named cooked output in the bag rules (~3 stack). Other
cooked forms may exist; they must still sit/channel and restore
partially.

## MPQ manifest

Client patch work is staged so we do not boil the ocean before friends
can log in. File lists inside each tier are TBD; the tiers are not.

### Tier A (ship for v1.0 feel)

- Load screens (Sanctuary, Mouth, representative Wild)
- Survival meter icons (Hunger, Thirst, Corruption)
- Core item icons (knife, stew, water, tea, salve, ward, wraps)

### Tier B (audio identity)

- District music (Quiet first, then the rest)
- Creature sounds (shades, swarms, forage beasts)

### Tier C (name hygiene and polish)

- AreaTable names (no WoW toponyms)
- Minimap
- Journal UI skin

Tier A is the minimum that makes the client feel like Fractured instead
of a misnamed private server. Tier C is how L15 stays true when someone
opens the map.

Do not store large MPQ binaries in this git repo. `.gitignore` already
excludes `*.mpq`. Lists and notes live here; blobs live elsewhere.

## Implementation notes (future)

When Scott asks for engine work, expect roughly:

| Piece | Where it lives | Do not |
|-------|----------------|--------|
| Custom items SQL | Fractured data, not AICraft | Do not PR into AiCraft-WotLK |
| Instance templates | Per-district; IDs from WORLD.md table | Do not silently reuse famous instances |
| Gate script | Sanctuary object; bot block; party leader | Do not allow playerbots through |
| Journal UI | Record only; no quest tracker | Do not add objectives |
| Survival meter module | Hunger / Thirst / Corruption | Do not use raid-debuff UX as the metaphor |

Deploy pipeline is separate from AICraft (`docs/TODO.md`). Documentation
in this repo stays the source of truth until those modules exist.

Bag sizes, stack sizes, and clone IDs above are working numbers. Change
them in playtest; do not “fix” them by restoring retail bag culture.
FRACTURED_CONTENT

# ---------------------------------------------------------------------------
# docs/TODO.md
# ---------------------------------------------------------------------------
cat > docs/TODO.md << 'FRACTURED_TODO'
# Fractured — Open work

Build sequence lives in `docs/SLICE.md`. Do not skip ahead.

TBD belongs on **numbers and IDs**, not on whether a system exists.
Uncheck as documents (or later modules) actually land. Do not delete a
line to make the project look finished.

## Design still to write

- [ ] **Material graph** — full break/make table (every findable → use
      or break→use). Fieldcraft and apothecary sketches in `CONTENT.md`
      are spines, not the graph.
- [ ] **Gate matrix** — journal flags + items → district. Expand the
      example table in `WORLD.md` into a complete, testable matrix.
- [ ] **Lead pool** — mystery beats + payoffs (Nursery and side leads).
      Record logs facts after the fact; the pool is what those facts
      are *about*.
- [ ] **Sanctuary upgrade costs** — storage, crafting, morgue, Gate UI
      as a progression, with costs that respect tiny bags.
- [ ] **Corruption / stalker tuning** — rise rate, death spike, depth
      scaling, Quiet vs later districts, whether the stalker crosses
      gates.
- [ ] **Corpse vs morgue recovery** — is the haul always gone, or is
      there a corpse with teeth? L2 says haul is lost; the fiction of
      the body is still open.
- [ ] **Co-op Gate UX** — party leader opens; what everyone else sees;
      ready check or not; someone connecting late.
- [ ] **WotLK map / instance IDs per district** — fill the TBD columns
      in `WORLD.md`. Including 12 underlayers.
- [ ] **District bible** — one-pager each for Sanctuary, Mouth, 15
      surface districts, and 12 underlayers (mood, hook, forage, gate
      in/out, stalker pressure).
- [ ] **12 underlayer names** — one under each Ring 1–3 surface.
- [ ] **Threshold 4 paths layout** — how Cut / Ash / Salt / Quiet are
      *seen* from the Mouth without becoming a tutorial quest.
- [ ] **Item clone table with final names** — original IP names on the
      `CONTENT.md` clone list; still no WoW names player-facing.
- [ ] **Spoilage timers, final stack sizes** — meat / stew / water and
      any tea/tincture/salve/ward stacks.
- [ ] **MPQ Tier A file list** — actual filenames for load screens,
      meter icons, core item icons.

## Implementation (not AICraft)

- [x] **Deploy pipeline separate from AICraft** — spec in
      `docs/DEPLOY.md`. Isolation agreed. Clone/build waits for Step 2.
- [ ] **AC module skeleton** — Step 2. Survival meters, Gate, Journal
      Record. Empty hooks are fine; compile-and-login is the point.

## Explicitly not on this list

- Building AzerothCore during Step 1.
- Fixing AutoBalance for “Scott + 9 bots in Molten Core” (AiCraft-WotLK
  only).
- Post-launch content patches as a substitute for L14.
FRACTURED_TODO

# ---------------------------------------------------------------------------
# docs/BRAINSTORM.md
# ---------------------------------------------------------------------------
cat > docs/BRAINSTORM.md << 'FRACTURED_BRAINSTORM'
# Fractured — Brainstorm / conversation archive

This file is a repair reference, not a second design spec. If a later
paste handoff truncates `DESIGN.md` / `WORLD.md` / `CONTENT.md`, run
`bash bootstrap.sh` from repo root. Do not reconstruct tables by
copying nested markdown out of chat.

Canonical systems live in `DESIGN.md`. Canonical geography lives in
`WORLD.md`. Canonical items and MPQ live in `CONTENT.md`.

## What this project is

Private friend-project. Horror survival mode. Original IP player-facing
(L15). Engine is AzerothCore WotLK 3.3.5a only — not a WoW private
server brand, not Star Wars, not a content patch on AICraft.

Team: Scott + about six friends. Async. Rarely online together. The
design has to survive people logging in alone and people overlapping
in twos, threes, or fours.

## Tax and dividend

The loop that survived the conversation:

- **Tax:** Hunger, Thirst, Corruption, tight bags, forage-heavy play.
- **Dividend:** mystery, Sanctuary upgrades, leads, extraction, the
  district network, the stalker.

If survival is generous, the horror and the network have no leverage.
If survival is the whole game, friends will stop after they learn the
stew recipe. Both halves have to ship in v1.0 (L14).

## Death

Not permadeath (L1). Character is not deleted. Haul is lost. Corruption
spikes. Temporary **Fractured** debuff. Wake in Sanctuary morgue (L2).
Return paths: portal, Relay node, or death. Corpse-vs-morgue fiction
is still an open task.

## Old world vs new world

Retired spine: **Threshold → Thorn → Ruins → Deep** as a linear line.

Replacement: hub + Mouth + parallel Ring 1 (Cut, Ash, Salt, Quiet) +
deeper rings + twelve underlayers. About 29 spaces. Instanced so async
groups do not share a single corridor instance.

Gates are knowledge + loadout + Corruption, not level (L13).

## Loot rule

Everything findable uses or breaks→uses (L7). No dead loot. That rule
is why Fieldcraft and Apothecary exist without profession levels (L8),
and why the material graph is the first big TODO.

## Journal

**Record**, not quest log (L10). It writes what you learned after you
learned it. It never assigns the next task. Discovery-first; no
tutorial chain (L9).

## Gate flow (v1)

Login → Sanctuary → Gate object → Mouth (Threshold) → four visual
paths → Ring 1+. Solo player opens. Co-op party leader opens (confirm
UX TBD). Bots blocked at Gate (L11). AutoBalance on Wild instances;
MinPlayers = party size (L12). AB counts Player objects.

## Bots

Sanctuary only. Wild is humans only, 2–4. This is how the friend group
can mess around in the hub with playerbots and still have the horror
space stay human.

## Visual clone list (conversation)

Working WotLK refs, models only, names original:

- Knife 5278
- Machete 1219
- Cleaver 2827, 1292
- Starter armor: patchwork / ragged
- Hive mask: Mask of the Unforgiven **model**
- Waders: TBD lowbie leather/cloth
- Ward focus: TBD off-hand/trinket

Avoid iconic WoW. MPQ for load screens, survival icons, zone music,
optional AreaTable renames.

## AutoBalance / AICraft context

Scott ran MC with self + 9 bots in AICraft and it felt too easy. That
diagnosis (pull-time player count vs AB tuning) lives in
**AiCraft-WotLK**. It is not a Fractured task and must not be “fixed”
by importing raid-with-bots assumptions into Wild districts.

Fractured is a separate repo (`scotthare81/Fractured`). Do not mix ops.

## Cooking

No levels. Quality in, weighted out. Model C: 70% standard / 20% good /
10% best on the chosen quality band.

## Bags

~6 start, ~20–24 cap. Meat ~5, stew ~3, water ~4. Sit/channel to eat
and drink. Forage free; species meats; spoilage.

## If docs break again

Do not paste a giant handoff into files by hand. Edit `bootstrap.sh`
heredocs (or re-run the seeder if only the generated files are stale),
then commit and push. `docs/AGENT-INSTRUCTIONS.md` is the short version
of that rule for future agents.
FRACTURED_BRAINSTORM

# ---------------------------------------------------------------------------
# docs/AGENT-INSTRUCTIONS.md
# ---------------------------------------------------------------------------
cat > docs/AGENT-INSTRUCTIONS.md << 'FRACTURED_AGENT'
# Fractured — Agent instructions

Read this before touching the repo.

## This is not AICraft

Fractured (`scotthare81/Fractured`) is a separate private project. Do
**not** touch AiCraft-WotLK. Do not add Fractured SQL, scripts, MPQ,
or docs there. Do not mix deploy/ops. Follow `docs/SLICE.md` for when
AzerothCore work is allowed (not during Step 1).

## Do not paste giant handoff blocks

Long chat pastes break files: tables lose columns, code fences snap,
sections truncate. Write files with tools or by editing `bootstrap.sh`.
Never “fix” markdown by copying nested fences out of a conversation.

## Source of truth

| File | Trust it for |
|------|----------------|
| `DESIGN.md` | Systems, locks L1–L15, gate flow, death, survival |
| `WORLD.md` | District network, gates, expedition flow, map IDs |
| `CONTENT.md` | Items, clones, chains, MPQ, implementation notes |
| `docs/TODO.md` | Open work |
| `docs/SLICE.md` | Build sequence; current step |
| `docs/DEPLOY.md` | Server isolation from AICraft |
| `docs/BRAINSTORM.md` | Why decisions happened; not a competing spec |
| `README.md` | Pitch, status, index |

If two files disagree, fix them together and update the heredocs in
`bootstrap.sh` so the next seed cannot resurrect the wrong version.

## Repair

```bash
bash bootstrap.sh
git add -A
git status
# commit only if Scott asked, unless the task explicitly says commit
```

`bootstrap.sh` is idempotent. Re-running overwrites the generated
markdown and `.gitignore` with the heredoc copies. After a bad paste,
run the seeder instead of hand-merging fragments.

If you change design, change the heredocs in `bootstrap.sh` **and**
regenerate, or the next repair will wipe your edit.

## Scope

- Follow `docs/SLICE.md`. Finish the current step before the next.
- Do not clone, configure, or build AzerothCore during Step 1.
- Do not touch AiCraft-WotLK (`/home/scott/aicraft-wotlk` or related).
- TBD only for numbers and IDs not yet decided.
- If you change a generated markdown file, change the heredoc in
  `bootstrap.sh` too.
FRACTURED_AGENT

# ---------------------------------------------------------------------------
# docs/SLICE.md
# ---------------------------------------------------------------------------
cat > docs/SLICE.md << 'FRACTURED_SLICE'
# Fractured — Build sequence

Go **one step at a time**. Finish the current step before starting the
next. The 29-space network, MPQ polish, and mystery leads wait until
the loop is playable.

| Step | Name | Done when |
|------|------|-----------|
| 1 | Own server | Isolation spec agreed; tree is not AICraft |
| 2 | Module skeleton | Empty Fractured module compiles in *this* project |
| 3 | Three spaces | Sanctuary, Mouth, Cut have map IDs and a one-pager each |
| 4 | The tax | Hunger / Thirst / Corruption, sit/channel, tiny bags, forage / butcher |
| 5 | One Record line | First butcher writes a learned fact, not a quest |

**Current step: 2.** Step 1 isolation is agreed (`docs/DEPLOY.md`).

## Step 1 — Own server

Isolate Fractured from AICraft. Same machine is allowed. Same
directory, database, ports, restarter, or modules folder is not.

See `docs/DEPLOY.md`. Do not clone or build AzerothCore in this step.

## Step 2 — Module skeleton

After isolation is agreed: an empty module in this repo (or in the
Fractured server tree, referenced from this repo) with hooks for
survival meters, Gate (bots blocked), and death → morgue. Compile is
the point. Behavior can be stubs.

## Step 3 — Three spaces

Reuse obscure WotLK instance maps. Assign real map/instance IDs for
**Sanctuary**, **Mouth**, and **Cut** only. One-pager each. Leave
every other district TBD.

## Step 4 — The tax

Crude survival: meters, sit/channel food and water, ~6 bag slots,
forage a deer analog, butcher with knife 5278. Death drops the haul.
Character persists. Wake in the morgue.

## Step 5 — One Record line

After the first successful butcher, the Journal Record logs that the
meat is venison (or the species you actually butchered). No “go do
X.” That proves L10.

## Not a step yet

Full gate matrix, 12 underlayer names, lead pool, Nursery / Edge,
Sanctuary upgrade costs, co-op Gate UX, AutoBalance tuning, MPQ Tier
A file list. Write those when the slice exists, not before.
FRACTURED_SLICE

# ---------------------------------------------------------------------------
# docs/DEPLOY.md
# ---------------------------------------------------------------------------
cat > docs/DEPLOY.md << 'FRACTURED_DEPLOY'
# Fractured — Deploy (Step 1)

Own server. Not AICraft. This step is **isolation**, not a compile.

Do not clone AzerothCore, do not run CMake, and do not copy modules
into `/home/scott/aicraft-wotlk` (or `aicraft`, `aicraft-progression`,
`aicraft-wotlk-migrate`). Sign off the defaults below, then Step 2
can introduce a module skeleton.

## Goal

A worldserver that cannot take down, overwrite, or restart AICraft.
Friends can later have both realms; ops must never be one folder.

## Recommended defaults

Say yes to these or change one line. Do not invent a third tree.

| Decision | Default |
|----------|---------|
| Machine | Same box as AICraft is OK |
| Git repo | `/home/scott/fractured` (docs + later modules) |
| Server tree | `/home/scott/fractured-server` (binaries, conf, logs) |
| Auth | **Separate** `authserver` (own login port) |
| Databases | Own MySQL *names* on the existing MySQL; own user |
| Client extract | Read-only share of 3.3.5a maps/dbc later is OK |
| Writable data | Never shared with AICraft |

Separate auth is the boring kind of isolation: Fractured realm ID can
be 1 on its own auth. Sharing AICraft’s auth is nicer for friends
later and is a **later** change, not Step 1.

## Never

- Put Fractured worldserver, conf, or modules inside any `aicraft*`
  directory
- Share `characters` or `world` databases with AICraft
- Share a restarter, systemd unit, or `screen` session with AICraft
- Symlink this repo into an AICraft `modules/` folder
- Restart AICraft to “just test” Fractured
- Commit server binaries, `data/`, or MPQ blobs into this git repo

## Paths

```
/home/scott/fractured              git repo (this project)
/home/scott/fractured-server       server tree (not git)
/home/scott/aicraft-wotlk          AICraft — do not touch
```

`fractured-server` is allowed to exist as an empty directory in Step
1. AzerothCore source and build dirs go *under it* in a later step,
not under `/home/scott/fractured` until we choose a modules layout
in Step 2.

## Ports

If AICraft uses AzerothCore defaults, Fractured uses the next ports
so both can run at once. If AICraft already took a port, pick another
and write it here — do not steal AICraft’s.

| Service | AICraft typical | Fractured |
|---------|-----------------|-----------|
| authserver | 3724 | 3725 |
| worldserver | 8085 | 8086 |
| SOAP | 7878 | 7879 |
| MySQL | 3306 (shared daemon) | 3306 (same daemon, different DB names) |

Client `realmlist.wtf` for Fractured will point at the Fractured
auth port (3725 in this table), not at AICraft’s.

## Databases

Same MySQL daemon is fine. Names and user are not.

| Database | Name |
|----------|------|
| Login | `fractured_auth` |
| Characters | `fractured_characters` |
| World | `fractured_world` |
| MySQL user | `fractured` |

Passwords stay out of git (see `.gitignore`). Put them in
`/home/scott/fractured-server` conf later, never in this repo.

## Realm

| Field | Value |
|-------|-------|
| Realm name | Fractured |
| Realm ID | 1 (own auth) |
| Address | TBD when we bind a host (localhost is enough for Scott-only) |

Player-facing realm name is original IP. Do not call it a WoW realm
pun.

## Restarter

Fractured gets its own start/stop habit: own systemd unit **or** own
script in `/home/scott/fractured-server`, not an extra line in an
AICraft script. Write the actual unit in a later step, after a binary
exists.

## What “Step 1 done” means

- [x] Isolation spec written (this file)
- [x] Scott agrees the defaults (or writes the diffs)
- [x] `/home/scott/fractured-server` exists and is not an AICraft path
- [x] No AzerothCore clone/build has started for Fractured

When those are true, go to **Step 2** in `docs/SLICE.md`.
FRACTURED_DEPLOY

# ---------------------------------------------------------------------------
# .gitignore
# ---------------------------------------------------------------------------
cat > .gitignore << 'FRACTURED_GITIGNORE'
# OS
.DS_Store
.DS_Store?
._*
Thumbs.db
Desktop.ini
ehthumbs.db
*~

# Editors / IDEs
.idea/
.vscode/
*.swp
*.swo
*.swn
*.sublime-project
*.sublime-workspace
.cursor/
*.code-workspace

# Build / compile
build/
cmake-build-*/
out/
dist/
*.o
*.a
*.so
*.dylib
*.dll
*.exe
*.pdb
*.ilk
CMakeCache.txt
CMakeFiles/
compile_commands.json

# MPQ / client data (local, large — do not commit)
*.mpq
*.MPQ
*.mpq.tmp
Data/
WTF/
Cache/
Logs/
Interface/AddOns/
Wow.exe
WowError.exe
*.wdb
*.wdt
*.adt
*.m2
*.skin
*.blp

# Env / secrets
.env
.env.*
!.env.example
*.pem
*.key
credentials.json
secrets.yaml

# Logs and junk
*.log
*.tmp
*.bak
core
FRACTURED_GITIGNORE

echo "Fractured docs seeded in ${ROOT}"
echo "Files:"
wc -l README.md DESIGN.md WORLD.md CONTENT.md \
  docs/TODO.md docs/SLICE.md docs/DEPLOY.md \
  docs/BRAINSTORM.md docs/AGENT-INSTRUCTIONS.md \
  .gitignore bootstrap.sh
