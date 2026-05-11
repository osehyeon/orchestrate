---
name: academic-presentation
description: Use this skill when the user wants 16:9 slides for a FORMAL academic presentation — conference oral/poster talks (ICML/NeurIPS/CHI/ACL/etc.), invited talks, thesis or dissertation defenses, journal-club talks, paper presentations at workshops. The trigger requires either ≥10 slides or ≥10-minute talk length; for shorter internal updates (lab meeting 3-slider, 5-slide standup), use the standard pptx skill alone. Trigger on Korean cues (학술 발표, 논문 발표, 학회 발표, 컨퍼런스 슬라이드, 방어 슬라이드, 디펜스, 저널 클럽 발표) and English cues (paper talk, conference deck, research slides, thesis defense, dissertation defense, journal club). Trigger even if the user just says "make slides for my paper" without saying "academic". Use IN COMBINATION with the standard pptx skill — pptx handles .pptx mechanics (PptxGenJS), this skill provides the Brandlogy/MiniMax-inspired design system plus academic-specific slide patterns (sequence, equations, citations, results tables). Do NOT skip this skill assuming pptx alone is enough.
---

# Academic Presentation Skill

Build clean, MiniMax-inspired 16:9 paper-talk slides under the Brandlogy design system. Pairs with the standard `pptx` skill (which handles PptxGenJS mechanics). This skill carries the **content structure** (academic slide sequence, equations, citations) and the **visual system** (Paperlogy typography, locked zones, 7 body composition patterns).

## Quick orientation

| Question | Where to look |
|---|---|
| How do I generate a .pptx file at all? | Read `/mnt/skills/public/pptx/SKILL.md` (the standard pptx skill, esp. its `pptxgenjs.md`) |
| What slide types does an academic talk need, in what order? | §1 below + `references/slide-patterns.md` §1 |
| For *this* slide type (e.g. "headline result"), which body pattern (kpi-strip (A)–stacked-cards (G)) do I use? | `references/slide-patterns.md` §2 |
| What are the exact colors, fonts, spacings, and locked zone Y-coordinates? | `references/design-system.md` (full system) |
| How do I handle equations, citations, results tables, code? | `references/slide-patterns.md` §3 |
| Can I just paste a chart from the paper as a screenshot? | No — see anti-patterns, `references/slide-patterns.md` §5 |
| The slide looks "꽉 차있어" (text fills the card edge-to-edge) — what now? | Drop one type-scale step (Container-Aware Type Scale, design-system §3) |
| The chart labels are colliding with adjacent bars in a clustered chart — how to fix? | `barOverlapPct: -30` + `valAxisMaxVal` ≈ 1.3× peak (design-system §4) |

**Read both reference files before generating anything.** They're not optional — every numeric coordinate, color hex, and font weight in the output needs to come from `design-system.md`, and every slide-type→pattern mapping comes from `slide-patterns.md`.

---

## Workflow

### Step 1 — Capture the talk's spine (before touching code)

Assume the talk's spine — paper draft / outline / slide list — has been delivered by the upstream layer. This skill does not parse PDFs.

Ask the user (or extract from the paper / draft they shared):

1. **Talk format and length** — 5-min lightning / 12–15 min conference oral / 20–30 min invited / 45–60 min thesis defense. This dictates total slide count (roughly: lightning ~6 / short oral 10min ~10 / conference 12–15min ~12–15 / long invited 20–30min ~20–28 / thesis defense 45min ~35–45 / dissertation defense 60min ~45–55).
   If total slide count would be < 10 OR talk length < 10 min AND audience is internal (lab meeting / standup), stop here and recommend the standard `pptx` skill instead.
2. **Audience** — same-subfield experts / general ML/CS / interdisciplinary / committee. Determines how much background to assume.
3. **Language** — Korean / English / mixed. Paperlogy handles all three; copy length differs (Korean ~1.4× English by glyph count for the same idea).
4. **Single most important sentence** — what one claim must the audience leave with? This becomes the headline of the **headline-result slide** (often slide 8) and the conclusion's top-band line.
5. **Available assets** — the paper, figures (with native DPI, ideally ≥300), data files for charts, the Brandlogy logo (transparent PNG).
6. **Presentation environment** — personal laptop (Paperlogy installed) / shared or conference PC (system fonts only) / unsure. Determines font mode (Native vs Safe-font) per `references/design-system.md` §3 Font Mode. Default to Safe-font when unsure.

If any of these are missing, ask before drafting. Don't guess the headline finding — getting it wrong means restructuring the entire deck.

### Step 2 — Plan the slide sequence

