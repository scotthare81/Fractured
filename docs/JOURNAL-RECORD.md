# Journal Record — discovery UI and knowledge model

The **Journal Record** is the Remnant's persistent record of what they have actually learned. It is not a quest log, checklist, codex dump, or recipe browser.

It has three top-level tabs:

1. **Creatures** — sightings, engagements, observed behaviour and abilities.
2. **Survival** — food, water, medicine, herbs, mushrooms, fishing, poisons, traps and fieldcraft.
3. **Gear** — weapons, armour, tools, charms, diagrams and upgrade paths.

The shared rule across all three tabs is simple:

> **Unknown things can be visible, but they must remain unreadable until the Remnant earns the knowledge.**

A grey silhouette, obscured icon, broken outline, masked name or incomplete recipe shape can tell the player that *something exists* without telling them what it is.

The Journal should create curiosity, not solve it.

---

## 1. Shared discovery language

Every journalable thing uses the same broad visual states.

| State | Meaning | UI treatment |
|-------|---------|--------------|
| **Unknown** | Never encountered or inferred | Dark/grey silhouette, masked name, unreadable fields |
| **Inferred** | The player has learned that something exists but not what it is | Silhouette becomes clearer; one or more ingredient/process slots may appear; hints can be attached |
| **Known** | Identity or recipe/result discovered | Real icon, real name, discovered description |
| **Observed** | Deeper behaviour was personally witnessed | Additional notes, properties, abilities, yields or upgrade facts revealed |

Not every category needs all four labels in code; these are the UX states. Creature-specific tiers remain **Unknown → Sighted → Engaged**.

### Locked presentation rules

- Do **not** use bright rarity colours, quest markers, completion stars or achievement-style progress.
- Do **not** show percentages such as `7/10 discovered` in the main UI.
- Do **not** expose a hidden item's actual name through tooltip, search, chat link, sort label or icon filename.
- Unknown entries may show position/shape in a tree where useful, but their identity remains obscured.
- The Journal records facts already learned; it never says what objective to do next.
- Internal WoW spell/item names never appear in the Record.

---

## 2. Overall UI

The Journal Record is a dedicated custom addon frame in `ThalvaethUI`, styled as a worn field notebook rather than a Warcraft quest panel.

### Top-level layout

```text
┌──────────────────────────────────────────────────────────────┐
│                        JOURNAL RECORD                        │
│     CREATURES          SURVIVAL          GEAR               │
├───────────────────┬──────────────────────────────────────────┤
│ index / categories│ selected entry / notes                  │
│                   │                                          │
│ silhouettes       │ description                              │
│ known entries     │ discovered uses / hints / observations   │
│ obscured entries  │                                          │
└───────────────────┴──────────────────────────────────────────┘
```

Top-level tabs should remain limited. Category depth belongs **inside** a tab, not as another row of global tabs.

---

# Creatures tab

The existing creature-journal design remains the authority for creature progression: [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md).

## Creature index

The left page/list shows all catalogue positions that the player is allowed to know exist.

Unknown example:

```text
[grey silhouette]   — — —
```

Sighted example:

```text
[muted portrait]    Ash Sleeper
                    "Crouched like sleep. Eyes open."
```

Engaged entries unlock deeper observations on the right panel.

## Creature page

### Unknown

- silhouette only;
- masked name;
- no location hints;
- no abilities;
- no HP;
- no counter text.

### Sighted

- player-facing name;
- sighted prose;
- creature image/silhouette resolves enough to identify it;
- any simple classification that is intentionally player-facing.

### Engaged / observed

Adds personally witnessed information:

- observed vitality/health information;
- abilities that this Remnant has actually witnessed;
- additional behavioural notes where earned.

Exact numeric HP is **not automatically required** just because it is stored. The UI may map observed health to diegetic bands such as *frail / hardy / tough / brutal* if that plays better. Raw DB values remain useful internally.

## Creature ability discovery

Abilities must appear only after being witnessed.

Example:

```text
BROKEN SNARE

Throws a hook
Drags you into the choke.
```

Before the hook has been witnessed, that line remains absent or greyed/obscured. The player is not handed the counter in advance.

---

# Survival tab

The **Survival** tab is the practical knowledge book: how to eat, drink, mend, forage, fish, brew, poison and survive.

It does **not** present a complete recipe catalogue on day one.

## Survival categories

Use category buttons/list entries inside the Survival tab:

