# TODO — implementation status

## Maps

- [x] Home — **Thal'vaeth Monastery** at **Hearthglen** (map 0)
- [x] Run — **Rotwood** outdoor Duskwood worgen cluster (map 0, gated)
- [x] Gate SQL shell + segment + extract (91001+)
- [ ] Phase 1/2 split (home vs run)
- [ ] MPQ — Hearthglen Brill-grey
- [ ] Strip vanilla spawns (incl. Nightbane worgen) inside Rotwood AT
- [x] Director/run pacing sketched — `DIRECTOR.md` (rhythm, heat/noise, segments, hooks)
- [ ] Director segment gate open hooks
- [ ] Tune fence ring coords in GM mode
- [ ] Future runs (proposed): snow/cold (warmth gate) + fog (visibility) — `MAPS.md`; decide if cold is tracked

## Creatures

- [x] Catalog + C++ specials + fodder SmartAI
- [x] POC spawns in Rotwood (phase 2)
- [ ] Sleeper damage tune
- [ ] MPQ Sleeper eyes
- [ ] Persistent run health — `RegenHealth=0` (90001–90010); base AI keeps HP on evade/reset (Brute leash, Stalker flee); Director last-HP clamp; clear on `OnRunStart`
- [ ] Animal layer (90101+) — Rotwood Boar / Hound (worg model) / Deer / Hare, rare Rotwood Tusker; drops feed Hunger + barter
- [x] Animal naming convention `<District> <Kind>` locked in `NAMES.md`

## Items & crafting

- [x] `MATERIALS.md` — raw catalog (dropped / foraged / mined / scavenged, incl. reclaimed metals)
- [x] `CRAFTING.md` — recipes (food/drink/refining/smelt/forge), discovery (fragments + experiment/hints), stations, durability/mend
- [x] Discovery tree pinned — Tier 0 given vs milestone gates (Charcoal→Forge spine; tanning, brewing, distilling, preservation, waterproofing)
- [x] `GEAR.md` — upgrade-only (no drops): crude dagger + rags start; weapon styles (dual-wield vs 2H); armour classes cloth→plate; slots/axes
- [x] `ITEMS.md` — made & found catalog (crafting→breaking), invisible quality tiers, + fishing, expanded forage/mushrooms, traps, poisons
- [x] Armour ladder — full entry→endgame tiers per class (Leather: Boiled/Studded/Hardened; Mail: Ring/Riveted/Splinted; Plate: Half/Full); layering + endgame-per-playstyle
- [x] Weapon ladder — entry→endgame (shared early blade → dual-wield vs 2H); iron/steel/bronze tradeoffs; weapon-as-tool utility (butcher/wood)
- [ ] Gear tuning — per-slot wear rates, tier count (3 vs 4), diagram gating, skinning-knife slot for 2H builds
- [ ] Item tuning — per-item IDs (60xxx), poison balance, fish/trap yields, mushroom tells
- [x] Bulk model — items have bulk 1/2/4; bags/satchel are bulk pools (worn = free); v1 = capacity budget
- [ ] Fancy grid inventory (future) — footprint UI in ThalvaethUI + server-side virtual inventory (bulk values become footprints)
- [ ] Assign per-item IDs in the 61xxx material bands
- [ ] Author meaningful near-miss rules + stable hint keys for v1 recipes (not generic random-combination hints)

## Economy

- [ ] `ECONOMY.md` — tiered barter (no coin), material ladder, Monastery keepers
- [x] Corruption replaced by **Infection** (plague raises, Stitch/tincture cures)
- [x] Survival interlock — `SURVIVAL.md` (Vigor hub; meters erode Vigor; collapse-only fail)
- [ ] Survival tuning — Vigor field ceiling + walk trickle; Hunger/Thirst tick vs exertion; Infection rise/cure/Fevered thresholds
- [ ] Gather satchel — allow-list, size + upgrade curve, lost-on-death
- [ ] Survival clocks — Hunger + Thirst tuning; raw-meat spoil timer

## Journal / UI

- [x] Creature journal table + addon wire stub
- [x] Journal Record design — **Creatures / Survival / Gear** tabs, silhouettes/obscured knowledge, persistent near-miss hints (`JOURNAL-RECORD.md`)
- [ ] Build tabbed Journal Record shell in `ThalvaethUI`
- [ ] Full server→addon state sync after login and `/reload` (server authoritative; no SavedVariables discovery authority)
- [ ] Render Creature tab: Unknown silhouette → Sighted → Engaged/observed
- [ ] Wire `observed_abilities` spell→journal-key capture
- [ ] Add generic per-character discovery persistence for recipe/material/gear/hint knowledge
- [ ] Render Survival categories: Food / Water / Medicine / Herbs & Fungi / Fishing / Poisons / Traps & Fieldcraft
- [ ] Implement near-miss craft evaluation → persistent diegetic hints; duplicate mistakes do not create duplicate knowledge
- [ ] Render Gear categories: Weapons / Armour / Tools / Charms with partially obscured upgrade trees
- [ ] Author/set unknown silhouettes and greyed icons so hidden names cannot leak through tooltips/search/sort data
- [ ] Add restrained `Journal updated` notification levels (new entry / hint / observation)
- [ ] Journal art polish only after functional discovery loop is proven

## Aptitudes & charms

- [x] Charm/aptitude items — charms grant aptitudes (2 slots; aptitude vs passive); craft from materials; invisible quality; upgradeable
- [ ] Confirm charm slot count; pick which proposed aptitudes (Night Eyes / Iron Gut / Deadened Step / Steady Hand / Second Wind) ship v1

## Client / branding

- [x] Brand concept set — splash, wordmark logo, circular seal, red-eyes emblem (`docs/branding/`)
- [x] `CLIENT-BRANDING.md` — login-reskin + patch-MPQ plan (concept-stage)
- [ ] Rebuild the wordmark in real weathered-serif type (verify "Thal'vaeth" spelling; esp. the seal's curved ring)
- [ ] Produce shippable assets (BLP export, login dimensions) + original login music
- [ ] Decide: crest-only vs crest + corner wordmark; blood-red vs ash-orange accent
- [ ] Build the login glue patch (hide 3D scene → static splash; strings/version/copyright)

## Core

- [ ] Spell strip + Remnant first login
- [ ] Port Hearthglen ↔ Rotwood entry
- [ ] Stress Director (full)
