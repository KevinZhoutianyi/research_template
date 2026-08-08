# Doc Folder Rules

| file / folder | what it holds |
|---|---|
| `paper.md` | The argument: goal, thesis, outline, per-section evidence, related work, appendices. Changes land here first. |
| `proposal.md` | The research proposal: method, baselines, risks, plan. Same writing rules as `paper.md`. |
| `paper/` | The same argument as LaTeX for Overleaf. Mirrors `paper.md`; lags it. |
| `weekly_updates/` | Weekly progress reports. Two forms, chosen per week: `/weekly-update` (Markdown) or `/weekly-slides` (Beamer). See `weekly_updates/CLAUDE.md`. |
| `related_papers/` | One note per cited paper. |
| `example_papers/` | Reference PDFs whose writing, figure, and section style this paper targets. |

These are living documents. Update in place; never append dated entries.

`paper.md` is a canonical template: copy its section structure into new projects instead of inventing parallel structures.

---

## 1. Writing rules (every file in this folder)

### Motivation first

Every paragraph, section, table row, and figure caption leads with why it exists: what question it answers or what gap it closes. A reader asking "why am I reading this?" at any sentence finds the answer in the surrounding prose.

Test for new content: write "Because [previous claim raised question X], we did [new thing], which shows [new claim]." If that sentence does not write itself, the content does not belong yet.

### One story, told once

Every doc in this folder (paper, proposal, update) reads as a single narrative line: a question, what was done to answer it, what was found, what that forces next, each section handing to the next. A reader must be able to retell the argument after one read; a pile of individually-true sections that do not hand off is a failed doc even when every sentence passes. The `/write-paper` reverse outline is the check; `/weekly-update` §0 carries the update-specific version.

The same rule kills redundancy: everything is said once, at full strength, in the place the narrative needs it. Every claim traces to the thesis or a named subgoal. When a claim appears twice, keep the strongest version and demote the other to a pointer. A body table with more than ~5 rows, or one that repeats numbers from the prose, moves to an appendix.

### The stranger-read pass

Run this on every doc and figure before delivering: re-read with zero context, checking for dangling referents, label-style section openers, categories without instances, overloaded sentences, unsignposted logical moves, and unreadable figure renders. The full pass (six numbered checks with the specific sub-checks) lives in the `/write-paper` skill; invoke it before declaring any doc edit done.

### Style and language

The structure and language rules (section-title forms, banned words and shapes, markup and
person rules, the plain-word test) live in one place: the `/write-paper` skill's
`references/style.md`. Open it before drafting any prose in this folder, not only at delivery;
`check_prose.sh` greps the greppable subset at the gate.

Style beyond the rules: match the example papers in `example_papers/` across writing
voice, figure design, and section structure. Before drafting a section opener, designing a
figure, or restructuring the paper, open one of those PDFs and check how it handles the same
situation. The `related_papers/` notes inform what we cite; the example papers inform how the
writing reads.

---

## 2. Claims and evidence

Calibrate claim strength to the data. If 10/15 cases support it, write "10/15", not "the claim holds". Partial results stay partial in the title, abstract, and figure titles: a chart showing N pass and M fail names both numbers. (Caught failure: a title claiming "is X, not Y" over data that was X for 24/39 and Y for 15/39; the fix was "Partial X over a strong Y baseline".)

Classify each piece of evidence as one of:
- Central: theories predict different outcomes and the data picks one.
- Sanity check: all theories predict the same outcome; confirms the setup works.
- Supporting: consistent with the claim but not a discriminator.

Write both theories' predictions down before running a control. If they predict the same thing, it is a sanity check, not a discriminator.

Every prediction carries an explicit falsifier, stated as concretely as the prediction ("if X reaches Y under Z, the claim is challenged"). When data lands, check the falsifier first.

Caveats sit inline next to the result: asymmetric comparisons, single-seed runs, partially completed experiments.

### Statistical reporting (hard rules; the single home, pointed at from the update and report skills)

What a result is allowed to claim is set by what was run, not by how it looks:

- **No reruns, no strength claim.** A single run reports its number with "single run" attached; "X beats Y" needs the rerun spread (or seeds) showing the gap outside it. With 3+ runs, report mean and spread with n; when the gap sits inside the spread, the sentence says so.
- **No baseline in the run, no comparative claim.** Absolute numbers only until the comparison arm exists.
- **Name the analysis unit** (task, seed, episode) before computing anything across it. A tasks-by-conditions table over the same tasks is a paired comparison, not independent samples; no winner is declared while the unit is ambiguous.
- **Allowed wording, forbidden wording.** For each headline claim, write both the wording the evidence supports and the stronger wording it does not. The forbidden version is what a rushed reader will repeat, so it is written down to be checked against.
- **Never replace missing evidence with confident prose.** A gap in the data is a sentence naming the gap and a next step recorded in the paper's plan, not a smoother paragraph.