Use the standard sequence in `references/slide-patterns.md` §1 as a starting template. Adjust:
- Drop "Background / related work" if the audience is in-subfield
- Add a second results slide if the paper has 2+ major findings
- Add 2–3 section dividers only if the talk is ≥30 min
- If total deck size exceeds 35 slides, require 3–5 section dividers (one per major section: Background / Method / Results / Discussion / Conclusion) and define a backup-slide block appended after the Q&A slide for: limitations details, additional ablations, dataset card, reproducibility info, derivations.

Output the plan as a numbered list with the slide-type label for each (e.g., "Slide 5 — Approach overview, diagram-centered (C)"). Confirm with the user before generating.

### Step 3 — For each slide, look up the pattern

For every slide in the plan, consult `references/slide-patterns.md` §2 to find the prescribed pattern (kpi-strip (A) through stacked-cards (G)), then look up the pattern's geometry in `references/design-system.md` §5. Write each slide in this order inside your generation code:

1. Locked zones (header strip / headline / subtitle / footer) at fixed Y-coordinates from design-system §0
2. Body content using the pattern's geometry
3. **Apply Container-Aware Type Scale** (design-system §3) — if any container is < 1.5" tall, drop one type-scale step
4. **Apply Breathing Room Rule** — verify ≥0.06–0.10" of bottom padding inside every card

### Step 3.5 — Write speaker notes (per slide)

For each slide, attach speaker notes via PptxGenJS `slide.addNotes(...)`. Notes are NOT a rewrite of the slide body — they carry what the presenter says ABOVE the visual.

- Use per-slide-type duration budgets from `references/slide-patterns.md §2` (each slide entry now ends with "Speaker note budget: ~Xs").
- Format: 1 idea per line. Include explicit stage directions when timing matters (e.g., "Pause 1s after stating the number").
- Never copy slide body text into notes — if the note repeats the slide, it's wasted.

### Step 4 — Generate the .pptx

**Output file naming.** A single paper can have both an oral deck and a poster deck. Distinguish them by **filename suffix**, not by sub-folder:

```
{paper-slug}/
├── paper.pdf
├── slides.oral.pptx
└── slides.poster.pptx
```

Promote to a folder (`oral/`, `poster/`) only when accompanying files actually appear (speaker script, presenter notes, Q&A prep, alternate-aspect exports). Don't pre-create the folder for a single file.

