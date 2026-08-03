---
name: paper-figure
description: Rules for paper, slide, and update figure code — invoke before editing doc/paper/figures/make_figures.py, a weekly-update figure script, or any experiment visualize.py. Okabe-Ito constants, one global rcParams block, variance bands, and the render-then-read check.
paths:
  - doc/paper/figures/**
  - doc/weekly_updates/**/*.py
  - experiments/**/visualize.py
---

# Figure Code Rules

All paper figures live in `doc/paper/figures/make_figures.py` (one function per figure, reading
from `results.json`, saving PDFs beside the script). Weekly-update method figures are a committed
`.py` beside the update `.md`. Never hand-edit a generated figure.

- Global rcParams are set once at the top of the script (sans-serif, `#E0E0E0` grid, white
  background, no top/right spines). Never override inside figure functions.
- Okabe-Ito colors via the named constants only, never raw hex:

```python
C_BLUE="#0072B2"  C_ORANGE="#E69F00"  C_GREEN="#009E73"  C_RED="#D55E00"
C_LBLUE="#56B4E9" C_YELLOW="#F0E442" C_GRAY="#999999"   C_BLACK="#000000"
```

- If `results.json` has per-element stds, plot the variance band; a line-only plot hides
  uncertainty:

```python
ax.fill_between(x, means - stds, means + stds, alpha=0.15, color=color)
```

## Method and flow diagrams follow a different convention

The rules above are for DATA plots (lines, bars, distributions). A method or architecture diagram is
typeset, not plotted, and the venue convention is nearly the opposite.

| element | setting | why |
|---|---|---|
| body text | serif, `STIXGeneral`, 10pt | matplotlib's default sans face is the single strongest signal that nobody chose it |
| edge annotations | sans, `Liberation Sans`, 7.5pt, grey | family and size separate annotation from content faster than colour |
| rules and arrows | 0.6pt, `mutation_scale=8` heads | read at column width; a 2pt stroke prints as a blob |
| corners | square (`Rectangle`) | `FancyBboxPatch` rounding is a slide-deck idiom |
| colour | greyscale plus ONE accent | five hues at equal weight make the reader learn a key before reading the diagram |
| boxes | only where a box means something | drawing every node identically claims they are the same kind of thing |
| panel headers | bold sans `(a) TRAINING` | letterspacing the word ("T R A I N I N G") reads as decoration |

Two rules that matter more than the table:

- **A visual decision should carry an argument.** Give the two seats holding the same model the same
  fill, and the seat that is absent at deploy time no fill. If the figure's strongest visual contrast
  is not its strongest claim, recolour it.
- **Render, then READ the render.** Coordinate arithmetic does not catch collisions. Four survived it
  in one figure, including a caption placed at y=1.15 above a box whose bottom edge was at 1.225. Open
  the PNG and trace every arrow tail to head and every label for overlap. Anchor arrows to box edges
  in code, never hand-place endpoints.

## Experiment visualization

Every experiment also has a `visualize.py` whose figures a reader understands without reading
code or configs: the task as an input-output contract, one fully concrete example (input, key
intermediate steps, output or failure), and dataset/run stats (split sizes, trajectory lengths,
pass/fail split, key knobs).

Pre-commit check: named constants used; no rcParams overrides inside functions; variance band
present when stds exist; the `main.tex` caption opens with the question the figure answers.
Then the stranger-read pass from `doc/CLAUDE.md`: render the figure, Read the render, trace
every arrow tail to head, check every label for collisions, confirm it is readable at the size
it will be viewed (print size for the paper).