When deleting an experiment, search `paper.md`, slides, and `paper/` for citations of its findings. Remove them or demote to "lives in git history at commit `<hash>`".

---

## 2a. Framing and drafting methodology

Rules for changing the story, not just the prose.

### Sketch first, fill later

Draft a paper the way you draw: outline before detail. Lock the one-sentence thesis and the section outline *first*, get them approved, then fill in prose one layer at a time. Do not polish a sentence while the thesis under it is unsettled, and do not rewrite the whole body in one pass when the framing might still move. Each framing-level decision is the user's: stop, present concrete labeled options (not open questions), and wait. "Which of these two theses is the spine?" with options beats "what should the framing be?".

### Fix the stance up front, keep it consistent

Decide the paper's stance toward its subject before touching wording, and hold it end to end (e.g. affirm-and-explain vs debunk). A stance leaks through title, abstract, section titles, transitions, related work, even a single scare-quoted word. After a stance change, grep the whole body for the old stance's vocabulary and fix every instance, in both `paper.md` and `paper/`.

Define the central term by the source literature's own criteria and refer to it the same way throughout: set the definition in the intro, refer each result back to a named criterion, and never let the term drift into a private sense between sections.

### Verify the mechanism against data before writing prose

Confirm a mechanism claim against the results before writing it, not from memory or from what the framing wants; prose that runs ahead of the data can get the mechanism assignment backwards and survive many commits. Every number in the body traces to a `results.json` and is recomputable; when a framing change reassigns what an experiment shows, re-open its data and re-derive. Quote a verbatim run/sample rather than reconstructing one.

### Titles and claim strength

Section titles are noun phrases (topic); subsection titles state the finding as a declarative. Never put a finding-claim in a top-level section title, and never put a protocol-sensitive number (a count that moves with the null or the extraction) in any title. Calibrate every claim to the data: no bare "is X, not Y" when the data is a split or a sub-1 correlation; use a comparative or state both numbers. When a result contradicts a claim already in the paper (even one written this session), fix the claim, do not defend it.

---

## 3. `paper.md`

Audience: coauthors and the advisor, not venue reviewers. Keep the full argument visible, surface weak spots for discussion, and prefer "We tried X. It failed because Y. So we did Z." over reviewer-style hedging.

Structure:

```
## Goal
  Plain-language setup (3-6 sentences a non-specialist can follow).
  Thesis in one sentence.
  Prior work and what makes the question hard, with a theory-1 vs theory-2 table.

## Outline
  Four-column table per section: Question | What we did | What we showed | Therefore ->
  Plain language only. Each "Therefore" points at the next section or the headline implication.
  Planned rows are marked (planned) with predictions and falsifiers.

## §N Subgoal: <name> (<status>)
  Claim: one sentence stating what this subgoal proves.
  Evidence: experiments tagged Central / Sanity check / Supporting.
  Body keeps headline + plain-language reading + one caveat + appendix pointer.

## Related Work        (table: Paper | Relation to our work; notes live in related_papers/)
## Appendix A  Key terms
## Appendix B  How to read the metrics
## Appendix C+ Per-experiment detail dumps (per-bucket tables, top-N lists, sweeps)
```

Section rules the template cannot show:
- The main body tells the positive story only. Ablations, falsified hypotheses, and "what we do NOT claim" lists go to the appendix.
- A controls/validity section, when the paper has one, includes a discovery arc: observation, naive control, why it was not enough, refined control, discriminator. State what each theory predicts before each result.
- A mechanism/analysis section, when the paper has one, opens with numbered questions, one subsection per question, a one-sentence answer each, then a synthesis table and an explicit what-we-do-NOT-claim list citing what falsifies each over-reading.
- Planned sections are framed as predictions to test, never as results.

Before declaring a paper edit done, invoke the `/write-paper` skill and run its 10-point self-verification checklist (positive claims, declarative titles, tables, `results.json` backing, `\ref{}` targets, no implementation details, language greps, rendered-PDF audit, numerical consistency, no forward-use of undefined terms).

---

## 4. `paper/` (LaTeX)

Sync: `paper.md` is the source of truth. Promote a section to `main.tex` only when stable. Structure mirrors `paper.md`; if they drift, the working draft wins. `paper/README.md` maintains the section mapping.

