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

**Every agent in the loop is its own node.** An arrow alone does not name who does the work: if
the method has an updater, critic, or modifier seat distinct from the generator and
discriminator, draw it as its own labeled box on the path between the signal and the object it
changes, even when that seat is easy to compress into "the arrow back to the generator." A
reader should be able to list every seat in the method from the figure alone, without reading
the caption.

**The opener figure is a paradigm comparison, not the pipeline.** A method or agent paper's
Figure 1 follows the LATENTMEM exemplar (`doc/example_papers/style_extraction.md` §5a): two
panels sharing one skeleton, the same actors in the same positions on both sides so only the
mechanism differs, the prior paradigm on the left with its claimed failure modes annotated in
place, and each failure given a visually parallel fix on the right. The caption names the
comparison, then one "instead of [prior mechanism], ours [new mechanism]" sentence. The
detailed dataflow diagram is a separate, later figure. The opener also follows the exemplar's
visual language rather than the hairline convention in the table above: rounded tinted panels
(neutral grey for the prior, a cool tint with a dark border for ours), centered bold serif
panel titles, serif box labels, short icon-tagged annotations on the specific mechanism each
names (not one paragraph at the panel's foot), and a visual decision (fill, weight) reserved for
the object the paper claims is different, never spent on a role label. Hues from the
colorblind-safe palette, the single warm accent reserved for the learned object.

---

## 2c) When matplotlib cannot reach the exemplar: TikZ

matplotlib's shipped fonts (`DejaVu Sans`, `STIXGeneral`) have no icon glyphs worth relying on:
a snowflake or warning-triangle unicode codepoint may render, but the fire glyph LATENTMEM uses
is simply absent, and there is no way to know which symbol is missing without test-rendering it
first (do this before designing around any icon: render a swatch of candidates and read it, the
same render-then-read discipline as any other figure). When an opener figure needs the
exemplar's actual icon vocabulary, or icon-level fidelity is the point, switch tools rather than
approximate with whatever glyph matplotlib happens to have. Use matplotlib for every data plot
always, and for a diagram whose only requirement is boxes, arrows and text; move to TikZ only
when the font ceiling is the actual blocker.

`tectonic` is on this project's `PATH` already (a self-contained LaTeX engine that fetches
packages on first use — no system TeX Live install to manage). A diagram is a standalone `.tex`
file beside `make_figures.py`:

```latex
\documentclass[tikz,border=2pt]{standalone}
\usepackage{tikz}
\usepackage{fontawesome5}          % \faSnowflake \faFire \faExclamationTriangle \faCheck ...
\usetikzlibrary{arrows.meta,positioning}
\definecolor{accent}{HTML}{E69F00} % same Okabe-Ito hex as design-theory.md, so the diagram
                                    % matches the paper's data-plot palette
\begin{document}
\begin{tikzpicture}
  \node[draw, rounded corners, minimum width=2.4cm, minimum height=1cm] (g) {Generator};
  \node[draw, rounded corners, minimum width=2.4cm, minimum height=1cm, right=1.8cm of g] (d) {Discriminator};
  \draw[-{Latex[length=2mm]}] (g) -- (d);
\end{tikzpicture}
\end{document}
```

Compile with `tectonic diagram.tex` (writes `diagram.pdf` beside it); render to PNG for viewing
with the same pymupdf call the PDF exemplars use: `page.get_pixmap(dpi=200).save("diagram.png")`.
The compiled `.pdf`/`.png` are the checked-in outputs, exactly like a matplotlib export; a
one-line comment at the top of the `.tex` says it is compiled with `tectonic`, not run through
`make_figures.py`, so a future reader does not go looking for a Python function that does not
exist. Absolute coordinates (one grid unit = one cm, named-anchor arrows between nodes) are more
predictable here than TikZ's `fit`+`label` combo, which corrupted a glyph under this toolchain
when two panels reused one label style in the same picture -- reproducible in isolation, not
worth chasing further; draw the background rectangle first in code order so it sits behind
later content without needing the `backgrounds` library at all.

