---
name: scientific-figure-making
description: >-
  Covers publication-ready matplotlib figures for academic papers, slides, and
  reports—bars, trends, scatter, heatmaps, and multi-panel layouts—with this
  repository’s house style, print/vector export conventions, and parity with
  figures4papers demos. Use when the user is finalizing or creating such figures
  in matplotlib. Do not use for interactive dashboards or web viz (Plotly, Altair,
  Bokeh), exploratory-only plots without a publication target, dominant 3D or
  geographic mapping, or Illustrator/Figma-first infographic workflows.
paths:
  - doc/paper/figures/**
  - doc/weekly_updates/**/*.py
  - experiments/**/visualize.py
---

# Scientific figure making

Vendored from [ChenLiu-1996/figures4papers](https://github.com/ChenLiu-1996/figures4papers)
(`scientific-figure-making/`), and the figure rules for this project: it replaced an earlier
`/paper-figure` skill, so its palette and rcParams conventions are authoritative rather than
one option among several.

`references/api.md` reads like a library reference, but no such module ships anywhere: its
`apply_publication_style`, `make_grouped_bar`, `finalize_figure` and friends are a **specification
to implement per project**, not something to import. Write the helpers into the project's own
figure script (or plain matplotlib calls that follow the same conventions), and never emit an
`import` for them.

Open `references/` only as needed; do not preload every file. Start from the table below, then follow links inside the document you opened (and into `figure_*` code via [references/demos.md](references/demos.md)) instead of loading the full reference set up front.

## When to load this skill

- Matplotlib figures for **papers, slides, or reports** that must match **this repo’s publication look** (fonts, palette, spines, legends, export).
- Requests involving **grouped bars, trend lines, heatmaps, multi-panel grids**, or **PDF/SVG/high-DPI** output in a scientific-figure context.
- References to **figures4papers** `figure_*` projects or “same style as the repo figures.”

## When not to load

- **Plotly, Altair, Bokeh**, or other interactive / web-first plotting.
- **EDA-only** plots where seaborn or pandas is enough until there is a publication target.
- Primary workflow is **3D, GIS**, or **non-matplotlib** tooling.
- **Illustrator / Figma–first** layout or infographic (not matplotlib data plots).

## Related files

| File | Open when |
|------|-----------|
| [references/tutorials.md](references/tutorials.md) | End-to-end walkthroughs (bar, trends, heatmap) |
| [references/api.md](references/api.md) | Function signatures, `PALETTE`, validation rules |
| [references/common-patterns.md](references/common-patterns.md) | Layout patterns, legend panel, print-safe bars |
| [references/design-theory.md](references/design-theory.md) | Typography, export policy, palette rationale |
| [references/demos.md](references/demos.md) | Canonical `figure_*` demo links in figures4papers |

Done when: the script runs, the exported file has been opened and looked at (not just
regenerated), and the figure follows the palette, spine, y-limit, and export conventions in
`design-theory.md`. A figure whose latest export was never viewed is not done.
