# Server scripts (copy to AC fork)

| File | Purpose |
|------|---------|
| `ThalvaethCommon.h` | Entry band, spell IDs, addon wire helper |
| `ThalvaethDirector.cpp/.h` | Wave spawn stub (Caller → Scavengers) |
| `ThalvaethCreatures.cpp` | Sleeper, Caller, Rafter, Snare, Stalker, Brute AI |
| `ThalvaethCreatureJournal.cpp` | Sighted/engaged DB + ThalvaethUI addon sync |
| `ThalvaethRunGates.cpp` | Segment + extract gate scripts |
| `ThalvaethScriptLoader.cpp` | Calls `AddSC_thalvaeth_all()` |

## Wire-up

1. Copy all files to `src/server/scripts/Custom/`
2. Add sources to `Custom/CMakeLists.txt`
3. Call `AddSC_thalvaeth_all()` from your custom script loader
4. Ensure `ScriptName` on templates matches `npc_thalvaeth_*` (see SQL)

Fodder (90002, 90008–90010) use **SmartAI** — see `rev_thalvaeth_fodder_smartai.sql`.

## SQL

| File | DB |
|------|-----|
| `rev_thalvaeth_creature_catalog.sql` | world |
| `rev_thalvaeth_fodder_smartai.sql` | world |
| `rev_thalvaeth_monastery_map.sql` | world — home (Hearthglen) |
| `rev_thalvaeth_run_district.sql` | world — Rotwood AT + entry |
| `rev_thalvaeth_run_gates.sql` | world — fence shell + gates |
| `rev_thalvaeth_poc_spawns.sql` | world — creatures in Rotwood |
| `rev_thalvaeth_creature_journal.sql` | characters |
