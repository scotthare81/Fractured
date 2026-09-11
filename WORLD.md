# Fractured — World

> **⚠ Status — superseded for the current build.** This describes the **multi-district co-op ring network** — the *earlier / possible-expansion* vision. The **current build is solo, single-run**: home = **Thal'vaeth Monastery**, first run = **Rotwood** (see [`MAPS.md`](thalvaeth-agent-handoff/docs/MAPS.md), [`CREATURES.md`](thalvaeth-agent-handoff/docs/CREATURES.md), [`DIRECTOR.md`](thalvaeth-agent-handoff/docs/DIRECTOR.md)). Whether this ring network is *dead* or a *future expansion* is [Scott's open call](DESIGN.md). Keep for reference; the Thal'vaeth docs win where they disagree.

---

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
