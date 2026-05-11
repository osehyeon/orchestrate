# Academic Slide Patterns — Mapping Brandlogy Design System to Paper-Talk Slides

This file maps academic-talk slide types to the body composition Patterns A–G defined in `design-system.md` (§5). When in doubt about which pattern fits a slide, check this table first.

> Read `design-system.md` for the full design system. This file only adds the academic-presentation-specific layer on top.

---

## 1. Standard slide sequence (~15-min conference talk, modular)

A typical paper presentation. Adapt count by venue: lab meeting may add more methods detail; thesis defense doubles results coverage; lightning talks (5 min) drop some sections. Defense-length decks (≥35 slides): mandatory 3–5 section dividers, plus a backup deck appended after Q&A — limitations details, extra ablations, dataset card, reproducibility info, derivations. Backup slides use footer tag `[backup]` or a `B-#` page numbering series.

| # | Slide type | Required? | Pattern (§5) |
|---|---|---|---|
| 1 | Title (cover) | yes | Cover (quote-evidence (E) variant) |
| 2 | Motivation / problem framing | yes | quote-evidence (E) or two-column (B) |
| 3 | Research question(s) / hypothesis | yes | Pull-quote variant |
| 4 | Background / related work | optional | two-column (B) or process-flow (D) |
| 5 | Approach overview (one diagram) | yes | diagram-centered (C) |
| 6 | Method — data | yes if empirical | kpi-strip (A) or two-column (B) |
| 7 | Method — model / procedure | yes | diagram-centered (C) or process-flow (D) |
| 8 | Results — main finding (headline result) | yes | kpi-strip (A) |
| 9 | Results — supporting evidence | yes | stacked-cards (G) or stacked-bands (F) |
| 10 | Ablation / robustness | optional | two-column (B) |
| 11 | Discussion — interpretation | yes | quote-evidence (E) or stacked-cards (G) |
| 12 | Limitations | yes | stacked-cards (G) |
| 13 | Conclusion + future work | yes | stacked-bands (F) |
| 14 | References (selected) | yes | dense table |
| 15 | Q&A / Thank you | yes | Cover variant |

Section dividers are optional — short talks (≤15 min) usually skip them; longer talks (≥30 min) use 2–3 dividers between Background/Method/Results/Discussion.

---

## 2. Slide-type → Pattern map (the actual lookup)

