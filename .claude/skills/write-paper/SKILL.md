---
name: write-paper
description: How to write the paper — invoke whenever results are ready to go into paper.md, proposal.md, or the LaTeX paper, and for any other doc edit or long-form prose report (e.g. a midterm report under doc/weekly_updates/). Two invocation points, one skill: before drafting (open references/style.md and the exemplar extraction, follow them while writing; new results follow the claims-and-evidence rules of doc/CLAUDE.md §2) and before declaring done (the delivery gate: stranger-read pass, reverse outline, self-verification checklist, banned-language greps, reject-risk pass, and for LaTeX the render-and-read audit). For reports, the number-reporting rules of /weekly-update apply on top. Prose and LaTeX only; experiment code goes through /verify-experiment.
---

# Writing the Paper

The common entry point: a result has landed and belongs in the paper. The path is
`doc/CLAUDE.md` end to end — where the result goes (§3 structure: claim, evidence tag, headline
plus reading plus caveat), how strongly it may be claimed (§2 claims and evidence, the
statistical hard rules), and the framing methodology when the result moves the story (§2a).
The structure and language rules live in [references/style.md](references/style.md) and apply
while drafting. This skill is also the delivery gate.

**The loop.** For new content: load the rules, draft under them, then gate → fix → re-gate
until a pass reports nothing worth fixing. For existing content (a pasted draft, a section
already in the paper): gate first — it produces the edit list — then fix, then re-gate the
changed text. Never one review pass and unchecked fixes: a rewritten sentence can introduce
the next dangling referent, so fixes always get a re-pass.

| Reference | Open when |
|---|---|
| [references/style.md](references/style.md) | Before drafting any prose: the house structure and language rules (single home; `doc/CLAUDE.md` points here). |
| `doc/example_papers/style_extraction.md` (distilled exemplars; matching rule in `doc/CLAUDE.md` §7) | Before drafting any doc content (section opener, abstract, figure, table, title) and at the delivery gate: check the draft against the matching dimension; open the exemplar PDF itself when the extraction is not enough. |
| [references/ai-writing-patterns.md](references/ai-writing-patterns.md) | `check_prose.sh` fires, or a paragraph reads as written-for-cadence. Eleven patterns, each with a before/after rewrite at paragraph scale, plus the what-not-to-flag list. |
| [references/abstract-and-intro-templates.md](references/abstract-and-intro-templates.md) | Drafting or restructuring the abstract or the introduction. Three abstract shapes and a seven-paragraph intro plan, at the sentence level. |

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

## 1a. The shape check (sections with a known anatomy)

Before any sentence-level pass on an abstract or an introduction, check the SHAPE against the
exemplars: `doc/example_papers/style_extraction.md` §3 (abstract skeleton) and §3a (intro
anatomy: the five-move order, the method named in move 4, numbers rationed to the worked
example and the payoff). A draft whose shape is wrong is not fixable by sentence edits, and
reporting sentence findings on a mis-shaped section wastes the writer's time; report the shape
gap first (which move is missing, what is in the wrong place) and stop there until it is
settled.

The same check applies to the WHOLE paper's skeleton before its sections are drafted: count
the top-level sections and match the exemplar arc (intro, method/setup, one or two
consolidated evaluation-and-analysis sections, related work late, short conclusion; 5--7
total). One experiment never gets one top-level section: each result is a subsection with a
declarative finding title inside the consolidated section (FOURIER's §3.1--3.3 is the
pattern). A 10+-section draft is a shape violation to report and restructure before touching
any sentence.

## 1b'. The exemplar conformance audit (MANDATORY for the LaTeX paper; strict gate)

Sentence-level greps cannot catch structural or tonal drift from the exemplars, so the paper
gate includes a conformance audit whose output is a TABLE the writer must produce and show,
one row per dimension, each row citing evidence from the draft (a section count, a quoted
title, a quoted caption). A row without evidence is not a pass; any FAIL means the draft is
not done, and the fix is applied before re-auditing. Skipping the table or summarizing it
("all dimensions pass") voids the gate.

