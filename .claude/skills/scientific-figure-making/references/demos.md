# Real-World Demos and Figure Scripts

The design theory, patterns, and guidance in this skill are derived from the figure-making scripts in
the [figures4papers](https://github.com/ChenLiu-1996/figures4papers) repository by
[Chen Liu](https://chenliu-1996.github.io/) (Yale). Those scripts are the canonical demos for this
skill, and **all 25 of them are vendored under `demos/`** so they can be read and run without network
access. The upstream repo carries no LICENSE file; these are third-party scripts kept for reference,
so read them, do not copy blocks wholesale into project code.

Each script embeds its own data as a literal at the top (no CSV, no npz, no download), so a demo runs
standalone. Vendored `.py` only, 135 KB; the 20 MB of PNG outputs stayed upstream, so view a demo by
running it. Dependencies beyond numpy and matplotlib, checked by running them:

| what it needs | which scripts |
|---|---|
| `text.usetex = True`, so a full LaTeX install (**not** tectonic; these six fail on this cluster) | `figure_Dispersion/plot_idea.py`, `figure_Dispersion/plot_illustration.py`, `figure_RNAGenScape/plot_comparison.py`, `figure_RNAGenScape/plot_sweep.py`, `figure_ophthal_review/plot_trend.py`, `figure_ophthal_review/plot_composition.py` |
| seaborn | `figure_ophthal_review/plot_composition.py` |
| `python-dateutil` | `figure_ophthal_review/plot_trend.py` |
| scipy | `figure_Cflows/diffusion_swiss_roll.py`, `figure_VIGIL/plot_concept.py` |

The rest run under `uv run --with numpy --with matplotlib python <script>`; they warn
`Font family 'helvetica' not found` and fall back, which is cosmetic. A usetex demo is still worth
reading even where it will not run.

## Read a demo when you need the mechanics, not the values

The demos use a large-font sans style on wide, slide-sized canvases. **A paper figure is drawn at the
width it prints at**, which is a much smaller canvas, so the demos' type sizes do not transfer. Take
the **construction** from a demo (how bars get grouped, how a legend panel is built, how a radar axis
is laid out) and the **numbers** from this project's own rcParams block and per-figure `figsize`
values in `doc/paper/figures/make_figures.py`. Copying a demo's `font.size = 24`, `figsize=(28, 6)`, or
`#0F4D92` palette into a paper figure would break it.

| Need | Read | Why this one |
|---|---|---|
| Grouped bars with error bars | `demos/figure_ImmunoStruct/plot_bars.py` | Four metrics as four side-by-side panels; `yerr` + `capsize=5`; per-panel `set_ylim` tightened to the data range; `set_xticks([])` with methods named in a shared legend |
| Bars with the value printed above | `demos/figure_CellSpliceNet/plot_comparison.py` | `ax.text` at `bar.get_height() + std + 0.02`, so the label clears its own error bar |
| Ablation bars | `demos/figure_CellSpliceNet/plot_ablation.py`, `demos/figure_VIGIL/plot_ablation.py` | Same hue at rising alpha to encode "how much of the method is on" |
| Hatch encoding for greyscale print | `demos/figure_Brainteaser/plot_rewriting.py` | A `hatch_styles` list indexed per category, so bars stay distinct without colour |
| Composition breakdown | `demos/figure_Brainteaser/plot_brute_force.py`, `plot_correctness_by_category.py` | Stacked parts of a whole, plus the dedicated legend-panel pattern (`ax.set_axis_off()` on its own subplot) |
| Trend lines over time | `demos/figure_ophthal_review/plot_trend.py` | Event markers annotated on a curve with a de-collision routine (`mark_events`, `*` in a label nudges it up) |
| Heatmap | `demos/figure_ophthal_review/plot_composition.py` | seaborn heatmap with white cell separators (`linewidths=1, linecolor='white'`) |
| Radar / polar | `demos/figure_VIGIL/plot_comparison_radar.py` | Per-benchmark normalization before plotting, hand-drawn polar gridlines, closed loops (`angles_closed`) |
| Sweep across a parameter | `demos/figure_RNAGenScape/plot_sweep.py` | Compact multi-line sweep panel |
| Trajectory / flow | `demos/figure_Cflows/plot_comparison_Trajectory.py`, `diffusion_swiss_roll.py` | Paths over a scatter background |
| Manifold scatter | `demos/figure_RNAGenScape/plot_manifold.py`, `plot_hole_manifold.py` | Dense scatter with lowered alpha |
| Conceptual 3D / geometry | `demos/figure_Dispersion/plot_illustration.py` | 404 lines: shaded pseudo-3D spheres, geodesic arcs, a `FancyArrowPatch` subclass fixing 3D arrow z-order |
| Method / concept diagram | `demos/figure_VIGIL/plot_concept.py` | Boxes, arrows, and labels laid out by hand |

Upstream project folders, if you want the published outputs: ImmunoStruct, CellSpliceNet,
Brainteaser, VIGIL, ophthal_review, RNAGenScape, Dispersion, Cflows, under
[figures4papers](https://github.com/ChenLiu-1996/figures4papers).

## Related files

- [SKILL.md](../SKILL.md) — When to load this skill
- [api.md](api.md) — Constants, helpers, validation
- [common-patterns.md](common-patterns.md) — Layout and legend patterns
- [design-theory.md](design-theory.md) — Style theory and reproduction rules
- [tutorials.md](tutorials.md) — Step-by-step figure builds
- [uncertainty-and-diagrams.md](uncertainty-and-diagrams.md) — This project's uncertainty and diagram rules
