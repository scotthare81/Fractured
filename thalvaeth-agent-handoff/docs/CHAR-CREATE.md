# Character create

## Player fantasy

You are a **Remnant** — not a hero, not a class icon. One of the last who still chooses to walk the Wild.

## Restrictions (locked)

| Field | Value |
|-------|--------|
| Races | Human (hidden OK) |
| Classes | Rogue chassis → **Remnant** label |
| Faction | Neutral/solo — no faction PvP |
| Spells | Strip at first login; aptitudes only |

## Flow

1. Stock character create → Human + Rogue
2. `OnPlayerFirstLogin` — remove spells, apply Patchwork + Cowl, grant aptitude passives
3. ThalvaethUI — rename class/race strings; hide spellbook tab

## Starting place

First login → **Thal'vaeth Monastery** — Hearthglen grounds (map **0**, outdoor WPL; grey/Brill palette via MPQ).

First run: **Rotwood** (map **0**, Duskwood worgen cluster — gated outdoor). See [NAMES.md](NAMES.md), [MAPS.md](MAPS.md).

## Open

- Name filter (lore-appropriate)
