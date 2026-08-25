# Fractured — Content

Items, creatures, crafting chains, and client patch (MPQ) notes. Player-
facing names and stats are original. Visuals may clone obscure WotLK
assets.

Do not commit this work into AiCraft-WotLK. Custom items SQL, instance
templates, Gate script, Journal UI, and the survival meter module are
Fractured implementation, later, in this project’s own tree.

## Visual philosophy

Clone **obscure** WotLK assets. Rename, re-stat, re-icon. Avoid iconic
WoW silhouettes that a friend will name on sight (Ashbringer-class
weapons, raid tier shapes, famous helm models).

Starter gear is **patchwork / ragged**. You look like you were issued a
Sanctuary kit or you found something that already failed once. Power
fantasy armor is a Wild dividend, and even then it should look worn.

MPQ exists so the client can lie in our favor: load screens, survival
icons, zone music, optional AreaTable renames. The engine is WotLK; the
brochure is Fractured.

Rules of thumb:

- If a friend would say the WoW item name out loud, pick a different
  model.
- If the item is a tool (knife, cleaver, waders), the silhouette should
  read as a tool, not as a dungeon drop.
- Icons for Hunger / Thirst / Corruption must not be reused Blizzard
  raid-debuff art if we can ship our own (MPQ Tier A).

## Item clone sources

IDs are WotLK 3.3.5a references for **display / starting point**, not
player-facing names. Final Fractured names TBD (`docs/TODO.md`).

| Role | WotLK ID / ref | Use |
|------|----------------|-----|
| Knife | 5278 | Butcher / fieldcraft |
| Machete | 1219 | Brush / light combat |
| Cleaver | 2827, 1292 | Heavy butcher |
| Starter armor | patchwork / ragged | Sanctuary issue or find |
| Hive mask | Mask of the Unforgiven model | Hive spore ward |
| Waders | TBD lowbie leather/cloth | Drown / Sink |
| Ward focus | TBD off-hand/trinket | Static / Ward |

Notes on the clone list:

- **5278** is a small knife energy: butcher first, fight second.
- **1219** is a brush-cutter: path-making and light combat, not a main
  tank stick.
- **2827** and **1292** are “this was a kitchen or a murder” cleavers.
  Heavy butcher. Slow. Earns the meat slot.
- Patchwork / ragged starter armor should be issuable in Sanctuary and
  findable in the Mouth so a corpse run (if any) does not require a
  fully naked tutorial.
- Hive mask uses the Unforgiven **model only**. Name it as a hive /
  spore piece in original IP. Stats are Fractured, not the dungeon item.
- Waders are a loadout Gate key for Drown and Sink. Pick the dullest
  lowbie leather/cloth that still reads as “I dressed for wet.”
- Ward focus is an off-hand or trinket that makes ward craft and Static
  survivable. TBD ID on purpose: do not grab a famous relic model.

Every findable item still obeys L7: it uses, or it breaks into something
that uses.

## Creatures

All player-facing names TBD. Stats new. Do not ship “worg” in the UI.

| Working family | Role | Notes |
|----------------|------|-------|
| Shades | Stalker edge | Persistent pressure; dread; Corruption/depth |
| Worg analogs | Wild predators | Combat tax; hides / meat if butchered |
| Spiders / swarms | Hive language | Spore, wrap, panic; mask/ward payoff |
| Boar analogs | Forage beasts | Pork; aggression while you butcher |
| Deer analogs | Forage beasts | Venison; flight more than fight |
| Rabbit analogs | Forage beasts | Small meat; teaches spoilage and tiny stacks |

Forage beasts exist so Hunger is not a vendor problem. Species-specific
meats are the point (L5). Swarms exist so Hive is not “more wolves.”
Shades exist so Quiet is not an empty audio test.

Elite / rare / named mystery creatures belong to the lead pool, not to
this table. Do not fill the Wild with rare-farm targets that ignore
bags and spoilage.

## Consumables

All sit / channel unless a later note says otherwise. Partial restore
(L3). Tiny stacks (L6).

| Consumable | Stack (working) | Role |
|------------|-----------------|------|
| Raw meat (species) | ~5 | Spoils; cooks; Hunger tax |
| Stew | ~3 | Better than raw; still partial |
| Water | ~4 | Thirst; Burn makes this cruel |
| Tea | TBD | Corruption / district gates |
| Tincture | TBD | Apothecary base / travel dose |
| Salve | TBD | Cut, Burn, Static, mend-adjacent |
| Ward | TBD | Hive, Static, Ward district language |