| # | Dimension | Rule (from style_extraction.md) | Pass evidence to cite |
|---|---|---|---|
| 1 | Skeleton | 5--7 top-level sections on the exemplar arc; results as subsections | the numbered section list |
| 2 | Title | purely one of the three exemplar forms (named method+benefit / declarative finding / gerund pair); a hybrid, e.g.\ a claim subtitle bolted onto a method title, is a FAIL | the title, which form, and that no second form is mixed in |
| 3 | Abstract | the exemplar skeleton, coined term defined inline, numbers only near the end | sentence-by-sentence move list |
| 4 | Intro | the five moves in order, method named once in move 4, numbers rationed | paragraph-by-move list |
| 5 | Section titles | top-level = noun phrase; findings only at subsection level, declarative | quote every top-level title |
| 6 | Section openers | goal-then-roadmap with section refs, or an opening question | quote one opener |
| 7 | Voice | "we" + present tense for claims, past for procedures; hedging graded to evidence; objections answered in place | one quoted example of graded hedging |
| 8 | Captions | interpretive: first sentence a claim/scope, markup decoded, direction in words | quote one caption's first sentence |
| 9 | Tables | booktabs only, baseline first row, same decimals per column, no header arrows | name each table checked |
| 10 | Notation/terms | just-in-time prose definitions; coined terms introduced once then used everywhere | where each coined term is defined |
| 11 | Transitions | previous result becomes the next problem; no meta-narrative | quote one transition |
| 12 | What-not-to-imitate | none of the extraction's banned habits (enthusiasm markers, self-grading, header arrows) | grep/table check statement |
| 13 | Abstract length | 185--210 words (FOURIER ~185, ROME ~200, H2O ~230 is the ceiling); over 250 is a FAIL | the word count |
| 14 | Overview figure | a Figure 1 exists, is referenced from the intro, and carries an interpretive caption (every exemplar has one) | the figure, its intro reference, its caption's first sentence |

## 1b. The reverse outline (global pass)

The pass above is local: it checks sentences and paragraphs one at a time. This one is global, and
it is the only check that catches a section whose paragraphs are each defensible but collectively
do not add up to the claim in its title. Run it on every section a non-trivial edit touched.

1. Write the section's claim in one sentence, taken from its title.
2. List the first sentence of every paragraph in that section, in order.
3. Next to each, name the one piece of evidence that paragraph rests on.
4. Map each first sentence onto a part of the claim. A paragraph mapping onto nothing gets cut or
   rewritten. Two paragraphs mapping onto the same part get merged.
5. Read the list of first sentences alone, bodies hidden. If that list is not already a readable
   argument, the section order is wrong and no amount of sentence polish fixes it.

Two failures this catches that nothing else does: (a) paragraphs that defend a number instead of
stating it, which is what a section accumulates when a result was contested during drafting;
(b) a finding asserted in a subsection title that no paragraph in the section actually supports.

If the outline is hard to write, the section has no thesis yet. Settle the thesis before the prose.

## 2. Language greps

Run `scripts/check_prose.sh <file> [...]` on every changed doc. It greps for the banned lists in
[references/style.md](references/style.md): em dashes (`---` or Unicode), the banned-word list (delve, crucial,
robust, leverage, ...), self-justifying framing about our own honesty ("reported honestly",
"to be fair", ...), capitals used as emphasis (`\b[A-Z]{4,}\b` in prose), and the greppable AI
writing patterns (inflated significance, `-ing` clauses tacked onto a finished sentence, copula
avoidance, authority tropes, filler phrases). Any hit is a rewrite, not an allowlist entry.

The script cannot catch the remaining language rules (second person, meta-narrative, grading our own
results) or the AI patterns that need counting rather than matching (rule of three, synonym cycling,
false ranges, aphorism formulas, staccato runs); check those by reading.
[references/ai-writing-patterns.md](references/ai-writing-patterns.md) holds all eleven patterns with
a before/after rewrite for each, plus the what-not-to-flag list that keeps the pass from gutting
correct prose. Open it whenever the script fires or a paragraph reads as written-for-cadence; a word
swap does not fix a paragraph built on one of these shapes.

## 3. Self-verification checklist (paper.md / proposal.md edits)