Hand the design specs to the `pptx` skill's PptxGenJS workflow (`/mnt/skills/public/pptx/pptxgenjs.md`). PptxGenJS-specific pitfalls already documented in `references/design-system.md`:
- Hex format: 6-character without `#`, never 8-character with embedded alpha
- Shadow factory functions, never shared shadow object references; `margin: 0` on every text box
- Clustered bars: `barOverlapPct: -30`, `valAxisMaxVal` ≈ 1.3× data peak
- Hero Gradient: substitute solid `#1456f0` + Brand Glow shadow (PptxGenJS shape fills don't support native gradients)
- Featured blue card: white text + solid white tag pills with brand-blue text (NEVER transparent white, NEVER blue-on-blue)

Full PptxGenJS API and syntax: `/mnt/skills/public/pptx/pptxgenjs.md` and `design-system.md` Quick Reference.

### Step 5 — Visual QA (mandatory)

After generating the .pptx, render to JPG and visually inspect every slide. Code can compile cleanly while still producing overlapping labels, edge-to-edge text, off-position elements, or low-contrast pills.

Render to JPG and inspect every slide. The full bash recipe lives in `references/design-system.md` §8 (canonical). Trigger: after `.pptx` is written, before declaring done.

Then run the **Iteration Checklist** (`references/design-system.md` §9 has the full 25-item checklist). The most-failed items in production:
- Item 10 — KPI card secondary value overlapping the gap badge (verified Y-offsets: label 0.16 / primary 0.40 / secondary 0.88 / gap badge 1.20)
- Item 15 — stacked-cards (G) cards using 14pt+11pt instead of 13pt+10pt (Container-Aware Type Scale)
- Item 16 — text filling cards edge-to-edge ("꽉 차있어" defect)
- Item 17 — transparent white tag pills on featured blue cards (renders invisible)
- Item 18 — three different versions of the same number on one slide

After inspection, fix and re-render. Stop after one fix-and-verify cycle unless a new user-visible defect appears (per the standard pptx skill's QA loop).

---

## §1 — The standard academic slide sequence (modular)

For a ~12-15 min conference oral (the most common case). Adjust per Step 1 above.

```
1.  Title (cover)            — Cover layout (quote-evidence (E) variant)
2.  Motivation               — quote-evidence (E) or two-column (B)
3.  Research question(s)     — Pull-quote variant
4.  Background / related     — two-column (B) or process-flow (D) (optional, drop for in-subfield audience)
5.  Approach overview        — diagram-centered (C) (one diagram)
6.  Method — data            — kpi-strip (A) or two-column (B)
7.  Method — model           — diagram-centered (C) or process-flow (D)
8.  Headline result          — kpi-strip (A) — the workhorse
9.  Supporting results       — stacked-cards (G) or stacked-bands (F)
10. Ablation                 — two-column (B) (optional)
11. Discussion               — quote-evidence (E) or stacked-cards (G)
12. Limitations              — stacked-cards (G)
13. Conclusion + future      — stacked-bands (F)
14. References (selected)    — dense table
15. Q&A / Thank you          — Cover variant
```

See `references/slide-patterns.md` §2 for the rationale and full layout spec for each slide type.

---

## §2 — What this skill does NOT do

- **Does not write the research itself.** This skill turns research content into slides; it does not generate findings, results, or interpretation.
- **Does not invent numbers.** Every number on a slide must come from the user's paper, data files, or be computed from those. Apply the Data Consistency Rule (design-system §0): never let three different versions of the same metric coexist on one slide.
- **Does not validate statistics.** If the paper says "p < 0.001", the slide says "p < 0.001" — this skill doesn't recompute significance.
- **Does not translate.** If the user asks for a Korean talk from an English paper (or vice versa), the user provides the translation; this skill places it in slides.
- **Does not handle non-16:9 formats.** Reject 4:3, 1:1, 9:16, A4, letter requests — point users to a separate workflow if needed.
- **Citation style**: this skill supports `[Author et al., Year]` inline format only. APA/IEEE/numeric styles must be converted by the user before input.
- **Equation rendering**: complex equations should be pre-rendered to PNG via an external tool (e.g., MathJax CLI). Tool selection is outside this skill's scope.
- **Accessibility**: WCAG/color-blindness contrast verification is outside this skill's scope — separate review required.
- **Font embedding**: PptxGenJS does not embed font files in the generated .pptx. The presentation machine must have the chosen font installed. If not guaranteed (shared/conference PC), use Safe-font mode (design-system §3 Font Mode) — this skill does not bundle or install fonts.

---

## §3 — Quick reference (the strip you actually use mid-generation)

- Aspect: **16:9 only** (13.333" × 7.5")
- Background: `#ffffff` (every content slide), `#181e25` (closing/divider only)
- Font: **Native mode** Paperlogy / **Safe-font mode** Pretendard (Korean-first) or Inter (English-first). All weights 100–900. Pick mode per Step 1 #6. Full spec in design-system §3 Font Mode.
- Headline: Paperlogy 700, 32–40pt, `#222222`, `charSpacing: -0.6` for 32pt+
- Subtitle: Paperlogy 500, 16pt, `#45515e`
- Body: Paperlogy 400, 12–14pt, `#222222`
- Tight-card body (stacked-cards (G), ~1.36" cards): title **13pt** / body **10pt** / tag **9pt** (Container-Aware Type Scale)
- Source/caption: Paperlogy 400, 9–10pt, `#8e8e93`
- Brand blue: `#1456f0` (primary) / `#3b82f6` / `#60a5fa`
- Sky blue: `#3daeff` (secondary accent — see design-system.md §2 for full palette)
- Brand pink (accents only): `#ea5ec1` — never on body text or buttons
- Borders: `#e5e7eb` / `#f2f3f5`
- Logo (Brandlogy): top-right, ≈1.22"×0.24", insert provided PNG as-is, alpha preserved (no box, no underline, no recolor, no crop)
- Locked Y-zones: header `0.4–0.7"`, headline `1.0–1.75"`, subtitle `1.63–2.03"`, body `2.39–6.85"`, clearance buffer `6.85–7.05"` (empty), footer `7.05–7.3"`
- Verified KPI card Y-offsets (1.5"-tall, 3-up): label `0.16` / primary `0.40` / secondary `0.88` / gap badge `1.20`
- Featured-card tag pill: solid `#ffffff` fill + `#1456f0` text (NEVER transparent white)
- Chart safe defaults (clustered bars): `barOverlapPct: -30`, `barGapWidthPct: 100`, `valAxisMaxVal` ≈ 1.3× peak, `dataLabelFontSize: 8`, `dataLabelPosition: "outEnd"`
- PptxGenJS hex format: 6-char without `#`, never 8-char with embedded alpha
- Hero Gradient: max 3 elements per deck, never on charts/text/headers/footers; in PptxGenJS substitute solid `#1456f0` + Brand Glow shadow

For everything else (full color palette, shadow library, 7 patterns kpi-strip (A)–stacked-cards (G) with geometry, complete typography table, do's/don'ts, 25-item checklist) → `references/design-system.md`.
