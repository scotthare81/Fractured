# Gear & weapons — upgrade-only

**You never find gear in a run — only materials to make what you have better** ([MATERIALS.md](MATERIALS.md)). All power progression is *crafted and discovered*, not looted.

- **Gear persists.** It is **not** lost on death — only the run haul + satchel are ([SURVIVAL.md](SURVIVAL.md)). You keep your upgraded kit; a bad run costs you materials and time, not your sword.
- **Upgrade at Monastery stations** (forge, workbench, stitch table) with **materials + a discovered diagram** for the next tier ([CRAFTING.md](CRAFTING.md)).
- **Tiers are gated by the discovery tree** — leather needs Tanning, mail needs Smelting, plate needs Steelworking (the Charcoal→Forge spine).
- Look holds L15: patchwork → worn-but-better. Even late gear reads as survived-in, not parade armour.

---

## Starting loadout (Tier 0)

Crude and minimal. Everything else is crafted/added.

| Slot | Start | Note |
|------|-------|------|
| Main hand | **Crude Dagger** | Chipped, scrap-bound; also your first butcher tool |
| Body | **Rag Armour** (cloth) | Basically rags — near-zero protection |
| Head | Rag Hood | Scrap hood |
| Bag | Small Brown Pouch (+ gather satchel) | Tiny carry |

Hands, feet, waders, pack, charms, a real weapon — all earned through crafting.

---

## Weapons — one blade early, two styles late

Everyone starts with the **crude dagger** and climbs a shared early line: `Crude Dagger → Fitted Knife/Short Blade (iron) → Steel Blade`. **Late-game the line forks into a style you commit to** (needs Forge/Steel + a discovered diagram) — this is the high-end choice:

| Style | Forms | Feel | Tradeoffs |
|-------|-------|------|-----------|
| **Dual-wield (fast)** | Paired 1H **swords** or **daggers** | Flurry, bleed, mobile | Low per-hit; **daggers also butcher well** — fight + harvest with one kit |
| **Two-handed (heavy)** | **Greatsword** or **Greataxe** | Slow swing, huge hits, stagger/cleave | Heavy: high **Vigor** cost per swing, slow, **loud**; a **poor butcher tool** → you still need a skinning knife |

**The butcher-tool tension:** a knife stays useful no matter what. Dual-daggers do double duty (combat + butchering); a 2H build trades harvest convenience for raw power and must carry a dedicated skinning knife. That's a real build decision, not just a damage number.

**Weapon upgrade axes:** damage · speed · reach · bleed · butcher yield · durability.
**Materials:** haft (deadwood/green wood), edge (iron → steel → bronze), inlay (bone/tusk/fang for grips & weight).
**Durability:** blades dull with use → **sharpen** (whetstone, field-ok) or **mend** (forge). Broken = heavy penalty, never lost ([CRAFTING.md](CRAFTING.md)).

---

## Armour — weight classes (rags → plate)

Armour climbs **weight classes**, each gated by a discovery and each a **build identity** — heavier trades quiet and stamina for survivability. It is *not* just a bigger number.

| Class | Gate | Protection | Survival cost |
|-------|------|-----------|---------------|
| **Cloth / Rags** (start) | — | ~none | Silent; no Vigor cost — pure stealth |
| **Leather** | Tanning | Light + a little Infection-resist | Quiet; cheap Vigor — mobile |
| **Mail** | Smelting / Iron | Medium + Infection-resist | Heavier: more Vigor drain, more noise |
| **Plate** (late) | Steelworking / Forge | Max + best Infection-resist | Heavy: big Vigor drain, **loud**, slower |

So light armour (cloth/leather) is the **stealth/hauler** — quiet past Sleepers, cheap on Vigor; **plate** is the **fighter** who trades silence and stamina for staying alive in a stand-up fight. The body piece sets the class; other slots match its weight.

---

## Slots & upgrade axes (couple to survival)

