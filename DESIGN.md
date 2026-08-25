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
