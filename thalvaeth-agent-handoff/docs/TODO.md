# TODO — implementation status

## Maps

- [x] Home — **Thal'vaeth Monastery** at **Hearthglen** (map 0)
- [x] Run — **Rotwood** outdoor Duskwood worgen cluster (map 0, gated)
- [x] Gate SQL shell + segment + extract (91001+)
- [ ] Phase 1/2 split (home vs run)
- [ ] MPQ — Hearthglen Brill-grey
- [ ] Strip vanilla spawns (incl. Nightbane worgen) inside Rotwood AT
- [ ] Director segment gate open hooks
- [ ] Tune fence ring coords in GM mode

## Creatures

- [x] Catalog + C++ specials + fodder SmartAI
- [x] POC spawns in Rotwood (phase 2)
- [ ] Sleeper damage tune
- [ ] MPQ Sleeper eyes
- [ ] Persistent run health — `RegenHealth=0` (90001–90010); base AI keeps HP on evade/reset (Brute leash, Stalker flee); Director last-HP clamp; clear on `OnRunStart`
- [ ] Animal layer (90101+) — Rotwood Boar / Hound (worg model) / Deer / Hare, rare Rotwood Tusker; drops feed Hunger + barter
- [x] Animal naming convention `<District> <Kind>` locked in `NAMES.md`

## Economy

- [ ] `ECONOMY.md` — tiered barter (no coin), material ladder, Monastery keepers
- [x] Corruption replaced by an infection meter (plague raises, Stitch/tincture cures)
- [ ] Finalize infection-meter name (working: Fester; not "Rot")
- [ ] Gather satchel — allow-list, size + upgrade curve, lost-on-death
- [ ] Survival clocks — Hunger + Thirst tuning; raw-meat spoil timer

## Journal / UI

- [x] Journal table + addon wire stub
- [ ] Journal panel UI

## Core

- [ ] Spell strip + Remnant first login
- [ ] Port Hearthglen ↔ Rotwood entry
- [ ] Stress Director (full)