Render and read after every non-trivial edit: the `/write-paper` skill §4 has the render script (compile + rasterize every page to `/tmp/paper_pages/`) and the page-by-page audit list.

Figures earn their place by answering a question the prose set up, being readable at final size, and carrying structure prose cannot (distributions, comparisons, sweeps). A figure showing one number already in the prose is redundant. Captions open with the question the figure answers. When removing a figure: comment out its call in `make_figures.py` with a one-line reason, keep the function, remove the `\ref{}`s from both `main.tex` and `paper.md`. Figure PDFs are regenerated by `paper/figures/make_figures.py` from `results.json`; never hand-edit them.

Tables: `booktabs` rules only (`\toprule`, `\midrule`, `\bottomrule`), never `\hline`, never a vertical rule, never a double rule. No `$\uparrow$`/`$\downarrow$` direction markers in headers or on axes: an arrow glued to a column name is decoration, since the column is already ordered and its numbers already read low to high. Which direction is the good one is a fact about the metric, so it goes in the caption in words, where it can be stated once and qualified. Same decimal count down a column, units in the header, text columns left-aligned and numeric columns aligned on the decimal point. Group multi-setting columns with `\multicolumn` plus `\cmidrule`, not a rule between them. One table, one message: a table carrying two unrelated comparisons is two tables. Highlight sparingly, and only the row or cell the caption is about.

Floats: load `placeins`; put `\FloatBarrier` after the Conclusion, before the bibliography. Document order: Conclusion, `\FloatBarrier`, bibliography, `\appendix`, appendices. Use `[t]` placement; never bare `[h]`.

Bibliography: every entry is title + url + year + `author = {TBD}`. Never type author names, even partially remembered ones; the human fills them in from verified metadata. Inline citations go through `\citet`/`\citep` only. "TBD (2025)" rendering in drafts is intentional: it marks unverified entries.

Never declare a human-supplied citation fabricated from an arXiv miss alone. Search OpenReview, ACL Anthology, Semantic Scholar, Google Scholar, and the venue page; fetch any URL the human gave (extract PDF text if needed). After all that, say "could not confirm via X, Y, Z", not "fabricated".

Coauthor comments: `\tynote{}` (blue, author), `\robinnote{}` (red, advisor), `\coauthornote{Name}{}` (green), `\inlinecomment{TY}{}` (purple). Disable all via `\usepackage[disable]{todonotes}`.

Overleaf zip, from `doc/paper/`: `zip <project>_overleaf.zip main.tex references.bib README.md figures/*.pdf`. Place at the repo root (gitignored). Exclude `main.pdf`, aux files, and `make_figures.py`.

---

## 5. Results and claims stay consistent

Two artifacts carry project state: experiment code/results and paper claims. A change to one is incomplete until the other matches:
- New paper claim: point it at a supporting `results.json`, or mark the section (planned).
- Landed result: update the paper's headline number, reading, and caveat. If `results.json` says "15/39 pass" while the paper says "passes the test", the paper is stale.
- Falsified hypothesis: remove it from the paper body (or mark it ruled out), note the triggered falsifier in the run script docstring.

Job IDs and ETAs never appear in `paper.md`.

---

## 6. `related_papers/`

One `<citekey>.md` per cited paper: a one-paragraph summary, the relation to our work, key numbers. Citekeys match `paper/references.bib`. The `paper.md` Related Work table stays a summary; long notes live here.

---

## 7. `example_papers/`

PDFs of papers whose presentation every doc in this folder aims to match — the paper, the proposal, and weekly updates alike. Different from `related_papers/`: those define what we cite; these define how we write, plot, and structure.

`example_papers/style_extraction.md` is the per-dimension distillation of the PDFs (title forms, section structure, abstract shape, prose voice, figure-caption formulas, table conventions, algorithm blocks), with verbatim quotes. It is the first stop when drafting; open the PDF itself when the extraction is not enough. Regenerate the extraction when the PDF set changes.

The dimensions to mirror:
- Writing voice: sentence rhythm, how a claim is introduced and qualified, motivation-first openers, declarative section titles.
- Figure design: panel layout, axis labels, color palette, caption form (question first, then plot, then implication).
- Section structure: intro staging, body vs appendix split, how a multi-step argument is laid out across §3/§4.
- Tables and algorithm blocks: caption conventions, what the caption concludes, markup habits.

Before any non-trivial doc edit, ask: would this paragraph, figure, or section structure fit naturally inside one of the example papers? If no, adjust before committing.

Files are named `<short_slug>_<arxiv_id>.pdf`. Update the set when the target venue or paper voice changes.
