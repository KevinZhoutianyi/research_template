# Uncertainty and Architecture Diagrams

Not from upstream figures4papers: this file is project-owned, and covers the two things the
vendored references do not. Everything else in `references/` is upstream and should stay
diffable against it.

---

## 1) Showing uncertainty

A line or bar drawn from means alone asserts a precision the run does not have. Whenever the
results carry per-element spread, draw it.

- **Lines and sweeps:** shade the band.

```python
ax.fill_between(x, means - stds, means + stds, alpha=0.15, color=color)
```

  `alpha=0.15` keeps the band readable under an overlapping second series; anything darker and two
  bands fight.

- **Point comparisons:** `ax.errorbar(x, y, yerr=stds, fmt="o-", capsize=3)` rather than a band, so
  single points do not imply a continuous function between them.

- **Distributions:** plot the distribution (histogram, KDE, or the shaded null) instead of its mean
  and a bar. A null or baseline distribution is the comparison the reader needs, not a single
  number to trust.

Rules that decide the hard cases:

- **If the stored results have stds and the figure has no band, the figure is wrong.** This is a
  pre-commit check, not a preference. Grep the results file for a spread field before declaring a
  plot done.
- **Never widen a band with invalid cells.** Points the run could not measure are excluded and
  their count is stated in the caption; averaging them in as zeros shrinks the mean and inflates
  the spread at the same time, which reads as a real, tight null.
- **A single-seed number gets no band and says so.** Write "one seed" in the caption rather than
  drawing a bandless line that looks like a converged mean.
- **The band's meaning goes in the caption**, once: standard deviation over seeds, over concepts,
  a bootstrap interval, or min-max are four different claims and look identical on the page.

---

## 2) Method and architecture diagrams

The house style in `design-theory.md` governs DATA plots (bars, trends, scatter, heatmaps). A
method or architecture diagram is typeset, not plotted, and its venue convention is close to the
opposite: quieter, thinner, and serif. Follow this table instead when the figure is a diagram, and
do not apply the large-font, thick-spine bar settings to it.

| element | setting | why |
|---|---|---|
| body text | serif matching the paper body (`STIXGeneral` with LaTeX), 10pt | matplotlib's default sans face is the strongest single signal that nobody chose it |
| edge annotations | sans (`Liberation Sans`), 7.5pt, grey | family and size separate annotation from content faster than colour does |
| rules and arrows | thin: 0.6pt strokes with `mutation_scale=8` heads at full text width, scaled up for a half-width panel | must read at final size; a 2pt stroke printed small becomes a blob, and one diagram must not mix two weights |
| corners | square (`Rectangle`) | `FancyBboxPatch` rounding is a slide-deck idiom |
| colour | greyscale plus ONE accent | five hues at equal weight make the reader learn a key before reading the diagram |
| boxes | only where a box means something | drawing every node identically claims they are all the same kind of thing |
| panel headers | bold sans, `(a) TRAINING` | letterspacing the word ("T R A I N I N G") reads as decoration |

Two rules that matter more than the table:

- **A visual decision should carry an argument.** Give two boxes holding the same object the same
  fill, and the box that is absent at deploy time no fill. If the figure's strongest visual
  contrast is not its strongest claim, recolour it.
- **Anchor arrows to box edges in code, never hand-place endpoints.** Hand-placed coordinates
  break the moment a box moves, and they break silently.

**The opener figure is a paradigm comparison, not the pipeline.** A method or agent paper's
Figure 1 follows the LATENTMEM exemplar (`doc/example_papers/style_extraction.md` §5a): two
panels sharing one skeleton, the same actors in the same positions on both sides so only the
mechanism differs, the prior paradigm on the left with its claimed failure modes annotated in
place, and each failure given a visually parallel fix on the right. The caption names the
comparison, then one "instead of [prior mechanism], ours [new mechanism]" sentence. The
detailed dataflow diagram is a separate, later figure. The opener also follows the exemplar's
visual language rather than the hairline convention in the table above: rounded tinted panels
(neutral grey for the prior, a cool tint with a dark border for ours), centered bold serif
panel titles, serif box labels, and the failure modes in bold red inside the prior panel; no
emoji icons, hues from the colorblind-safe palette, the single warm accent reserved for the
learned object.

---

## 2b) What the figure asserts on its own

A figure is read before the prose around it, and in a submitted paper it is often read by someone
who never reads that prose. The conventions below follow from that, and they are venue rules rather
than preferences.

- **Vector, not raster.** Export plots and diagrams as PDF. A rasterized plot is visibly soft in
  print at any DPI, and 300 vs 600 DPI only matters for a figure containing a photograph or a dense
  pixel grid.
- **The caption is self-contained.** It opens with the question the figure answers, then names what
  is plotted, the n behind it, and what a band or interval means. A caption that requires the body
  paragraph to be intelligible fails for the reviewer who scanned figures first.
- **A title inside the axes only when the panel is a claim.** Two different jobs get confused here.
  A multi-panel figure needs per-panel labels (`(a) dose-response`), and those stay. What does not
  belong is a title restating the caption's opening sentence, so that the same words are set twice on
  one page. A figure that is also read standalone in a slide deck may carry its finding as an in-axes
  title; when it does, the caption must not repeat that title verbatim. Decide per project and stay
  consistent.
- **Colour is never the only channel.** The Okabe-Ito palette in `design-theory.md` is
  colourblind-safe, which handles hue confusion but not greyscale printing. Series that must be
  distinguished in print also differ by line style, marker, or hatch (`common-patterns.md`).

---

## 3) Render, then READ the render

Coordinate arithmetic does not catch collisions. Four survived it in one diagram, including a
caption placed at y=1.15 above a box whose bottom edge sat at 1.225. Rasterize the figure, open the
image, and trace every arrow tail to head and every label for overlap. Confirm it is legible at the
size it will actually be viewed (print width for a paper, projected size for a deck).

This applies to data plots too: a band that renders as a solid block, an annotation sitting on a
bar, or a tick label collision only shows up in the render.

Done when: the export has been opened and read, every arrow traced, no label collides, the band is
present wherever stds exist, the caption stands alone and states what the band
means, and the file is vector PDF. A figure whose latest export was never
viewed is not done.

## Related files

- [../SKILL.md](../SKILL.md) — When to load this skill
- [design-theory.md](design-theory.md) — Data-plot house style, palette, export policy
- [common-patterns.md](common-patterns.md) — Layout, legend panel, print-safe bars
