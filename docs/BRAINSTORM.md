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

## Disk

The always-on external drive on the server is the right home for
`fractured-server` (clone, two CMake builds, map extract). The git
repo stays on the internal disk. MySQL datadir stays on the internal
disk. Logical path remains `/home/scott/fractured-server` as a
symlink so a dead USB cannot hang AICraft boot (`nofail` + Fractured
units require the mount). Do the move before AC clone. Details:
`docs/DEPLOY.md`.

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
