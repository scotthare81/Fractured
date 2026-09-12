# Journal UI specification

This document defines how the Journal Record should look and behave before implementation begins. It is a presentation/interaction contract for the ThalvaethUI addon.

The Journal is not a codex dump and not a quest log. It is a worn field record that becomes more legible as the Remnant learns.

Related canon:

- [JOURNAL-RECORD.md](JOURNAL-RECORD.md)
- [JOURNAL-CONTENT.md](JOURNAL-CONTENT.md)
- [JOURNAL-HINTS.md](JOURNAL-HINTS.md)
- [JOURNAL-IMPLEMENTATION-SPEC.md](JOURNAL-IMPLEMENTATION-SPEC.md)

---

## 1. Top-level structure

The Journal has exactly three top-level tabs in v1:

- **Creatures**
- **Survival**
- **Gear**

Do not add Materials, Quests, Places, Achievements, Collections, or Recipes as top-level tabs in v1.

Subcategories belong inside the relevant tab.

---

## 2. Overall visual direction

Target feel:

- worn field notebook;
- charcoal/ink/ash palette;
- muted parchment or dark cloth rather than bright Warcraft parchment;
- restrained borders;
- weathered serif headings where technically practical;
- hand-mark/field-note accents used sparingly;
- no gold quest flourishes;
- no achievement shine;
- no retail-WoW collection aesthetic.

The frame should feel like something a Remnant carries, not a system menu.

---

## 3. Frame anatomy

Recommended frame:

```text
┌──────────────────────────────────────────────────────────────┐
│ JOURNAL RECORD                              [close]           │
│ [CREATURES] [SURVIVAL] [GEAR]                                 │
├──────────────────────┬───────────────────────────────────────┤
│ index/categories     │ selected record                       │
│                      │                                       │
│ silhouettes          │ image/silhouette                      │
│ known entries        │ name                                  │
│ inferred entries     │ notes                                 │
│                      │ uses / hints / observations            │
└──────────────────────┴───────────────────────────────────────┘
```

The left pane navigates. The right pane explains.

---

## 4. Opening and closing

The Journal should be accessible through:

- a dedicated addon button or keybind;
- optional slash command for development;
- future in-world Journal object if desired.

Opening the Journal should restore:

- last top-level tab;
- last selected subcategory;
- last selected entry if still visible.

It should not reopen automatically because a discovery occurs during danger.

---

## 5. Snapshot/loading state

Before full server sync completes:

- show the Journal shell;
- show `Reading notes…` / equivalent subtle state;
- do not render partial knowledge as final;
- do not reveal hidden static labels while waiting.

If sync fails:

> Journal unavailable.

No fake empty journal.

---

## 6. Shared discovery presentation

### Unknown

Use:

- dark silhouette;
- grey/charcoal icon;
- masked title such as `— — —`;
- no hidden tooltip answer;
- no coloured rarity frame;
- no searchable secret name.

### Inferred

Use:

- clearer silhouette or outline;
- partial recipe/process shape;
- one or more visible `???` slots where justified;
- persistent hints below;
- no actual hidden result name.

### Known

Use:

- resolved icon;
- real name;
- known description/process;
- linked uses already learned.

### Observed

Adds deeper facts:

- witnessed creature ability;
- observed vitality;
- known material property;
- quality/process note;
- use relationship.

---

## 7. Silhouette rules

Silhouettes are a core mechanic, not placeholder art.

Requirements:

- silhouette shape may imply broad category but not exact hidden answer;
- unknown weapon node may look like `blade`, not reveal `Greatsword` art exactly;
- unknown recipe may use vessel/food silhouette rather than its final item icon;
- creature silhouette should preserve dread and recognisability without leaking the journal name;
- silhouette tooltip must remain blank or generic.

Do not simply desaturate the final exact icon if the icon itself gives away the answer.

---

## 8. Hidden text rules

Never reveal unknown text through:

- tooltip;
- frame name;
- search/filter token;
- debug label in normal builds;
- hyperlink;
- icon texture path displayed to player;
- mouseover accessibility label if it contains the secret answer.

Masked text should be presentation-only over safe data.

---

# Creatures tab

## 9. Creature index

Left pane:

```text
[ silhouette ] — — —
[ portrait   ] Ash Sleeper
[ portrait   ] Cellar Scavenger
[ silhouette ] — — —
```

No `7/10 discovered` headline.

Sorting recommendation:

- fixed catalogue order, or
- first-seen order only if it does not leak unknown roster structure.

For v1, fixed catalogue positions are acceptable because the design already allows some unknown silhouettes to signal that something exists.

---

## 10. Creature unknown page

Right pane shows:

- large grey silhouette;
- `— — —`;
- perhaps one neutral line such as `No useful notes.`

Must not show:

- location;
- counter;
- role;
- HP;
- abilities;
- archetype/internal tag.

---

## 11. Creature sighted page

Show:

- name;
- muted portrait/silhouette resolved enough to identify;
- sighted description;
- optional player-facing classification only if deliberately authored.

Example:

```text
ASH SLEEPER

Crouched like sleep. Eyes open. Don't run past it.
```

No combat counter text unless learned through actual observation and explicitly designed.

---

## 12. Creature engaged page

Add:

- observed vitality band;
- observed ability list;
- deeper field notes.

Preferred vitality language:

- Frail
- Hardy
- Tough
- Brutal

Exact values can remain available to debug builds but should not be the default player-facing presentation.

---

## 13. Ability rows

Unknown ability row options:

- entirely absent; or
- one grey scribble line if the player has inferred more behaviour exists.

Known ability example:

```text
Throws a hook
Drags you into the choke.
```

No raw spell IDs or vanilla names.

---

# Survival tab

## 14. Survival subcategories

Use internal category list/buttons:

- Food
- Water
- Medicine
- Herbs & Fungi
- Fishing
- Poisons
- Traps & Fieldcraft

A compact vertical category list is preferable to another full row of tabs.

---

## 15. Survival index behaviour

Each category shows only:

- known entries;
- inferred silhouettes the player has earned;
- born-known basics where applicable.

Do **not** show the entire global recipe catalogue as 100 rows of `???`.

Unknown entries only appear once there is a reason the Remnant knows that something exists.

---

## 16. Recipe page anatomy

Known recipe page:

```text
ASH TEA

[icon]

Ashbloom
Clean Water
Heat

Eases Infection.

FIELD NOTES
- The water needs to be clean.
- The leaves need heat to give anything useful.
```

Important:

- known recipe ingredients/process can be explicit once discovered;
- old hints may remain as history;
- exact hidden potency numbers are not shown by default.

---

## 17. Inferred recipe page

Example:

```text
[grey bottle]
— — —

Ashbloom
+ [water]
+ ???

NOTES
- The water needs to be cleaner.
```

This is the core discovery feel: enough structure to reason, not enough to copy an answer.

---

## 18. Hint presentation

Hints belong under a distinct **Field Notes** heading.

Rules:

- order hints by learned time or authored logical order;
- no hint strength labels (`weak`, `medium`, `strong`) shown to player;
- no hint keys;
- no checkboxes;
- no `1/3 clues found` counter;
- repeated hint not duplicated.

New hint may briefly mark the page with a subtle ink dot/bookmark.

---

## 19. Food pages

Useful display fields:

- preparation name;
- known base ingredients;
- process/station;
- qualitative survival effect;
- preservation note;
- learned hints/history.

Do not expose hidden quality percentages.

---

## 20. Water pages

Water should visually read as process progression:

```text
Foul Water → Boil → Drinkable Water
                   
Foul Water → [grey process] → ???
```

After charcoal discovery, the second process may clarify.

The UI should allow the player to see that better purification exists without giving it away prematurely.

---

## 21. Medicine pages

Display:

- wound vs Infection role;
- application type;
- qualitative effect;
- known preparation;
- field notes.

Example terms:

- Closes wounds
- Cleans wounds
- Slows bleeding
- Eases Infection
- Restores some Vigor

Avoid pseudo-medical precision that breaks the setting.

---

## 22. Herbs & fungi pages

A plant/fungus record should evolve.

Possible sections:

```text
GRAVEMOSS

Found on damp stone.

KNOWN PROPERTIES
Medicinal

KNOWN USES
Poultice
[grey bottle] ???

FIELD NOTES
...
```

If poisonous status is unknown, do not show a poison icon/category prematurely.

---

## 23. Fishing pages

Fishing category can contain two internal views:

- **Methods** — rod, line, hook, trap/weir, net;
- **Catch** — identified fish and learned uses.

Do not create a fourth global tab.

A fish record can reveal uses incrementally:

```text
EEL

Known uses:
Grilled
[grey smoke icon] ???
[grey oil icon] ???
```

---

## 24. Poison pages

Keep visual framing mundane and grim, not spellbook-like.

Show:

- application method;
- fictional ingredient/process once learned;
- observed effect in game terms;
- learned risk notes.

No bright poison-school colours or magical glyph presentation.

---

## 25. Traps & fieldcraft pages

Display simple diagrams/silhouettes where possible:

- trigger;
- anchor;
- loop/net/fall component;
- known intended use.

Unknown construction details remain greyed.

---

# Gear tab

## 26. Gear subcategories

- Weapons
- Armour
- Tools
- Charms

Use a tree/branch presentation where progression matters.

---

## 27. Weapon tree

Preferred layout:

```text
Crude Dagger
    │
Iron Knife
    │
Steel Blade
   / \
 ???  ???
```

When one branch resolves:

```text
Steel Blade
   / \
Greatsword  ???
```

The unknown branch remains visually present if inferred.

---

## 28. Gear node states

### Unknown/uninferred

Do not display node.

### Inferred

- generic silhouette;
- masked name;
- connecting line visible if topology is intentionally known.

### Known

- real name;
- real icon;
- known materials/process;
- qualitative trade-offs.

### Crafted/owned

Do not turn the Journal into an inventory tracker. Ownership may be indicated subtly if useful, but knowledge and possession are separate concepts.

---

## 29. Gear trade-off language

Prefer qualitative notes:

- quieter;
- heavier;
- drains Vigor faster;
- holds an edge;
- dulls quickly;
- better against Infection;
- easier to carry.

Avoid turning the Journal into a spreadsheet unless a stat is genuinely necessary for informed play.

---

## 30. Armour tree

Visually communicate class progression and sidegrades.

Example:

```text
Rag Armour
   │
Quilted Coat
   ├── Leather branch
   ├── Mail branch
   └── [grey heavier branch]
```

Do not imply plate is universally superior. Page copy must retain build trade-offs.

---

## 31. Tools

Tools can use a simpler list rather than full tree when no meaningful branch exists.

Each page should explain:

- use;
- known upgrades;
- condition/maintenance knowledge;
- linked recipes/processes.

---

## 32. Charms

Charms should visually reinforce the two-slot build identity.

Known charm page:

```text
STILLSTONE

Grants: Still Breath
Quietens movement.

Known upgrade:
[grey node] ???
```

Passive and aptitude charms should look related but be clearly distinguishable through icon framing or small text label.

---

## 33. Search

Do **not** ship global search in first implementation.

Why:

- hidden-name leakage risk;
- small v1 catalogue;
- category navigation is enough;
- search adds complexity to masked entries.

Revisit when content volume justifies it.

---

## 34. Filters

Avoid completion filters such as:

- Undiscovered
- Missing
- Incomplete

Acceptable later filters might be functional:

- Food
- Medicine
- Weapon
- Armour

But v1 should rely on subcategories.

---

## 35. Notifications

Default discovery notification:

> Journal updated.

Presentation:

- small;
- quiet sound or page scratch if appropriate;
- no giant centre-screen banner;
- no achievement toast.

The Journal tab containing the update may gain a subtle marker until opened.