- **Food**
- **Water**
- **Medicine**
- **Herbs & Fungi**
- **Fishing**
- **Poisons**
- **Traps & Fieldcraft**

These categories may grow, but they should stay grounded in survival use rather than become a general encyclopaedia.

## Food

Tracks learned preparations, not every possible food item.

Examples:

- Campfire Roast
- Stew
- Broth
- Bread / Porridge
- Boiled Roots
- Sausage
- Jerky / Smoked Meat
- Pemmican
- Pickles
- Black Pudding
- Grilled Fish
- Fish Stew
- Smoked Fish
- Mushroom Fry
- Forage Pottage

An undiscovered recipe should appear as an unreadable silhouette **only when the player has a reason to infer that a preparation exists**. We should not populate the page with hundreds of meaningless question marks from minute one.

## Water

Tracks treatment knowledge as a progression:

- Crude boil — known at start.
- Better purification — inferred once dirty-water limitations are understood.
- Charcoal filtration — locked behind Charcoal discovery.
- Distillation — locked behind Distilling.

An unknown water-treatment entry may visually expose process structure without exposing the answer:

```text
Foul Water → [grey process] → ???
```

After discovering Charcoal, the obscured process may become more legible without immediately granting the complete recipe.

## Medicine

Includes learned wound and Infection treatments:

- Bandage
- Stitch Kit
- Salve
- Poultice
- Antiseptic Wash
- Styptic
- Ash Tea
- Fever Tincture
- Stimulant
- relevant medicinal teas/tinctures

Entries should distinguish **what the Remnant knows it does** from hidden game maths. A known Ash Tea may say *"Eases Infection"* rather than expose a raw percentage unless numbers are later judged necessary for play.

## Herbs & fungi

Plants and mushrooms should themselves accumulate knowledge.

A material entry can reveal in layers:

1. **Seen/collected** — icon/name may become known.
2. **Identified property** — edible, medicinal, poisonous, fibrous, resinous, etc.
3. **Known uses** — linked preparations discovered through experimentation or taught knowledge.

Example:

```text
GRAVEMOSS

Found on damp stone.

Known uses:
[Poultice icon] Poultice
[grey bottle]   ???
```

This lets one material continue to generate discovery after first pickup.

### Mushroom rule

Mushrooms should not reveal edible/medicinal/poison class merely because the player looted one. Identification must come from learned tells, safe experimentation, notes, keeper teaching or consequences.

## Fishing

Fishing knowledge includes:

- tackle and methods;
- catches already identified;
- known preparation/preservation uses;
- products learned from breaking fish down.

A caught fish can begin as a known catch but still retain unknown-use silhouettes for smoking, oil, roe, skin or bone until those uses are discovered.

## Poisons

Poisons are mundane and discovery-gated.

The Journal can show an obscured poison branch once the player has handled poisonous material, but must not simply print all formulas.

Known poison records should contain:

- ingredients/process already discovered;
- application method;
- observed effect in plain language;
- self-risk notes only if actually learned.

Bad doses and incompatible ingredients can create permanent hints.

## Traps & fieldcraft

Includes:

- snares;
- fish traps/weirs;
- deadfalls;
- pits/stakes;
- net traps;
- jaw traps;
- tripwires;
- firestarting;
- crude sharpening/patching where useful.

Again, the Journal should show a discovered method, not a crafting-menu shopping list.

---

# Gear tab

The **Gear** tab is the Remnant's record of upgrade knowledge.

Internal categories:

- **Weapons**
- **Armour**
- **Tools**
- **Charms**

The important visual language here is the **partially obscured upgrade tree**.

## Weapon trees

Known and unknown nodes may coexist:

```text
Crude Dagger → Iron Knife → [grey blade] →┬→ [grey weapon]
                                          └→ [grey weapon]
```

After discovering Steel:

```text
Crude Dagger → Iron Knife → Steel Blade →┬→ [grey weapon]
                                         └→ [grey weapon]
```

After learning one diagram:

```text
Crude Dagger → Iron Knife → Steel Blade →┬→ Greatsword
                                         └→ [grey weapon]
```

The unseen branch remains a reason to explore.

## Armour trees

Same principle:

- Rag Armour
- Quilted Coat
- Leather branch
- Mail branch
- Plate branch

A tier can remain a silhouette even when the player knows a heavier class exists. The exact item identity/recipe unlocks only with discovery.

## Tools