### Title slide
- **Pattern**: Cover layout (closest to quote-evidence (E) with a hero card)
- Headline = paper title. If the title is long (>60 chars), drop headline to 32pt and let it wrap to 2 lines; do NOT compress to one cramped line.
- Subtitle = venue + date (e.g., "ICML 2026 · Vienna · July 2026") in Paperlogy 500 16pt #45515e
- Hero card in body zone: authors and affiliations. Use the Hero featured card (solid #1456f0 + Brand Glow) — this counts as ONE of the deck's max 3 gradient elements (§2 of design-system.md).
- Author block typography: lead author Paperlogy 700 20pt #ffffff; co-authors Paperlogy 500 16pt rgba(255,255,255,0.85); affiliations Paperlogy 400 12pt rgba(255,255,255,0.7) on a separate line.
- Affiliation logo slot (optional): inside hero card, bottom-left, h≈0.4", aspect-locked, alpha-preserved PNG.
- Brandlogy logo top-right as usual (deck-level brand identity). For presenter affiliation, place the university/lab logo INSIDE the hero card at position `x=0.7", y=5.8", h≈0.4"` (aspect-locked, max width 1.5") on title and Q&A slides only. Never substitute the Brandlogy mark in the top-right header — the two marks coexist.
- Speaker note budget: ~10–15s (intro + title read).

### Motivation slide
- **Pattern**: quote-evidence (E) when there's a striking observation; two-column (B) when motivation needs both "what's missing" and "what we propose"
- Left half: the framing problem in Paperlogy 500 24–28pt (quote-evidence (E) pull-quote weight) OR a bulleted gap analysis in Paperlogy 400 14pt (two-column (B))
- Right half: 1–2 supporting data cards (existing-work shortfalls, market size, real-world failure rate)
- Source line cites the prior work or dataset that motivates the gap
- Speaker note budget: ~60–90s.

### Research question slide
- **Pattern**: Pull-quote variant (custom — closest to quote-evidence (E) with empty right half)
- Body zone displays 1–3 questions in Paperlogy 600 28–32pt #222222, left-aligned, line-height 1.30
- Each question gets a 0.06"-wide × 0.6"-tall left accent bar (#1456f0)
- "So What" callout box at body bottom (above 6.85"): "Q1과 Q2가 답해지면, X에 대한 우리의 이해가 Y만큼 진전된다" type sentence in Paperlogy 500 14pt
- This is one of the few slides where empty whitespace is appropriate — questions should land with weight
- Speaker note budget: ~30s (question read-aloud is slow).

### Approach overview slide
- **Pattern**: diagram-centered (C) — mandatory
- Single architecture diagram occupies ~70% of body
- 3–4 caption labels around the diagram, each Paperlogy 600 12pt with a 0.5–0.7" leader line in #8e8e93
- Bottom strip: one-line takeaway in Paperlogy 500 14pt #1456f0 — "본 연구의 핵심: A를 B로 학습한다" type
- Source line if the diagram extends prior work
- Speaker note budget: ~60s (diagram walk-through).

### Method (data) slide
- **Pattern**: kpi-strip (A) when dataset has size/coverage/balance numbers worth showing; two-column (B) when dataset is described qualitatively
- KPI strip: 3 cards = (sample size N, coverage scope, key class balance %)
- Lower band left = data composition chart (donut / stacked bar)
- Lower band right = "So What" with 3 insights: (1) why this dataset, (2) known biases, (3) split methodology
- Source line cites the dataset paper / collection protocol
- Speaker note budget: ~45s.

### Method (model / procedure) slide
- **Pattern**: process-flow (D) for sequential pipelines; diagram-centered (C) for architectures
- process-flow (D): 4–6 numbered stages across the body, each stage gets icon + name + 1-line description
- Below the flow: a "key inductive bias" callout in Paperlogy 600 14pt #1456f0
- Avoid LaTeX-rendered equations as images when possible — use Paperlogy with subscript/superscript runs. If a complex equation IS the contribution, render once in a centered pull-out card with Standard shadow
- Speaker note budget: ~60–90s.

### Headline result slide (the ONE most-important number/finding)
- **Pattern**: kpi-strip (A) — the workhorse kpi-strip (A) is designed for exactly this
- KPI strip: featured card (solid #1456f0) holds the headline metric (e.g., "+12.4% accuracy"). Two standard cards hold the comparison baselines.
- Lower-left chart: bar chart vs baselines, primary series #1456f0, baselines #8e8e93
- Lower-right "So What": 3 insights from the result (statistical significance, magnitude vs prior SOTA, edge case behavior)
- **Apply Data Consistency Rule (design-system.md §0)**: if the headline says +12.4%, the chart bar must read 12.4 (not 12.5 or 12), and the So What must trace to that exact number
- Speaker note budget: ~30s (숫자가 말한다 — 짧고 강하게).

### Supporting results slide
- **Pattern**: stacked-cards (G) when there's one main chart and 3 angles to discuss; stacked-bands (F) when there are 3 separate result clusters
- Use stacked-cards (G) Tight Container Type Scale (title 13pt, body 10pt, tag 9pt) — this is where the standard 14pt+11pt commonly fails
- Tag pills on the 3 cards convey result categories: "성능", "효율", "일반화" / "TOP", "MID", "RISK" / "BEFORE", "NOW", "AFTER"
- Speaker note budget: ~45–60s.

### Ablation slide
- **Pattern**: two-column (B)
- Left: ablation table — header row #f2f3f5 background, Paperlogy 600 12pt; body Paperlogy 400 12pt with row dividers in #e5e7eb; remove vertical dividers (per design-system.md §4 Tables)
- Right: vertical bar chart showing relative drop, primary brand blue, with the "without X" bar in #ea5ec1 (the only legitimate use of brand pink in body)
- Bottom-spanning "So What" box: "X가 가장 큰 기여" type 1-line conclusion
- Speaker note budget: ~45s.

### Discussion / interpretation slide
- **Pattern**: stacked-cards (G) or quote-evidence (E)
- For 3 distinct interpretive angles → stacked-cards (G) (stacked cards with tags like "이론적", "실용적", "방법론적")
- For one big claim with supporting evidence → quote-evidence (E) (pull-quote + evidence stack)
- Speaker note budget: ~60s.

### Limitations slide
- **Pattern**: stacked-cards (G) (3 stacked cards, one per limitation category)
- Tag colors should NOT all be red/pink — limitations are intellectually honest, not catastrophic. Use neutral palette: #8e8e93 / #45515e / #1456f0
- Body text constraint applies hardest here (limitations tempt you to over-explain): keep each card body to ≤2 lines at 10pt
- Speaker note budget: ~30s (intellectually honest, 짧게).

### Conclusion slide
- **Pattern**: stacked-bands (F) (stacked insight layers)
- Top band: 1-line restatement of the contribution in Paperlogy 600 18pt #1456f0
- Middle band: 3-up "what we showed" cards (each = one main result)
- Bottom band: future work — single line in Paperlogy 500 14pt with a right-arrow visual
- Speaker note budget: ~30–45s.

### References slide
- **Pattern**: dense numbered list, 2 columns (the only slide where dense small text is acceptable)
- Each reference Paperlogy 400 10pt #45515e, line-height 1.50
- Author names in Paperlogy 500 (slightly bolder), year in Paperlogy 600
- Show only the references actually cited verbally; full bibliography goes in the paper, not the deck
- Speaker note budget: 0s (visual only).

### Q&A / Thank you slide
- Cover layout variant — same hero card as title slide but contents are: "감사합니다 / Thank you" Paperlogy 700 48pt centered on hero card, contact line below in Paperlogy 500 18pt
- Optional: a small "Backup slides follow" indicator below the hero card if backup material is appended
- Speaker note budget: 0s (live Q&A).

---

## 3. Academic-content handling rules

### Equations
Inline math: use Paperlogy with Unicode math characters (×, ÷, ≤, ≥, ∈, ∀, ∃, π, σ, μ, etc.) and superscript/subscript runs. Set `superscript: true` / `subscript: true` on the relevant pptxgenjs text run rather than raising/lowering coordinates manually.

Block equations: render as a centered card with Standard shadow, body-zone-internal padding 16px, equation in Paperlogy 500 18–20pt. If the equation requires LaTeX-quality rendering (matrices, fractions, integrals), generate it externally as a transparent PNG at 300 DPI and insert as an image — do NOT attempt complex LaTeX in pptxgenjs text.

### Citations
In-slide citation format: `[Author et al., Year]` in Paperlogy 400 10pt #8e8e93, placed at the end of the relevant body line or inside a parenthetical. Avoid superscript citation numbers — they are illegible at projection scale.

Source line at the bottom of charts/diagrams cites the data source, not the prior work being compared. Use Paperlogy 400 9pt #8e8e93.

### Tables of results
Standard table styling per design-system.md §4 Tables. Two academic-specific additions:
- **Best-row highlighting**: bold the best result per metric (Paperlogy 700 12pt #1456f0). Do NOT use background fill on the row — it creates false visual hierarchy.
- **Statistical significance markers**: append `*` / `**` / `***` after the value in Paperlogy 600 10pt; a 1-line footnote below the table in Paperlogy 400 9pt #8e8e93 explains thresholds.

### Figures from the paper
If reusing a figure from the paper, render it at ≥150 DPI and place it inside a Standard Content Card with white BG and 13px radius. Do NOT scale figures up beyond their native resolution — pixelated paper figures are a hallmark of rushed slide decks.

### Code snippets
Avoid full code on slides. If a snippet is essential (≤6 lines), use a Standard Content Card with #f2f3f5 fill, monospace text — but Paperlogy is not a monospace font, so this is the only sanctioned exception to the Paperlogy-only rule. Use a clean monospace fallback: `"Menlo", "Consolas", monospace` at Paperlogy-equivalent 12pt.

### Korean overflow heuristics (when text is 1.4× English)

Paperlogy renders Korean ≈1.4× the glyph width of equivalent English for the same idea. If a translated slide overflows, do NOT shrink the font below the type scale — apply these in order:

1. **Card body character ceilings** (per pattern):
   - kpi-strip (A) "So What" insight body: ≤ 50 Korean chars / line, max 2 lines.
   - stacked-cards (G) per-card body: ≤ 80 Korean chars / 2 lines at 10pt (already enforced in §5).
   - stacked-bands (F) bottom band evidence: ≤ 60 Korean chars / line, max 1 line.
   - quote-evidence (E) pull-quote: ≤ 35 Korean chars / line (large 24–28pt absorbs less text).
   - Headline (대제목): ≤ 28 Korean chars on one line at 36pt; if longer, drop to 32pt and allow 2 lines (per Title slide rule).

2. **동사 명사화** (verb nominalization): convert sentence-final verbs to noun forms to shed the predicate.
   - Before: "12.4% 성능 향상을 달성하였다" (15자)
   - After: "12.4% 성능 향상 달성" (11자) — 27% reduction.
   - Common patterns: `-하였다` → noun + nothing; `-시키는` → `-시킴`; `-할 수 있다` → `-가능`.

3. **조사 생략** (particle drop): on slide copy (NOT prose), drop `은/는/이/가/을/를` when subject/object is clear from position.
   - Before: "본 연구는 X를 Y로 변환하는 방법을 제안한다."
   - After: "본 연구 — X를 Y로 변환 방법 제안" — context recoverable from layout.
   - Never drop particles in spoken-language quotes or pull-quotes (quote-evidence (E)) — sounds clipped.

4. **한자어 치환** (Hanja-derived compact synonyms): replace native-Korean periphrastic phrases with Sino-Korean compounds when audience is academic.
   - "더 좋은 결과" → "우수 결과" (5→4자)
   - "성능이 떨어지는 경우" → "성능 저하 시" (10→6자)
   - "다른 방법과 비교했을 때" → "타 방법 대비" (10→6자)

If after applying all 4 the text still overflows, the slide is too dense — split.

### Korean–English mixing
Paperlogy handles both natively (per design-system.md §3). Common academic mixed patterns:
- Method names stay English: "We use **Transformer** with **multi-head attention**..."
- Findings stated in Korean: "**12.4%** 성능 향상 달성"
- Equation variables stay Latin: `손실 함수는 L = ...`
- No font swap — single Paperlogy run handles all

---

## 4. Pattern selection priority (one-shot decision tree)

```
Slide carries a single big number / headline finding?
  → kpi-strip (A)

Slide explains a process or pipeline?
  → process-flow (D)

Slide centers on one diagram (architecture, framework, system)?
  → diagram-centered (C)

Slide compares two things side-by-side (with vs without, ours vs baseline, before vs after)?
  → two-column (B)

Slide presents 3 distinct angles on one finding (3 limitations, 3 interpretations, 3 implications)?
  → stacked-cards (G) if there's a primary chart
  → stacked-bands (F) if no primary chart

Slide is a striking framing or pull-quote?
  → quote-evidence (E)

Slide has thin content but you can't split it?
  → stacked-bands (F)

Default fallback?
  → kpi-strip (A) (it's the workhorse — works for most data slides)
```

---

## 5. Anti-patterns specific to academic talks

- **Wall of bullets**: any slide with >5 bullets needs to become 2 slides or get a chart
- **Equations as PNG screenshots from the paper PDF** at low DPI: render fresh at 300 DPI or rebuild in Paperlogy
- **Tables copied from the paper unchanged**: paper tables are dense for print; for slides, drop columns, bold the best row, add the So What
- **"Related Work" wall**: a single slide listing 12 papers in 9pt text. Restructure as two-column (B): left = "기존 접근의 3가지 한계", right = your positioning
- **Result chart with no comparison baseline**: a bar of one bar is meaningless — always show a baseline or prior SOTA
- **Conclusion = restated bullets**: rebuild as stacked-bands (F) with ONE new takeaway in the top band that wasn't on any earlier slide
- **References slide in 6pt text**: if the references don't fit at 10pt, you're showing too many — show only what you cited verbally
- **Defense-length deck without section dividers**: 35+ slides without dividers makes audience lose the spine. Insert 3–5 dividers (1 per major section).
