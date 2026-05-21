# paper/ — LaTeX version

LaTeX paper draft, sibling to `doc/paper.md` (the living markdown
argument document). `main.tex` mirrors the section structure of
`doc/paper.md`; figures are generated from `experiments/*/results.json`
into this folder.

## Contents

```
paper/
├── main.tex              ← paper body, sections inline (mirrors doc/paper.md)
├── references.bib        ← BibTeX entries; one per paper in doc/related_papers/
├── figures/
│   ├── make_figures.py   ← reads experiments/*/results.json, writes PDF figures
│   ├── fig1_*.pdf        ← generated figures
│   └── ...
└── README.md             ← this file
```

## Import to Overleaf

1. Zip the entire `paper/` directory:
   ```bash
   cd <repo-root>
   zip -r paper-project.zip paper/
   ```
2. In Overleaf: **New Project → Upload Project → paper-project.zip**.
3. Compiler: pdfLaTeX (default). Main document: `main.tex`.

## Regenerating figures

```bash
uv run python paper/figures/make_figures.py
```

`make_figures.py` reads results from the `experiments/` tree (paths
relative to the repo root) and writes PDFs into `paper/figures/`. Each
`fig*` function is self-contained — you can comment out figures you
don't need to regenerate.

## How the docs relate

| file | purpose |
|---|---|
| `doc/paper.md` | Living markdown argument: thesis, evidence, what we do NOT claim. Updated continuously as experiments land. |
| `paper/main.tex` | Polished LaTeX version for Overleaf / submission. Lags `doc/paper.md` slightly — rebuilds when a section is publication-ready. |
| `doc/CLAUDE.md` | The rule set for both. |

When a finding lands, update `doc/paper.md` first (single source of
truth); promote to `paper/main.tex` once the section is stable.
