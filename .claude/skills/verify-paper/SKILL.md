---
name: verify-paper
description: Run before declaring any doc edit done — paper.md, proposal.md, or the LaTeX paper. The stranger-read pass, the self-verification checklist, the banned-language greps, and (for LaTeX) the render-and-read audit. An edit is not finished until this passes. Prose and LaTeX only; experiment code goes through /verify-experiment.
---

# Doc Verification

The writing rules being verified (motivation first, style, language, claims calibration) live in
`doc/CLAUDE.md` §1-§2 and apply while drafting. This skill is the delivery gate: run every part
that applies, fix what it catches, re-run until clean.

## 1. The stranger-read pass (every doc and figure)

Run this on every doc and figure before delivering. It exists because repeated review rounds
traced to one root cause: text was checked for correctness but never re-read with zero context.
Typical failures: a paragraph labeled "Training:" when no training had happened; metric
abbreviations used before definition; an abstract category where one concrete instance was
needed; figure labels colliding with arrows.

1. No dangling referents. Every label, abbreviation, metric, and run name is defined before first use. Every number says what it counts or what it is a percentage of. Specific checks: (a) every term introduced in the abstract or intro that is not plain English gets a parenthetical gloss at first body use; (b) every named evaluation set (e.g., a "battery" of questions) is described — size, content, construction — at first use; (c) every named direction or axis gets a definition the first time it appears in the body, not deferred to an appendix; (d) every external technique name (e.g., "logit-lens probe") either appears in Key Terms or gets a one-clause gloss inline.
2. Facts as sentences, not labels. "We have not trained anything yet", never a section opener like "Training:".
3. Instance before category. Open an abstract claim with one worked example from the project's own data, then state the general point once.
4. One point per sentence. A qualifier either earns its own sentence or is cut. Emphasizing everything emphasizes nothing.
5. Figures get the same pass: render, then read the render. Trace every arrow tail to head. Check every label for collisions. Ask what each icon looks like at actual size.
6. One logical move per paragraph. A paragraph that presents multiple independent pieces of evidence must signpost each one explicitly ("First... Second... Third...", "Ruling that out, we then show...", "A separate result confirms..."). The reader must never have to infer the logical connection between consecutive sentences. Test: cover every sentence but the last — does the final sentence follow obviously? If not, add a bridge.

## 2. Language greps

Run `scripts/check_prose.sh <file> [...]` on every changed doc. It greps for the banned lists in
`doc/CLAUDE.md` §1 Language: em dashes (`---` or Unicode), the banned-word list (delve, crucial,
robust, leverage, ...), self-justifying framing about our own honesty ("reported honestly",
"to be fair", ...), and capitals used as emphasis (`\b[A-Z]{4,}\b` in prose). Any hit is a
rewrite, not an allowlist entry. The script cannot catch the remaining language rules (second
person, meta-narrative, grading our own results); check those by reading.

## 3. Self-verification checklist (paper.md / proposal.md edits)

1. Every new sentence supports a positive claim (else: appendix).
2. Subsection titles are declarative.
3. Multi-condition results are tables.
4. Causal claims have `results.json` backing.
5. `\ref{}` targets are correct.
6. No implementation details in the diff.
7. No em dashes or banned words in the diff (§2 above).
8. The rendered PDF reads cleanly (overflow, figures, abstract length, references).
9. Numerical consistency: every number in the body matches its source table/appendix. Specifically: (a) pair counts in clustering tables satisfy C(n_pass,2) + n_pass*n_fail + C(n_fail,2) = C(N,2); (b) baseline values stated in multiple places agree; (c) directional claims about a sequence of numbers (e.g., "maintained", "strengthened", "reduced") match the actual sign of the change; (d) approximate rates ("1 in 20", "~30%") are consistent with the exact numbers in the corresponding table.
10. No forward-use of undefined terms: every technical term, named direction, named evaluation set, and external technique name is defined at or before first body use per the stranger-read pass above.

## 4. Render and read (LaTeX edits)

After every non-trivial edit to `doc/paper/`, run `scripts/render_pages.sh` (pdflatex + bibtex +
pdflatex x2, then rasterize every page to `/tmp/paper_pages/page_NN.png`), then Read each page
image. Audit: figures cut off or unreadable at print size, empty plots, broken glyphs, `??`
references, table overflow (`Overfull \hbox`: fix with `p{width}` columns), abstract over 10
lines (trim to 200 words).

## Done when

Every applicable check above passes and a full read of the rendered pages surfaces nothing new. Anything short of that: report what is still red, do not declare the edit done.
