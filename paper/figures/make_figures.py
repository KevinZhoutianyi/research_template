"""
Generate paper figures from experiments/*/results.json files.

Run from the repo root:
    uv run python paper/figures/make_figures.py

Outputs PDF figures into paper/figures/ for the LaTeX project.

This is a starter template. Add one function per figure; each reads the
relevant results.json file(s), plots, and saves into paper/figures/.
"""

import json
from pathlib import Path

import matplotlib.pyplot as plt


REPO = Path(__file__).resolve().parents[2]
OUT_DIR = Path(__file__).resolve().parent


# Use a clean, paper-friendly matplotlib style.
plt.rcParams.update({
    "font.family":          "serif",
    "font.size":            10,
    "axes.titlesize":       11,
    "axes.labelsize":       10,
    "xtick.labelsize":      9,
    "ytick.labelsize":      9,
    "legend.fontsize":      9,
    "figure.dpi":           150,
    "savefig.dpi":          300,
    "savefig.bbox":         "tight",
    "axes.spines.top":      False,
    "axes.spines.right":    False,
})


def load(path: str) -> dict:
    return json.loads((REPO / path).read_text())


# =============================================================================
# Figure 1 — [headline discriminator] (placeholder)
# =============================================================================
def fig1_main():
    # d = load("experiments/01_main/results.json")
    fig, ax = plt.subplots(figsize=(6.5, 3.5))
    ax.text(0.5, 0.5, "[fig1_main placeholder]\nReplace with real data",
            ha="center", va="center", transform=ax.transAxes)
    out = OUT_DIR / "fig1_main.pdf"
    plt.savefig(out)
    plt.close(fig)
    print(f"  → {out.name}")


if __name__ == "__main__":
    print("Generating figures:")
    fig1_main()
    print(f"\nDone. Figures in {OUT_DIR}/")
