# Journal data model

This document pins the persistence contract for the Journal Record before C++/SQL implementation begins.

Related canon:

- [JOURNAL-IMPLEMENTATION-SPEC.md](JOURNAL-IMPLEMENTATION-SPEC.md)
- [JOURNAL-V1-SLICE.md](JOURNAL-V1-SLICE.md)
- [DISCOVERY-SOLUTIONS.md](DISCOVERY-SOLUTIONS.md)
- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md)

---

## 1. Ownership

The **server is authoritative** for all Journal knowledge.

The addon may cache a snapshot for the current session, but it may never create, promote, delete, or infer persistent knowledge on its own.

A `/reload`, logout/login, client crash, addon disable/enable, or moving to another machine must not change what the Remnant knows.

---

## 2. Persistence split

Use two layers:

### A. Generic discovery state

A single per-character table stores stable discovery facts shared by Survival and Gear and generic Journal observations.

Proposed logical shape:

```text
thalvaeth_player_discovery
- guid                 unsigned character guid
- namespace            stable machine namespace
- discovery_key        stable machine key inside namespace
- state                small integer / enum
- discovered_at        unix timestamp
- payload              optional compact structured data
- revision             schema/content revision for migrations
PRIMARY KEY (guid, namespace, discovery_key)
```

The exact SQL types can follow AzerothCore conventions, but the semantics above are locked.

### B. Creature-specific observation state

Keep `thalvaeth_player_creature_journal` for creature facts that are naturally row-shaped:

```text
- guid
- creature_entry
- sighted_at
- engaged_at
- observed_health_max
- observed_abilities
```

Do not duplicate creature HP/ability detail into the generic discovery table unless a later migration has a strong reason.

---

## 3. Stable namespaces

The first implementation uses these namespaces:

| Namespace | Purpose |
|---|---|
| `recipe` | learned preparation/process identity |
| `hint` | one-time near-miss knowledge |
| `material` | identity/property/use knowledge for gathered things |
| `gear` | weapon/armour/tool/charm upgrade knowledge |
| `process` | milestone process knowledge such as charcoal or distilling |
| `diagram` | explicit diagram/schematic knowledge where separate tracking is useful |

Creature progression remains in its specialised table.

Namespaces are **machine contracts**. Never rename them casually because player data will depend on them.

---

## 4. Stable key rules

Keys are lowercase ASCII dot paths.

Examples:

```text
recipe.ash_tea
hint.ash_tea.clean_water
hint.ash_tea.needs_heat
process.charcoal
hint.charcoal.low_air
material.ashbloom.identity
material.ashbloom.medicinal
material.gravecap.poisonous
gear.weapon.steel_blade
gear.weapon.greatsword
gear.armour.boiled_leather
gear.charm.stillstone
```

Rules:

1. Key identity never depends on player-facing copy.
2. Renaming `Ash Tea` in UI must not require changing `recipe.ash_tea`.
3. Keys never contain item IDs, spell IDs, display IDs, or DB row IDs unless the concept itself is fundamentally numeric.
4. Keys are append-only once shipped. Superseded keys are migrated, not silently reused.
5. One semantic fact gets one canonical key.

---

## 5. Generic discovery states

For generic records, use a monotonic state scale:

```text
0 = absent / unknown
1 = inferred
2 = known
3 = observed / deep-known
```

Not every namespace must use every state.

Examples:

- `recipe.ash_tea`: inferred → known.
- `material.gravecap`: known identity → observed poisonous property.
- `gear.weapon.greatsword`: inferred silhouette → known after diagram/discovery.
- `hint.*`: normally jumps directly to known and never advances again.

State changes are **monotonic** unless an explicit future system introduces forgetting, which v1 does not.

---

## 6. Payload policy

`payload` exists for facts that cannot be represented by state alone.

Allowed examples:

- first-observed qualitative tag;
- discovered sub-use list where a normalised table would be excessive for v1;
- optional source metadata for debugging/migration.

Do **not** turn payload into an unstructured dumping ground.

Prefer a new stable discovery key over opaque payload whenever the fact matters independently to gameplay or UI.

Example: use

```text
material.ashbloom.medicinal
```

rather than hiding `{"medicinal":true}` inside `material.ashbloom`.

---

## 7. Idempotent grant contract

Every persistence write must behave as an idempotent **grant or promote** operation.

Conceptually:

```text
GrantDiscovery(guid, key, state)
```

must:

1. insert when absent;
2. promote only when `new_state > current_state`;
3. preserve original `discovered_at` unless design explicitly wants a separate promoted timestamp;
4. never downgrade;
5. return whether the call actually changed player knowledge.

That return value drives Journal-update notifications and network deltas.

---

## 8. Hint persistence

Each hint is its own discovery key.

Example:

```text
hint.ash_tea.clean_water
hint.ash_tea.needs_heat
```

If the player repeats the same failure after learning its hint, the evaluator may still return the same failure reason for gameplay purposes, but the persistence layer reports **no new knowledge** and no new Journal notification is generated.

A recipe can have multiple hint keys learned over several attempts.

---

## 9. Recipe discovery

Successful discovery grants the recipe/process key only after all hard gates pass.

Examples:

```text
recipe.ash_tea = known
process.charcoal = known
recipe.stitch_kit = known
```

If the recipe was already known, crafting it again is ordinary crafting, not a discovery event.

A quality-poor success remains a success. Hidden quality belongs to the crafted result, not the knowledge table.

---

## 10. Material knowledge

Material knowledge is layered deliberately.

For a material such as Gravecap:

```text
material.gravecap.identity
material.gravecap.poisonous
material.gravecap.use.poison_coat
```

The Remnant may therefore know what a thing is without knowing what it does, and know a property without knowing every use.

Collection alone must not automatically grant every property.

---

## 11. Gear knowledge

Gear tree nodes are tracked independently of actual owned gear.

Examples:

```text
gear.weapon.crude_dagger
gear.weapon.iron_knife
gear.weapon.steel_blade
gear.weapon.greatsword
gear.weapon.twin_blades
```

Owning a node's item does not necessarily mean the Remnant knows how to make or upgrade to it unless the acquisition path explicitly teaches that knowledge.

The UI may render an inferred hidden node from topology while its `gear.*` record is only state 1.

---

## 12. Character isolation

All Journal progress is character-specific.

Two Remnants on the same account may know different recipes, creatures, hints, and gear branches.

Do not key discovery by account ID.

---

## 13. Deletion/reset semantics

Normal gameplay never deletes Journal knowledge.

For development and testing, provide explicit GM/admin reset tooling at namespace or whole-character scope.

Examples conceptually:

```text
.thalvaeth journal reset all <player>
.thalvaeth journal reset hint <player>
.thalvaeth journal grant recipe.ash_tea known <player>
```

Exact command names are implementation detail; capabilities are required for testability.

---

## 14. Migration rules

When keys change or concepts merge:

1. write an explicit migration;
2. preserve player knowledge;
3. never repurpose an old key to mean a different thing;
4. keep migrations deterministic and repeat-safe;
5. bump content/data revision where useful.

If a feature is removed, stale discovery rows may remain harmlessly or be migrated away. They must not accidentally map to a new concept later.

---

## 15. Indexing / query expectations

Hot paths:

- full Journal snapshot for one `guid` at login/reload;
- point lookup of one discovery key during evaluation;
- grant/promote one key after an event;
- enumerate hints/recipes/material uses for snapshot construction.

Primary key `(guid, namespace, discovery_key)` satisfies the main access pattern. Add extra indexes only after profiling shows need.

---

## 16. Transaction boundaries

A successful discovery attempt may mutate inventory and knowledge together.

Implementation should avoid states where:

- ingredients are consumed but the recipe grant is lost;
- recipe is granted but success output is not produced;
- one hint is persisted twice through retries.

Where practical, group the authoritative crafting outcome and Journal grant into the same logical operation/transaction boundary.

---

## 17. Snapshot projection

The server does not have to expose DB rows directly to the addon.

Build a safe projection containing only player-visible state:

```text
namespace
key
state
safe payload fields
```

Never send:

- undiscovered recipe truth;
- exact hidden solution requirements;
- future hint text/keys the player has not earned;
- hidden quality maths;
- internal WoW spell names;
- server-only IDs that leak answers.

---

## 18. Definition of done for persistence

The data layer is implementation-ready when all of these are true:

- generic discovery rows are character-specific;
- grant/promote is idempotent and monotonic;
- duplicate hint attempts do not duplicate knowledge;
- a complete snapshot can be rebuilt from DB state alone;
- `/reload` changes nothing persistent;
- two characters on one account remain isolated;
- migrations can rename/deprecate keys without data loss;
- admin reset/grant tooling exists for testing;
- hidden server truth is not represented in the client snapshot.