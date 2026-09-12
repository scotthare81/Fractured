# Journal coding plan

This is the implementation sequence to follow after the Journal documentation set is approved.

The aim is to reduce cross-system debugging by introducing one authoritative layer at a time.

---

## Milestone 0 — freeze contracts

Before writing gameplay code:

- stable keys reviewed against `JOURNAL-KEY-REGISTRY.md`;
- data model reviewed against `JOURNAL-DATA-MODEL.md`;
- wire messages reviewed against `JOURNAL-WIRE-PROTOCOL.md`;
- first slice reviewed against `JOURNAL-V1-SLICE.md`;
- deterministic test vectors accepted.

No implementation should invent new persistent keys or wire messages without updating docs first.

---

## Milestone 1 — persistence foundation

Build generic per-character discovery persistence.

Required capabilities:

- insert absent discovery;
- promote state monotonically;
- point lookup;
- enumerate all records for one character;
- namespace reset/grant tooling for testing;
- migration for new table(s).

Do not build the polished addon yet.

Exit criteria:

- DV-001 through DV-004 pass;
- character isolation passes;
- database survives restart/login cycles.

---

## Milestone 2 — authoritative snapshot protocol

Implement v1 handshake and snapshot:

```text
HELLO~1
READY~1
SNAP_BEGIN
...
SNAP_END
```

Build safe projection from server persistence.

Client should have a minimal debug receiver before final UI.

Exit criteria:

- clean login snapshot;
- `/reload` snapshot;
- mismatch/missing snapshot end is safe;
- snapshot restore generates no false discovery notifications.

---

## Milestone 3 — generic delta pipeline

Implement incremental discovery updates:

- generic discovery promotion;
- hint notification kind;
- entry notification kind;
- observation notification kind;
- monotonic client application.

Exit criteria:

- snapshot + later delta produce same state as a fresh snapshot;
- replayed/stale delta cannot regress state.

---

## Milestone 4 — Creature tab migration/completion

Move the existing creature-journal client behaviour into the full Journal shell without breaking current server functionality.

Implement:

- full creature snapshot projection;
- Sighted/Engaged render state;
- observed HP projection;
- observed ability persistence and deltas;
- v1 four-creature proof cases.

Exit criteria:

- Sleeper, Scavenger, Caller and Snare behave as specified in `JOURNAL-V1-SLICE.md`;
- ability names are Thal'vaeth terms, not raw WoW names.

---

## Milestone 5 — tabbed Journal shell

Build functional UI only:

- Creatures / Survival / Gear top tabs;
- category navigation;
- selected-entry detail region;
- loading state;
- unread/update markers;
- temporary grey silhouettes/icons;
- no final art dependency.

Exit criteria:

- UI survives reload/resync;
- hidden text cannot leak via tooltip/search/sort;
- three tabs render entirely from committed authoritative cache + safe static definitions.

---

## Milestone 6 — Survival first slice

Implement only the pinned proof content:

- born-known crude basics;
- Ashbloom layered knowledge;
- Gravecap layered knowledge;
- Ash Tea hint chain and success;
- Charcoal process chain;
- Stitch Kit path;
- one fish/preparation;
- one Snare path;
- Whetstone path.

Do not expand to the complete recipe catalogue yet.

Exit criteria:

- random ingredient spam teaches nothing;
- failure precedence matches solution canon;
- duplicate mistakes do not duplicate hints;
- success promotes the correct recipe/process key;
- hidden quality is evaluated separately.

---

## Milestone 7 — Gear first slice

Implement minimal tree:

- Crude Dagger;
- Iron Knife;
- Steel Blade;
- one known/unlocked branch;
- one silhouette-only sibling branch;
- Rag Armour;
- Quilted Coat;
- first Leather/Mail/Plate proof nodes;
- Stillstone;
- Deep-Lung Token.

Exit criteria:

- inferred node topology is visible without leaking identity where intended;
- diagram unlock promotes the exact node;
- owning an item does not automatically equal recipe knowledge unless explicitly designed.

---

## Milestone 8 — full end-to-end v1 acceptance

Run the manual scenario in `JOURNAL-TEST-VECTORS.md` from a clean character.

Block further content expansion until it passes.

---

## Milestone 9 — instrumentation and GM tools

Before scaling content, add diagnostics:

- inspect player Journal state;
- grant/promote discovery;
- reset namespace/all;
- force full snapshot/resync;
- log evaluator candidate/failure selection in debug mode;
- inspect learned hint keys.

These are development tools, not player features.

---

## Milestone 10 — content expansion

Only after the proof slice is stable:

1. remaining food/water/medicine;
2. herbs/fungi and fishing depth;
3. fieldcraft/traps;
4. gear tree breadth;
5. charms/aptitudes;
6. poisons within fictional game abstractions;
7. visual polish and bespoke art.

---

## Coding rules

- Server is always authoritative.
- No SavedVariables discovery truth.
- No hard-coded hidden solution table in Lua.
- No duplicate stable-key definitions scattered across unrelated files if they can be centralised.
- Database writes must be idempotent.
- State must only move forward.
- Every new persistent key goes through the registry.
- Every new wire message goes through the protocol doc.
- Every new recipe near-miss goes through `DISCOVERY-SOLUTIONS.md` and hint library.
- Every new player-visible entry must define unknown/inferred/known presentation.

---

## Suggested code boundaries

Names are recommendations, not absolute requirements, but responsibilities should remain separated.

### Server

```text
ThalvaethDiscoveryStore
- DB load/query/grant/promote

ThalvaethJournalSync
- handshake, snapshot, deltas

ThalvaethExperimentEvaluator
- candidate selection, hard gates, failure precedence, hint outcome

ThalvaethJournalDefinitions
- safe stable definitions and key registry bindings
```

Creature-specific observation hooks may remain in `ThalvaethCreatureJournal.cpp` while calling shared persistence/sync helpers.

### Client

```text
Core.lua
- transport/handshake/version

JournalState.lua
- staged snapshot + committed cache + monotonic deltas

JournalFrame.lua
- shell/tabs/navigation

JournalCreatures.lua
JournalSurvival.lua
JournalGear.lua
- tab renderers

JournalDefinitions.lua
- safe player-facing static definitions only
```

Do not put hidden recipe truth into `JournalDefinitions.lua`.

---

## PR strategy

Prefer small reviewable implementation PRs:

1. DB + persistence helpers;
2. wire snapshot + client state cache;
3. creature integration;
4. UI shell;
5. Survival proof slice;
6. Gear proof slice;
7. diagnostics/tests/polish.

Avoid a single giant “Journal implementation” PR touching SQL, C++, Lua, content and art at once.

---

## Ready-to-code gate

Coding can begin when:

- all code-readiness docs are merged;
- no unresolved contradiction exists between Journal Record, content, hints, solutions, implementation spec, UI spec, v1 slice, data model, protocol, key registry and test vectors;
- the first implementation PR can be described without inventing a new design decision.

If implementation uncovers a missing decision, update canon first, then code it.