1. Every new sentence supports a positive claim (else: appendix).
2. Subsection titles are declarative.
3. Multi-condition results are tables, formatted per `doc/CLAUDE.md` §4 Tables: `booktabs` rules
   only, one decimal count per
   column, `\multicolumn` + `\cmidrule` for groups, one message per table.
4. Causal claims have `results.json` backing.
5. `\ref{}` targets are correct.
6. No implementation details in the diff.
7. No em dashes or banned words in the diff (§2 above).
8. The rendered PDF reads cleanly (overflow, figures, abstract length, references).
9. Numerical consistency: every number in the body matches its source table/appendix. Specifically: (a) pair counts in clustering tables satisfy C(n_pass,2) + n_pass*n_fail + C(n_fail,2) = C(N,2); (b) baseline values stated in multiple places agree; (c) directional claims about a sequence of numbers (e.g., "maintained", "strengthened", "reduced") match the actual sign of the change; (d) approximate rates ("1 in 20", "~30%") are consistent with the exact numbers in the corresponding table.
10. No forward-use of undefined terms: every technical term, named direction, named evaluation set, and external technique name is defined at or before first body use per the stranger-read pass above.

## 4. Render and read (LaTeX edits)

After every non-trivial edit to `doc/paper/`, run `scripts/render_pages.sh` (pdflatex + bibtex +
pdflatex x2, then rasterize every page to `tmp/paper_pages/page_NN.png`), then Read each page
image. Audit: figures cut off or unreadable at print size, empty plots, broken glyphs, `??`
references, table overflow (`Overfull \hbox`: fix with `p{width}` columns), abstract over 10
lines (trim to 200 words).

## 5. Reject-risk pass (before submission, and before any framing change)

Checks 1-4 ask whether the paper is correct and readable. This one asks whether it gets in, which
is a different question with a different failure mode: a paper can pass every check above and still
be rejected for a thin contribution or a missing ablation. Run it when a submission is in view or
when the framing is being reconsidered, not on every edit.

Read the paper as a reviewer looking for a reason to reject, and answer each question with a
specific pointer into the text (section, table, number) or the word "missing".

| Dimension | The reviewer's question |
|---|---|
| Contribution | What does a reader know after this paper that they could not have predicted? Is the problem a real puzzle, or a common case with a known cause? Is the result surprising, or the expected outcome of the setup? |
| Clarity | Could a knowledgeable reader reproduce every measurement from the paper alone? Does every component have a stated motivation tied to a named difficulty? Is notation stable across sections? |
| Empirical strength | Are the comparisons against the strongest available baseline, or a convenient one? Do the effects hold across models, seeds, and settings, or only where they were found? Are failures and ties stated where they belong? |
| Evaluation completeness | Does every design claim have an ablation or control that could have falsified it? Are the datasets and settings hard enough that the effect is not an artifact of an easy one? |
| Soundness | Is the setup realistic, or tuned per case? Does the demonstration show the mechanism, or only that the mechanism is constructible? Would a reviewer argue the net contribution is negative? |

Mark each answer `pass`, `needs revision`, or `needs new experiment`. Anything in the third
category becomes a planned experiment in `paper.md` (marked (planned) with its prediction), not a sentence to be written more carefully.

## Reporting the gate

The gate's findings are reported as edits, never as checklist bookkeeping. The reader is the
writer deciding what to change, not an auditor of this skill; internal labels ("stranger-read
check 3", "checklist item 9") mean nothing to them and do not appear. For each finding:

1. Quote the problem sentence (or name the missing thing).
2. Say what is wrong in plain words, in one sentence.
3. Show the fix: the rewritten sentence, or the one-line addition.

Order findings by what most changes the document (a missing contribution statement outranks an
overlong sentence), group them by location in the document (not by which check found them),
and cap the list at the fixes worth making: a finding not worth the writer's minute does not
earn a line. Lead with one sentence on where the draft stands overall; end with the one thing
to fix first.

## Done when

Every applicable check above passes and a full read of the rendered pages surfaces nothing new; for the LaTeX paper, the conformance-audit table (1b') has been produced with all twelve rows at PASS with cited evidence. Anything short of that: report what is still red, do not declare the edit done. Then close with `/update-status`: if the edit changed a claim, a verdict, the Goal/Thesis wording, or the outline, `doc/status.md` updates in the same commit.