---

## 36. New-entry markers

Use a small ink dot/bookmark rather than exclamation marks.

States:

- unseen update marker on top-level tab;
- unseen marker on category;
- unseen marker on record row.

Opening the record clears its unseen marker client-side. This read/unread state is presentation-only and need not be authoritative server discovery state.

---

## 37. Empty states

A category with no learned or inferred content should say something atmospheric and non-directive, e.g.:

> Nothing useful written here yet.

Do not say:

> Discover recipes in Rotwood!

That becomes objective guidance.

---

## 38. Tooltip policy

Known entry tooltips may repeat concise known facts.

Unknown/inferred silhouettes:

- generic tooltip only;
- never reveal hidden name or effect.

Example:

> An unfinished note.

---

## 39. Mouse and keyboard interaction

Minimum:

- click tabs/categories/rows;
- scroll lists/pages;
- Escape closes frame;
- optional keybind toggles frame.

Do not require drag/drop for basic Journal use.

Experiment crafting UI may be a separate station interaction and should not overload the Journal frame itself.

---

## 40. Relationship to crafting UI

The Journal displays learned recipe/process knowledge.

The actual experimentation interface may live at:

- station gossip/custom frame;
- workbench/cookfire interaction;
- dedicated crafting subframe.

When an experiment teaches a hint, the Journal receives the update. The Journal is not required to be the experiment input screen.

---

## 41. Accessibility/readability

Even with dark styling:

- body text must remain readable;
- do not encode known/unknown solely by colour;
- silhouettes plus text masking carry state;
- selected row has clear border/contrast;
- font size should work at common 1080p/1440p UI scales.

---

## 42. Art asset strategy

Implementation should start with temporary safe silhouettes.

Do not block functional UI on bespoke final art.

Asset stages:

1. neutral placeholder silhouettes;
2. category-specific silhouette set;
3. bespoke creature/material/gear notebook art where worthwhile;
4. final skin/texture polish.

The discovery mechanic must function before art polish.

---

## 43. Animation

Use minimal animation.

Acceptable:

- subtle page fade;
- brief ink reveal on newly learned name;
- small marker pulse once.

Avoid:

- glowing unlock explosions;
- achievement fireworks;
- bouncing tabs.

---

## 44. Sound

Optional subtle cues:

- page turn;
- pencil/charcoal scratch;
- soft paper movement.

No quest-complete fanfare.

Sound must be independently disableable if addon settings exist later.

---

## 45. Error handling

If an entry payload is malformed:

- do not show raw payload;
- show safe unavailable state;
- log diagnostic internally.

If a static definition is missing for a known key:

> Entry unavailable.

Never expose internal key as normal player copy.

---

## 46. Dev overlay

A development-only toggle may show:

- namespace/key;
- state;
- payload;
- sync version;
- hint keys.

It must be disabled in normal player builds.

---

## 47. v1 visual acceptance criteria

Before calling the first UI playable:

1. Three top-level tabs work.
2. Full sync loading state works.
3. Unknown creature renders as silhouette with masked name.
4. Sighted creature resolves correctly.
5. Engaged creature shows at least one deeper observation.
6. Survival known recipe renders full learned process.
7. Inferred Survival recipe renders silhouette/partial structure + hint.
8. Duplicate hint never creates duplicate line.
9. Gear branch can show one known and one obscured sibling node.
10. Tab/category unread marker works.
11. No hidden names appear in unknown tooltips.
12. `/reload` returns to correct knowledge state after snapshot.
13. UI remains usable without final art.

---

## 48. Locked UI decisions

- Three top-level tabs only in v1.
- Unknown answers are silhouettes/masked, not padlocked visible names.
- No discovery completion counters.
- No global search in first implementation.
- Hints appear as persistent Field Notes without clue counters.
- Gear tree may expose topology without exposing node identity.
- Journal is read-only knowledge presentation; experimentation UI can be separate.
- Notifications are restrained.
- Final art is not a prerequisite for functional testing.