Tools can reveal based on need and discovery:

- butcher/skinning tools;
- axe;
- pick;
- awl/saw/needle;
- whetstone;
- fishing equipment.

Their Journal entries should expose practical use and known upgrade paths rather than raw item-template data.

## Charms

The Gear tab records both aptitude and passive charms:

- Stillstone
- Veil Sachet
- Ash Pouch
- Emberleaf Cord
- Deep-Lung Token
- Ward Fetish
- Warm Fetish
- Porter's Strap
- Steady Cord
- Keepsakes / future charms

Unknown charm slots/nodes should use the same obscured language. A player can know there are further charm possibilities without knowing their names/effects.

---

# Near-miss experimentation and hints

Near-miss learning is a core Journal system, not disposable error text.

When the player attempts a craft that does **not** exactly match a valid recipe, the server evaluates whether the attempt is close enough to teach something.

If it teaches something new, that knowledge is written permanently into the Journal.

## Goals

A failed experiment should be able to produce:

- no useful information;
- a process hint;
- an ingredient-property hint;
- a missing-function hint;
- a newly inferred hidden recipe node.

It should **not** return an exact missing item unless the Remnant has already learned enough to justify that precision.

Bad:

```text
Missing ingredient: Grave Salt.
```

Good:

```text
It would not preserve. Something needs to draw the moisture out.
```

Bad:

```text
Wrong station. Use Ash-still.
```

Good:

```text
The mixture never drew enough from the leaves.
```

## Example — Ash Tea

Attempt 1:

```text
Ashbloom + Foul Water
```

Near miss learns:

> *The herb steeped, but the water spoiled it.*

Journal may now infer an unknown preparation and store:

```text
Ashbloom + [water] + ???

Notes:
- The water needs to be cleaner.
```

Attempt 2:

```text
Ashbloom + Clean Water
```

Wrong process/station:

> *The leaves gave almost nothing. It needs heat.*

Journal gains a second note.

Successful preparation resolves the entry into **Ash Tea**, replaces the grey icon with the proper icon, and records the actual learned preparation.

## Hint persistence

Each hint has its own stable key. The same mistake must not repeatedly create "new" knowledge.

Example conceptual keys:

```text
ash_tea.clean_water
ash_tea.needs_heat
hide_tanning.needs_drying_agent
charcoal.low_air
steel.needs_hotter_fire
```

The first time a hint is learned, show a subtle Journal-update notification. Repeating the same failed experiment should not spam the Journal.

## Near-miss distance

Recipes should define meaningful near-miss rules instead of relying only on generic ingredient-count similarity.

Examples of useful dimensions:

- correct core ingredient, wrong liquid;
- correct ingredients, wrong process/station;
- correct family, missing binder/preservative/heat;
- correct process but incompatible poisonous material;
- valid formula with an ingredient that has not been prepared/refined correctly.

A random pile of unrelated materials should simply fail without teaching anything.

## Hints must remain diegetic

Hint text should describe observed properties:

- *Too wet.*
- *Wouldn't bind.*
- *Needed more heat.*
- *Burned before it changed.*
- *The wound closed, but quickly fouled.*
- *The edge would not hold.*
- *The hide stayed too stiff to work.*
- *Something bitter might draw it out.*

The Journal records the Remnant's inference, not the game's validation error.

---

# Knowledge links

Journal entries should be able to link discovered knowledge without flattening everything into one giant tree.

Examples:

- Ashbloom entry links to known Ash Tea once discovered.
- Charcoal entry links to known filtration and forge uses.
- Gravecap links to poison preparations only after those uses are learned.
- Steel Blade links to discovered upgrade branches.
- A fish links to known cooking/preservation products.

Unknown linked uses stay as grey silhouettes if the player has inferred that another use exists.

---

# Server authority and persistence

The **server is authoritative** for Journal knowledge. The addon renders it.

Client-only SavedVariables must never be the source of truth for discovery.

The existing Creature Journal already has per-character DB persistence. The broader Journal should extend that principle to recipes, hints, materials and gear knowledge.

Conceptually the server must be able to answer:

```text
What does this Remnant currently know?
```

not:

```text
What has this Lua session happened to see since /reload?
```

## Login/full sync

The current `JOURNAL~<entry>~<tier>` message is suitable for incremental creature changes but is not enough for a complete reload/login state.

The implementation phase should add a full sync handshake, for example:

```text
HELLO
JOURNAL_BEGIN
...
JOURNAL_END
```

Only known/inferred records need to cross the wire if the addon has the static catalogue of safe-to-display unknown slots.

Specific wire format is implementation detail; the locked requirement is **full persistent state after login or `/reload`**.

---

# Suggested persistence model

Exact SQL is deferred to implementation, but the model should support generic discoveries without forcing every feature into the creature table.

A practical model is a per-character discovery table keyed by namespace + key:

```text
thalvaeth_player_discovery
- guid
- namespace      -- creature / recipe / material / gear / hint
- discovery_key
- state
- discovered_at
- payload        -- optional compact data for observations
```

Creature-specific observed HP/ability data can remain in the specialised creature-journal table if cleaner. The generic table is for broader Journal knowledge and hint flags.

Important properties:

- idempotent writes;
- one-way progression unless a design explicitly says otherwise;
- no client authority;
- stable keys independent of player-facing text;
- migrations safe to extend as categories grow.

---

# Notifications

A new discovery should create a restrained notification such as:

> **Journal updated.**

Do not immediately print the full answer in combat/chat. The player can open the Record when safe.

Different update strengths may be useful:

- **New entry discovered** — stronger page-mark/ink cue.
- **New hint learned** — subtle cue.
- **New observation** — subtle cue.

No achievement fanfare.

---

# v1 implementation order

1. **Tabbed shell** — Creatures / Survival / Gear.
2. **Full persistent sync** — addon reconstructs the Record after login/reload.
3. **Creature rendering** — Unknown/Sighted/Engaged in the new shell.
4. **Generic discovery registry** — recipe/material/gear/hint states.
5. **Survival records** — start with Food, Water, Medicine and Herbs/Fungi.
6. **Near-miss hints** — server evaluation + persistent hint flags.
7. **Gear trees** — weapon/armour/tool/charm silhouettes and diagrams.
8. **Fishing/poisons/traps depth**.
9. **Polish** — notebook skin, silhouettes, bespoke icons, transitions and page treatment.

Build the functional ugly version before committing heavily to bespoke art.

---

# v1 content scope

The first Journal pass should have enough entries to prove all three discovery modes without requiring the entire item catalogue to be implemented.

## Creatures

All current `90001–90010` catalogue entries.

## Survival

Minimum useful set:

- Campfire Roast
- Stew
- Crude Boil
- Charcoal Filter
- Stitch Kit
- Ash Tea
- Antiseptic Wash
- one edible mushroom
- one medicinal mushroom/herb
- one poison mushroom
- Fishing Rod / basic catch
- Smoked Fish
- Snare
- one blade poison

## Gear

Minimum useful set:

- Crude Dagger
- Iron Knife
- Steel Blade
- one dual-wield branch node
- one 2H branch node
- Rag Armour
- Quilted Coat
- first Leather tier
- first Mail tier
- first Plate tier
- one tool upgrade
- aptitude charm + passive charm examples

This gives enough obscured nodes and reveal moments to judge whether the system feels satisfying before authoring every late-game entry.

---

# Locked design decisions from this spec

- The Journal Record has **three top-level tabs: Creatures / Survival / Gear**.
- Unknown knowledge is represented primarily by **silhouettes / greyed or obscured icons and masked text**, not a visible answer with a lock icon.
- Survival contains cooking, water, medicine/bandages, herbs/fungi, fishing, poisons, traps and fieldcraft.
- Gear contains weapons, armour, tools and charms/upgrades.
- Near-miss crafting can create **persistent hints** in the Journal.
- Hints describe properties/processes, **not explicit missing-item validation**.
- Repeating an already-learned near miss does not generate new knowledge.
- Random invalid combinations do not automatically produce hints.
- Full Journal state is persisted server-side and restored after login/reload.
- The Journal remains a record of learned knowledge, **never a quest tracker or checklist**.

---

## Related

- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md) — creature-specific knowledge tiers and protocol
- [CRAFTING.md](CRAFTING.md) — discovery, experiments, stations and recipes
- [ITEMS.md](ITEMS.md) — made/found item catalogue
- [MATERIALS.md](MATERIALS.md) — raw inputs
- [GEAR.md](GEAR.md) — weapon/armour/charm progression
- [APTITUDES.md](APTITUDES.md) — charm-granted aptitudes
- [SURVIVAL.md](SURVIVAL.md) — the pressures Survival knowledge answers
