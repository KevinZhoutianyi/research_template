#!/usr/bin/env bash
# Usage: render_pages.sh   (from anywhere in the repo)
#
# The render half of doc/CLAUDE.md's render-and-read loop: compile the LaTeX paper,
# then rasterize every page to /tmp/paper_pages/page_NN.png for the Read tool.
# Reading the pages is the other half — this script only produces them.

set -eu
REPO="$(git rev-parse --show-toplevel)"
cd "$REPO/doc/paper"

pdflatex -interaction=nonstopmode main.tex
bibtex main || true
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex

cd "$REPO"
uv run python - <<'EOF'
import fitz, os
doc = fitz.open('doc/paper/main.pdf')
os.makedirs('/tmp/paper_pages', exist_ok=True)
for i, page in enumerate(doc):
    page.get_pixmap(dpi=110).save(f'/tmp/paper_pages/page_{i+1:02d}.png')
print(f"rendered {len(doc)} pages to /tmp/paper_pages/")
EOF
