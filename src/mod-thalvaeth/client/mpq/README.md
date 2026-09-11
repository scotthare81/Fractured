# MPQ patches (stock client)

Pack everything as `patch-thalvaeth.MPQ` in `Data\`.

---

## 1. Hearthglen — Brill-adjacent palette (home)

Make **Thal'vaeth Monastery** (Hearthglen grounds) read like **Tirisfal** — grey sky, cold fog, dead grass — not green Argent crusader camp.

### Reference captures (in-game)

Teleport and screenshot for fog/light values:

| Place | game_tele | Use for |
|-------|-----------|---------|
| **Brill** | `2259, 290, 34` | Fog colour, ambient grey |
| **Deathknell** | (undead start) | Overcast, bare trees |
| **Stock Hearthglen** | `2793, -1621, 129` | Before — what we’re fixing |

### MPQ edit order (easiest → hardest)

| Step | File(s) | Action |
|------|---------|--------|
| 1 | `DBFilesClient\Light.dbc` / `LightIntBand.dbc` | For Hearthglen area light IDs: lower direct ambient, raise fog density, shift fog toward grey-purple (match Tirisfal rows — extract both zones with WoW DB Editor) |
| 2 | `DBFilesClient\AreaTable.dbc` | Hearthglen sub-area IDs: tint ambient multiplier down; optional zone music mute flag |
| 3 | `World\Maps\Azeroth\Azeroth_xx_yy.adt` | Only if v1 fog isn’t enough: swap ground BLP refs in Hearthglen cells to Tirisfal dirt/dead grass BLPs (Noggit/AdtEdit — bounded bbox ~2790,-1620) |
| 4 | WMO (optional) | Abbey banner textures → desaturate or replace with grey cloth |
| 5 | `Sound\Music\` (optional) | Silence or replace zone track in home |

### What NOT to do

- No green-glowing Fel tint — mundane plague grey only
- No custom ADT geometry v1 — recolor/light only
- Don’t globally retile all WPL — **Hearthglen bbox only**

### Server complement (no MPQ)

- Disable/hide crusader **gameobjects** (flags, braziers) in home areatrigger via SQL
- `SetZoneWeather` / zone script for fog if MPQ light pass is deferred

---

## 2. Sleeper eyes (DisplayID 22844)

Recolor **Wretched Husk** → ash/grey skin + **glowing red eyes** (90001 Ash Sleeper).

| Step | Action |
|------|--------|
| 1 | Extract `Creature\WretchedHusk\` from `patch-3.MPQ` |
| 2 | Desaturate skin BLP → `thalvaeth_sleeper_skin.blp` |
| 3 | Eye glow → `thalvaeth_sleeper_eyes.blp` |
| 4 | Patch `WretchedHusk.m2` material refs if needed |
| 5 | Pack in `patch-thalvaeth.MPQ` |

No spell VFX on the mesh — uncanny stillness + red eyes only.

---

---

## 3. Run fog — Duskwood / Mor'Ladim hill (Rotwood)

**Rotwood** runs on map **0** outdoors — native Duskwood zone 10 fog applies. No MPQ clone onto another map required for v1.

### Capture reference (in-game)

| Place | Coords | Notes |
|-------|--------|-------|
| **Mor'Ladim hill** | `-10363, 359, 53` | House on hill, east of Darkshire — fog reference |
| **Darkshire** | `-10573, -1182, 28` | Baseline Duskwood zone 10 atmosphere |
| **Rotwood center** | `-10736, -857, 55` | First run district AT |

### Server dynamic layer (primary)

Director calls `Map::SetZoneWeather(zone, WEATHER_STATE_FOG, 0.5–0.9)` at peaks on zone 10.

Optional MPQ pass: tune Duskwood `Light.dbc` rows if baked fog needs a nudge — bounded to worgen cluster bbox only.

### Ground mist fallback

If a choke reads flat: place stock **ground mist** gameobjects in Snare alcoves — fog **feel** without changing zone-wide light.

---

## Deploy

Copy `patch-thalvaeth.MPQ` next to other patches. Restart client after DBC edits.