The collision check works the same way regardless of which tool drew the diagram: read the
compiled PDF's text spans and their boxes (`page.get_text("dict")`), not the source. A checker
built once against this (see this project's `doc/paper/figures/check_fig.py`) catches
matplotlib's and TikZ's output identically, and is more reliable than introspecting a
matplotlib `Axes` in-process, since it only sees what actually printed.

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

---

## 2c) Agent-paper card style (user-approved 2026-08-14; overrides §2 for agent diagrams)

For AGENT papers (pipelines, gates, loops, method/motivation diagrams), the user's approved
reference is `references/assets/agent_card_style_reference.png`, and it replaces §2's
serif-hairline convention. The look is a modern card layout, not an academic wire diagram:

| element | setting |
|---|---|
| type | sans throughout (DejaVu Sans); no serif |
| node | rounded-corner card, white fill, 1.2pt light-grey border `#d9dde1`, generous padding |
| kicker | tiny uppercase letterspaced grey label at the card's top-left (`TRIGGER`, `OUTCOME`), ~6pt bold `#8a9099` |
| card title | bold near-black, ~9pt, below the kicker |
| accent card | the ONE component the figure argues about: warm beige fill `#f5ead9`, border `#c9a97a`, dark-brown text `#6b4e21` |
| badge | small rounded pill, dark-brown fill `#6b4e21`, white bold ~6pt text, inline after a title |
| flow arrows | short thick block arrows `#a56a2b` between cards, vertically centred |
| outcome bands | full-width rounded strips: success = light green fill `#e9f5ea` / text `#2e7d32` with a glyph (✓/↻); failure = light red `#fdecea` / `#b3392e` |
| sub-panels | light grey rounded panels `#f7f8f9` for examples/states, with bold label + small pill tag |
| title block | figure number + title bold ~13pt at top-left INSIDE the canvas, one-line grey subtitle under it with the key claim bolded |
| glyphs | unicode (→ ✓ ↻ ✗) in the accent/semantic colors, never emoji |

Rules carried over from §2: anchor arrows to card edges in code; one accent argument (the
beige family IS the accent; green/red are reserved for outcome semantics); every string in a
motivation figure quoted from run data. Export stays PDF+PNG at final size; bump the canvas to
~10in width for this style since cards need padding to breathe.

### 2c.1 Approved exemplar renders (doc/example_papers/)

Three user-approved reference figures for agent-paper diagrams; open the matching one before
drawing that kind of figure. All three share the card grammar of §2c (rounded cards, kicker
labels, semantic color, glyphs not emoji); they differ by figure kind:

| file | figure kind | what to copy from it |
|---|---|---|
| `example_fig_card_gate.png` | a method mechanism/gate (also vendored as `references/assets/agent_card_style_reference.png`) | warm-beige accent card for the argued component; TRIGGER/OUTCOME kickers; green/red outcome strips; condition row inside a tinted panel |
| `example_fig_motivation_dark_chat.png` | motivation example + literature gap, two panels | the DESIGN, not the dark palette: (a) show the failure as the actual artifact (a rendered transcript/UI, not an abstract flowchart), with the wrong value annotated in place by a red callout and the correct value by a green one, connected by dashed leaders, and a one-line takeaway pinned at the bottom; (b) prior work as a stack of category cards each reduced to one line of what it tests, funneling into a single highlighted missing-capability band, then the needed steps as a compact block pipeline |
| `example_fig_pipeline_pastel_blocks.png` | benchmark/system pipeline overview | containment = subsystem: one soft hue per container, components as icon+label blocks INSIDE their container, sub-items listed inline (Mailbox/Calendar), thick straight arrows for data flow, and the evaluation edge drawn back to the gold result so the loop visibly closes |

Choosing among them: a worked failure example -> the annotated-artifact design; a method
component or decision rule -> the card gate; a whole-system or benchmark overview -> the
color-blocked pipeline. Palette is free (light or dark); what must carry over is the design:
show the real artifact and annotate it in place, reduce prior work to one-line cards with a
funnel, use containment and color to group subsystems, and end every panel on its takeaway.

### 2c.2 Illustrative diagrams are generated by the USER via GPT image (workflow)

Every illustrative/schematic figure -- motivation examples, method and pipeline diagrams,
gates, loops, system overviews, any figure that shows structure rather than measured numbers
-- is rendered by the user in ChatGPT's image model, not by matplotlib or LaTeX here.
Diffusion renders look right but garble small text, so the division of labor is strict:

1. **Claude writes a generation prompt, never the image.** The prompt is SELF-CONTAINED: it
   never says "match the attached image" or points at an exemplar file. The exemplars in
   §2c/§2c.1 are Claude's own reference for what to specify -- Claude reads the design off them
   and writes it out in words. Structure the prompt in this order (OpenAI's own guide: identity
   -> instructions -> spec -> context, most-important first): (a) ONE opening line naming what
   the figure is and its single job ("a two-panel method diagram for an AI-agent paper; it
   shows that only the memory bank changes between training and deployment"); (b) the two hard
   requirements (see step 2), stated before the detail so they are not buried; (c) the visual
   style in plain words (background, card shape and borders, kicker labels, arrow style, the ONE
   accent color named by hex and by the single role it marks, outcome-band colors, sans type,
   and the negatives: no drop shadows, gradients, 3D, icons, photographic elements); (d) the
   layout spec panel by panel (cards, arrows, colors by role, node positions); (e) EVERY literal
   string, each in quotes on its own bullet, marked "render exactly as written, no
   misspellings". Strings come from run data, verified before they enter the prompt.
2. **Two hard requirements open every prompt:** (i) **size and quality, stated explicitly** --
   ask for landscape `1536x1024` (or up to `3840x2160` for a wide multi-panel figure) at `high`
   quality; gpt-image-2 accepts any size up to a 3840px edge (edges multiples of 16, long:short
   ratio <= 3:1), but silently defaults to a small draft when size is unstated, which is why a
   wide diagram comes back soft. (ii) render every string exactly, spelling included, and NAME
   the at-risk tokens inline (a real render produced "reyiewer" for "reviewer" and leaked a
   layout shorthand word "sub" into a card) -- underscores, arrows `->`, ellipses `...`, and
   double-hyphens `--` are the ones that garble, so call them out.
3. **Keep text per element short.** Text rendering and precise label placement are the model's
   two weakest areas, and both degrade as the string count and length rise. Push detail into the
   caption (typeset in the doc, always correct) and keep on-figure text to short labels and the
   few quotes the figure genuinely needs; a card with a paragraph in it will garble where a
   three-word card will not.
4. **The user feeds the prompt to GPT image** (no attachment) and returns the render.
5. **Claude verifies the render against the string list** before it enters the report: every
   quoted string legible and character-exact, arrows connect the stated boxes, no invented
   labels, resolution adequate for print. A render with any garbled string or wrong element
   goes back as a ONE-LINE correction note naming only the change (multi-turn edit keeps the
   rest of the image stable; a full re-prompt re-rolls everything and often breaks a string that
   was previously correct). Budget 2-3 correction rounds as normal, not as failure.

Only two figure kinds stay in code: data plots (bars, trends, heatmaps -- anything with axes
and measured numbers) stay in matplotlib under the house style; typeset tables and algorithm
pseudocode blocks stay in LaTeX. GPT image garbles axis numbers, table cells, and pseudocode,
so those never go through this workflow. Everything else illustrative does.

**Two label rules from the auto-research plotting prompts (SakanaAI AI-Scientist v1/v2), which
generate every figure as matplotlib code and reflect on it for 5 rounds:** (a) no underscores
in any visible label -- write `loss vs epoch`, not `loss_vs_epoch`; a stray identifier reads as
a bug in a figure. (b) set fonts larger than default and keep every legend visible, because
figures are viewed shrunk to column width. Both apply whether the figure is coded or GPT-rendered.

**GPT image is a deliberate exception, not the field norm; code is the fallback.** The serious
automated-research systems render NO figures through an image model -- SakanaAI writes matplotlib
scripts from the data, and the DeTikZify/AutomaTikZ line generates TikZ vector code -- precisely
because code gives exact text, exact numbers, and unlimited resolution, the three things a
diffusion model cannot guarantee. We use GPT image only for the card-style illustrative diagrams
(§2c) that are laborious to hand-code AND carry no measured numbers. If after ~3 correction rounds
a render still garbles a required string, stop re-rolling and build that figure in code
(matplotlib for a boxes-and-arrows diagram, or a TikZ/`draw`-based script), where the strings are
typed and therefore correct by construction.
