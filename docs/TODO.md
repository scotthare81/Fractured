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
      `docs/DEPLOY.md`. Isolation agreed. Live/dev folders, ports,
      and external-disk ops tree written. Clone/build AC still waits
      for the rest of Step 2.
- [ ] **AC module skeleton** — Step 2. Source in `src/mod-fractured`
      (stubs: meters, Gate, morgue). Compile after AC clone +
      `scripts/link-module.sh`.

## Explicitly not on this list

- Building AzerothCore during Step 1.
- Fixing AutoBalance for “Scott + 9 bots in Molten Core” (AiCraft-WotLK
  only).
- Post-launch content patches as a substitute for L14.