| Slot | Piece | Upgrade axes → |
|------|-------|----------------|
| Head | Cowl/Hood | Noise ↓ (sneak → Vigor economy), light |
| Body | Coat (cloth→plate) | Mitigation, **Infection-resist**, some warmth |
| **Shirt** | Under-layer (padded/fur) | **Warmth** — independent of armour class |
| **Tabard** | Over-wrap / mantle | **Warmth** + sheds weather |
| **Neck** | Scarf / muffler | **Warmth** + covers the face (cold/fog) |
| Hands | Wraps/Gloves | Butcher yield, grip, mend efficiency |
| Legs/waist | Waders | Wet districts, carry |
| Feet | Boots | Noise, footing/speed |
| Back | Pack | Main-bag slots **+ satchel size** |
| Main hand | Blade (see Weapons) | Damage/speed/reach/bleed/butcher |
| Utility | whetstone / torch / focus | Situational |
| Charm ×2 | aptitude / passive charms | Run up to 2 aptitudes, **or** trade a slot for a Vigor / Infection-resist / warmth perk ([APTITUDES.md](APTITUDES.md)) |

The same fixed kit becomes a **stealth** build (low-noise cowl/boots/leather), a **fighter** (plate + heavy blade), or a **hauler** (pack/carry) — build diversity from upgrade choices, every upgrade a materials decision against barter and consumables.

> **Warmth layer (shirt, tabard & neck slots).** WotLK's cosmetic **shirt**/**tabard** slots and the **neck** slot are co-opted for a **warmth layer** — a padded/fur under-shirt, a mantle/wrap, and a scarf/muffler (covers the face in cold or fog), crafted from fur/pelt/padding ([CRAFTING.md](CRAFTING.md)). Warmth is deliberately **independent of armour class** so a light-armour stealth build isn't forced into plate to stay warm. It's an **environmental fit** (like waders for wet): it offsets **cold** (night, weather, **snow runs**) that would otherwise tax Vigor/Hunger — and in **heat** (Burn spaces) *too much* warmth backfires into Thirst. The slots stack for deep cold.

---

## Upgrading — how it works

1. Bring **materials** + a **discovered diagram** (found knowledge — the "find" that replaces gear drops, [MATERIALS.md](MATERIALS.md) §10) to the right **Monastery station**.
2. The tier must be **unlocked on the discovery tree** ([CRAFTING.md](CRAFTING.md)) — no plate before Steelworking.
3. **Quality (Model C)** applies: better inputs → weighted-better result. No skill levels.

**Tier depth (default, tunable):** ~4 steps per line — weapons `Crude → Fitted → Reinforced → Masterwork`; armour `Cloth → Leather → Mail → Plate`. Bounded — v1.0 ships complete (L14).

---

## Open

| Item | Notes |
|------|-------|
| Slot list | Confirm final slots (dedicated skinning-knife/off-hand for 2H builds?) |
| Wear rates | Per-slot degrade + sharpen/mend costs |
| Diagram gating | Which upgrade tiers are experiment-able vs diagram-only |
| Charm slots | 2 slots, aptitude vs passive — pinned in [APTITUDES.md](APTITUDES.md); confirm count |
| Tier count | Confirm 4 vs 3 steps per line |
| Cold as a factor | Warmth is an environmental fit for now — **snow runs** would make cold a real gate; decide if cold becomes a tracked factor/meter ([MAPS.md](MAPS.md)) |

---

## Related

- [CRAFTING.md](CRAFTING.md) — recipes, discovery tree, stations, durability
- [MATERIALS.md](MATERIALS.md) — upgrade materials + diagrams
- [SURVIVAL.md](SURVIVAL.md) — noise / Vigor / Infection that gear tunes
- [APTITUDES.md](APTITUDES.md) — charm-slot aptitude items
- [CONTENT.md](CONTENT.md) — spawn kit
