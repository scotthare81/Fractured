# Client branding — login reskin (MPQ)

Everything the player sees **before and at login** (login screen, realm list, char select/create, loading screens) is **client-side**. The server (AzerothCore / `mod-thalvaeth`) has nothing to do with it. It all lives in the WoW 3.3.5a client's data and is replaced by shipping a **custom patch MPQ** with the client download — so this belongs to the client patch, not the server module.

Goal: strip **all** WoW / Wrath-of-the-Lich-King branding from the glue screens and replace it with Thal'vaeth.

Concept targets: [`branding/`](branding/) (not final assets — see its README).

---

## What to override (glue-screen assets)

Paths are approximate for 3.3.5a (build 12340) — **confirm against your client** when building the patch.

| Element | Client asset (approx.) | Thal'vaeth replacement |
|---------|------------------------|------------------------|
| **Title logo** (top-center) | `Interface\Glues\Common\Glues-WoW-Logo*` (+ expansion logo) | The **seal** crest (`branding/seal.png`) or the horizontal **wordmark** |
| **Background scene** | The animated **Frozen Throne / Icecrown** 3D model, driven by GlueXML | A static **Rotwood splash** (`branding/login_splash*.png`) |
| **Login panel / buttons** | `Interface\Glues\...` BLP textures | Weathered stone / stitched-leather frame art |
| **Login music** | `Sound\Music\GlueScreenMusic\...` | Original Thal'vaeth login track |
| **Loading screens** | `Interface\Glues\LoadingScreens\...` | Original Thal'vaeth / Rotwood art |
| **Strings** | `GlueStrings` / locale (GlueXML) | "Thal'vaeth"; delete every *World of Warcraft* / *Blizzard* / *Wrath of the Lich King* |
| **Version / copyright line** | glue string / texture | Thal'vaeth version + our copyright |
| **Cursor / fonts** | `Interface\Cursor\`, `Fonts\` | Optional polish |
| *(adjacent)* **Zone / AreaTable names, minimap** | DBC / MPQ | Name hygiene so no "Duskwood"/"Hearthglen" shows (MPQ Tier C, see [CONTENT.md](CONTENT.md)) |

---

## How the patch works

- Ship a **custom patch MPQ** — e.g. `Data\patch-4.MPQ` (generic assets) or `Data\enUS\patch-enUS-4.MPQ` (locale/strings). Patches load in order; **later letters override earlier**, so `patch-4` masks Blizzard's files without touching the base MPQs.
- **Textures are BLP** — author in PNG, convert with a BLP tool (e.g. BLPConverter).
- **Glue layout + strings** live in **GlueXML** (Lua/XML) inside the MPQ and are patchable — edit them to hide the 3D login model and draw a static splash, and to reword strings.
- **Music** is MP3/OGG at the right path.
- Tools: an MPQ editor (e.g. Ladik's MPQ Editor), a BLP converter, an audio encoder.

---

## Recommended approach — static splash

Fighting the 3D Frozen-Throne model is the hard part. Instead:

1. In the login **GlueXML**, hide the 3D scene and draw one full-screen **Rotwood splash** texture.
2. Overlay the **seal crest** top-center (where the WoW logo sat).
3. Custom **login music**.
4. Reword all **strings / version / copyright**.

That kills ~90% of the WoW brand with texture + string swaps and one small GlueXML edit — no model surgery. An animated 3D Thal'vaeth vista can come later (Tier 3).

---

## Tiered checklist

- **Tier 1 — kill the WoW brand:** title logo/crest, static splash, login music, all strings/version/copyright.
- **Tier 2 — polish the glue:** login panel/button art, loading screens, cursor.
- **Tier 3 — deep:** animated 3D login vista (optional), custom fonts, AreaTable/minimap name hygiene.

---

## Open decisions

| Decision | Options |
|----------|---------|
| Splash branding | Crest **top-center only**, or crest **+ small wordmark bottom-left** |
| Background | **Static splash** (recommended) vs animated 3D scene |
| Accent color | **Blood-red** (current) vs ash-orange |
| Wordmark type | Rebuild in a real weathered-serif font (generator lettering isn't reliable) |
| Login dimensions | Match the client's fixed login-logo / splash sizes |

---

## Caveats

- **Asset production is separate work** — final logo, splash, loading screens, and login music are art/audio to be produced (original IP, L15). The `branding/` images are concept *targets*.
- **Not buildable/testable from this repo** — there's no WoW client or BLP tooling here. This doc is the spec; whoever has the client builds and tests the patch MPQ.

---

## Related

- [branding/](branding/) — concept art
- [`../src/mod-thalvaeth/client/mpq/`](../src/mod-thalvaeth/client/mpq/) — the client patch manifest lives with the module
- [CONTENT.md](CONTENT.md) — the wider MPQ tier plan (icons, audio, name hygiene)