Raw meat spoils. Stew lasts longer. Salt (district + crafting) is how
you fight the timer without winning it. Exact timers TBD.

There is no insta-chug health potion as a primary Wild plan. If a
tincture ever breaks sit/channel, that is an exception that must be
written down — default is channel and be vulnerable.

## Fieldcraft chain (sketch)

Full break/make table is open work. This is the spine so items have
somewhere to go.

```
                    carcass (forage beast or predator)
                              |
                           butcher
                              |
              +---------------+---------------+
              |               |               |
              v               v               v
            meat            hide            bone
              |               |               |
              |               tan             salvage
              |               |               |
              v               v               v
           cook /           wraps /         needle /
           spoil            leather         broth / rope
                              |
                            mend
                              |
                              v
                    repaired kit / rope
```

Paths:

- **Butcher** — knife or cleaver. Yield depends on tool and creature.
- **Tan** — hide → wraps (Cut) and leather scraps (mend, maybe waders
  repair).
- **Salvage** — bone and junk → needle, broth base, rope bits (Pit).
- **Mend** — spend scraps to keep the loadout alive. No skill levels.

Nothing on this graph is vendor trash. If a node has no consumer, cut
it or give it a consumer (L7).

## Apothecary chain (sketch)

```
         herb + ash + salt  --->  tincture (base)
                                      |
          district blooms ------------+
                                      |
              +-----------------------+-----------------------+
              |                       |                       |
              v                       v                       v
        gate teas                  salves                   wards
     (Ash, Drown, …)         (Cut, Burn, Static)      (Hive, Static, Ward)
```

- **Tincture** — the portable apothecary unit. Travel dose, not a raid
  flask.
- **District blooms** — Ashbloom and the rest. These feed **gate teas**
  so Corruption tolerance and district doors are crafted, not dinged.
- **Salve** — bleed, heat, grounding. Sit/channel to apply unless TBD
  says combat-usable for Cut specifically.
- **Ward** — crafted protection. Hive mask is adjacent (gear) but the
  ward item is the apothecary sentence.

Deep’s “multi-district tea complete” gate is the payoff for this chain
existing across the network, not a reagent vendor in Sanctuary.

## Cooking Model C

Same recipe, same quality band of ingredients:

| Result | Weight |
|--------|--------|
| Standard | 70% |
| Good | 20% |
| Best | 10% |

Quality in still matters: a poor carcass does not roll on the same band
as a careful butcher of a fresh deer. Model C is the *weighted spit*
after the band is chosen. There are **no cooking levels** (L4).

Stew is the named cooked output in the bag rules (~3 stack). Other
cooked forms may exist; they must still sit/channel and restore
partially.

## MPQ manifest

Client patch work is staged so we do not boil the ocean before friends
can log in. File lists inside each tier are TBD; the tiers are not.

### Tier A (ship for v1.0 feel)

- Load screens (Sanctuary, Mouth, representative Wild)
- Survival meter icons (Hunger, Thirst, Corruption)
- Core item icons (knife, stew, water, tea, salve, ward, wraps)

### Tier B (audio identity)

- District music (Quiet first, then the rest)
- Creature sounds (shades, swarms, forage beasts)

### Tier C (name hygiene and polish)

- AreaTable names (no WoW toponyms)
- Minimap
- Journal UI skin

Tier A is the minimum that makes the client feel like Fractured instead
of a misnamed private server. Tier C is how L15 stays true when someone
opens the map.

Do not store large MPQ binaries in this git repo. `.gitignore` already
excludes `*.mpq`. Lists and notes live here; blobs live elsewhere.

## Implementation notes (future)

When Scott asks for engine work, expect roughly:

| Piece | Where it lives | Do not |
|-------|----------------|--------|
| Custom items SQL | Fractured data, not AICraft | Do not PR into AiCraft-WotLK |
| Instance templates | Per-district; IDs from WORLD.md table | Do not silently reuse famous instances |
| Gate script | Sanctuary object; bot block; party leader | Do not allow playerbots through |
| Journal UI | Record only; no quest tracker | Do not add objectives |
| Survival meter module | Hunger / Thirst / Corruption | Do not use raid-debuff UX as the metaphor |

Deploy pipeline is separate from AICraft (`docs/TODO.md`). Documentation
in this repo stays the source of truth until those modules exist.

Bag sizes, stack sizes, and clone IDs above are working numbers. Change
them in playtest; do not “fix” them by restoring retail bag culture.
