# Doc Folder Rules

Rules for writing the **research-tracking documents** in this folder:

| file / folder | what it holds |
|---|---|
| `paper.md` | The **argument** as a markdown working draft — goal, thesis, outline, per-section evidence, related work, slide reframing, detail appendices. Changes go here *first*. |
| `paper/` | The **same argument as polished LaTeX** for Overleaf / submission. Mirrors `paper.md`'s sections; lags it. See sync rule below. |
| `tracking.md` | The **status** — active runs, recently completed, recently failed, next steps. Each row cross-references the `paper.md` section it serves. |
| `weekly_updates/` | Slide decks for weekly updates (see `weekly_updates/CLAUDE.md` for slide-specific rules). |
| `related_papers/` | PDFs and notes on cited papers; one note per paper. The `paper.md` Related Work table references each by short citekey. |

The main documents are **living** — update them in place, never append dated entries. They are not chronological logs.

### `paper.md` ↔ `paper/` sync rule

`paper.md` is the **single source of truth** for the argument. `paper/main.tex` is its polished form for publication. They are kept loosely synchronized:

- When a new finding lands, update `paper.md` first. Always.
- Promote a section to `paper/main.tex` only when its content has stabilized (no expected re-runs / re-interpretations in the next week or two). Until then, the LaTeX version may lag.
- Section structure in `paper/main.tex` must mirror `paper.md`'s top-level sections (§1, §2, …). If they drift, the working draft wins — update LaTeX to match, not the other way around.
- `paper/references.bib` citekeys must match the per-paper notes in `related_papers/` (one `<citekey>.md` per `@article{<citekey>}` entry).
- `paper/figures/` PDFs are regenerated from `experiments/*/results.json` by `paper/figures/make_figures.py`. When the underlying experiment results change, re-run that script and commit the updated PDFs. Don't hand-edit the figures.
- The `paper/README.md` maintains a mapping table (paper.md § → main.tex §). Update it when section numbering diverges.

---

## 1. The two-file split (paper.md + tracking.md)

The two documents have a strict split:

| file | reader question it answers |
|---|---|
| `paper.md` | "What are we claiming and what's the evidence?" |
| `tracking.md` | "What's running, what just landed, what failed?" |

The split exists so the argument doesn't get cluttered with job IDs and the status doesn't get cluttered with theory. When in doubt: anything an outside reader of the paper would care about → `paper.md`; anything only the project team cares about → `tracking.md`.

**Both files at the root of `doc/` are canonical templates.** Read them before starting, and copy their section structure and patterns into the live documents for your project. The rules below describe *why* they're structured that way; the templates show *how* to apply them concretely. The patterns (Q&A mechanism sections, evidence classification, discovery-arc narration, "what we do NOT claim" calibration, plain-language Outline, narrative-vs-appendix split, mandatory failed-jobs table) are not optional decorations — they are the rules in action.

---

## 2. `paper.md` structure (the argument)

```
## Goal
  - Plain-language setup (3–6 sentences a non-specialist can follow)
  - Thesis (one sentence)
  - Prior work and what makes the question hard (with a theory-1 vs theory-2 table)

## Outline
  Four-column table per section: Question | What we did | What we showed | Therefore →
  Plain language only — no symbol-only shorthand. Detailed numbers live in §N below.

## §N Subgoal: <name> (<status>)
  - **Claim:** one sentence stating what this subgoal proves.
  - **Evidence:** experiments under this subgoal, each tagged Central / Sanity check / Supporting.
    Body keeps only headline + plain-language reading + caveat + pointer; detail tables go in Appendix C+.
  - **Context:** prior work positioning.

  Special pattern for §2 controls: include a "discovery arc" narrating how the
  controls developed (observation → naive control → loophole → refined control →
  discriminator), so readers see *why* the naive version wasn't enough.

  Special pattern for §3 mechanism: structure as explicit Q&A.
  Each Q maps to a subsection; each gets a one-sentence answer with citation.
  Synthesis recaps Q&A in a single table + names what we explicitly do NOT claim.

  Planned sections (§4 origin, etc.): frame as prediction-to-test, not a result.

## Related Work
  Table of papers with columns: Paper | Relation to our work.
  Each paper's full notes / PDF live in `related_papers/`.

## Reframing for slides
  Terse one-phrase-per-subgoal list; checks that slide story matches document story.

## Appendix A — Key terms
  Definitions of technical terms, so the body links here instead of defining inline.

## Appendix B — How to read the metrics
  Primary metric definition, common-confusion pre-empt, z-score formula.

## Appendix C, D, ... — Per-experiment detail dumps
  Large tables (per-bucket pass-rates, top-N rankings, counter-example tables,
  off-distribution diagnostics, full sweeps) live in their own appendix.
  The §N body carries a pointer "→ See Appendix X" instead of inlining the data.
```

---

## 3. `tracking.md` structure (the status)

```
## Active runs
  Table: job | exp | status | serves paper.md § | note

## Recently completed jobs
  Table: job | exp | serves paper.md § | result (one-line)

## Recently failed jobs
  Table: job | exp | failure mode | resolution
  MANDATORY — failures aren't re-attempted blindly.

## Next steps
  Numbered list, each step naming which paper.md § it serves.
```

---

## 4. Cross-document workflow when a job completes

1. Move its row in `tracking.md` from **Active runs** → **Recently completed jobs** (keep the row; it's the historical record).
2. Integrate the finding into the relevant `paper.md` § evidence section: update the headline number, the plain-language reading, and any new caveat. If the finding produces a wall of numbers (per-bucket, top-N, sweep), put those in an appendix and link from §N.
3. If the job *failed*, instead move it to **Recently failed jobs** with the diagnostic and the resolution (or "blocked on X"). Do not silently delete failed-job rows — they prevent re-attempting the same broken approach.

---

## 5. Rules for paper.md content

**Per-subgoal rules.**

- Every subgoal in `paper.md` states a **claim**, not just "test X." The claim is what we want the evidence to prove.
- Every experiment in `tracking.md` must cross-reference the `paper.md` § it serves. If it doesn't trace back to the paper, ask why we're running it.
- Job IDs and ETAs do NOT belong inline in `paper.md` subgoals — they live in `tracking.md`'s Active runs table.
- When a run completes, follow the cross-document workflow above.
- Distinguish **context** (prior work already solved this) from **our contribution** (we show this).
- External papers go in `paper.md`'s **Related Work** table, not inline in subgoals. Per-paper notes live in `related_papers/`.

**Goal-section rules.**

- The Goal section opens with a **plain-language setup** (3–6 sentences a non-specialist can follow) before any technical claim. Then states the **thesis** in one sentence. Then a "**prior work and what makes the question hard**" subsection that names the competing theories.
- When the project has competing theories (the typical case), include an explicit **theory-1 vs theory-2 table** showing what each predicts in the standard experiment and what a discriminating test would look like. Without it, the document reads as a list of results with no through-line.

**Outline rules.**

- The Outline is the **paper's argument in compressed form**, not a list of section names. Each row reads left-to-right as a self-contained chain: **Question we asked → What we did to answer it → What we showed → Therefore (what it implies + where it leads).**
- Use a four-column table: `§ | Question | What we did | What we showed | Therefore →`.
- **Plain language only in Outline cells.** No symbol-only shorthand (no `L=63`, no `cos(δ, v)`, no compact equations). If a term is unavoidable, define it elsewhere and refer to it by name. The Outline is what a non-specialist reads to understand the paper; if they can't follow it, the technical detail in the sections below is wasted on them.
- Each cell is 1–3 short sentences. Detailed numbers and per-experiment evidence stay in §1–§N below; the Outline is the abstract.
- The "Therefore" column must point at the *next* section (→ §N) or at the headline implication. This is what makes the Outline read as an *arc* instead of a *list*.
- For planned sections, mark the row `(planned)` and write "What we showed" as `(predicted)`. The "Therefore" column should state both the prediction and what would falsify it, so reviewers can see the discriminator before any data lands.
- Every subgoal still names the concrete experiment(s) that achieve it — usually in "What we did". If a subgoal has no concrete experiment, that's a planning bug, not a documentation choice.

**§2 (controls / discriminators) rules.**

- §2 must include a **discovery arc**: observation → theory 1 prediction → theory 2 prediction → naive control → why it was unfair/inconclusive → refined control → final discriminator. Readers who see only the final result cannot tell why the naive version wasn't enough; the arc is what makes the controls intelligible.
- For each control: state **what theory 1 predicts and what theory 2 predicts** before stating the result. If both predict the same thing, the control is a sanity check, not a discriminator.
- Tag each piece of evidence in the section as **Central / Sanity check / Supporting**.

**§3 (mechanism) rules.**

- **Mechanism sections are Q&A, not lists of facts.** Open the section with explicit numbered questions ("Q1. Where in the system does the effect form?"). Each Q maps to one subsection and gets a one-sentence answer with citation. A reader scanning the section should be able to extract the mechanism claims from the Q&A alone.
- Include a **subsection map** table (Q → subsection → evidence) so the reader can jump to the experiment that answers each question.
- The synthesis subsection recaps the Q&A in a single table, then has one combined-picture paragraph.
- The synthesis must include an explicit **"what we do NOT claim"** list — name each natural over-reading of the data and cite what falsifies it. Examples: "Not 'X is sufficient' — falsified by Q3's answer."

**Forward-looking / planned sections rules.**

- Frame planned sections as a **prediction to test**, not a result. State what each theory predicts the experiment will show. The status of the section should be `(planned)` or `(in progress)`, not omitted.

**Status and history rules (tracking.md).**

- Maintain three live tables in `tracking.md`: **Active runs**, **Recently completed jobs**, **Recently failed jobs**.
- **Every row in tracking.md must cross-reference the paper.md § it serves.** Without that link, tracking.md drifts back into being a chronological log disconnected from the argument.
- The **failed-jobs table is mandatory.** Document each failure with the diagnostic and the resolution (or "blocked on X"). Otherwise future attempts re-hit the same wall blindly.
- Status tables go in `tracking.md`, NOT in `paper.md`. The argument document stays clean of job IDs and queue state.

**Appendix rules.**

- Technical terms go in **Appendix A**; the body links to them on first use. Do not redefine inline.
- Metric definitions, common-confusion pre-empts, and statistical formulas (z-score, effect size, etc.) go in **Appendix B**.
- **Per-experiment detail tables go in their own appendix** (C, D, …, one per major experiment). This includes: per-bucket / per-condition pass-rate tables, top-N rankings, counter-example tables, off-distribution diagnostics, full hyperparameter sweeps. The body keeps only: (a) a **headline** sentence with the bottom-line number, (b) the **plain-language reading**, (c) any single caveat that changes the interpretation, (d) a pointer "→ See Appendix X".
- These appendices are not optional. They are what makes the main body read top-to-bottom; without them, technical definitions and detail dumps clutter the narrative.

**Slide-deck sanity-check rule.**

- Maintain a **"Reframing for slides"** subsection — a terse one-phrase-per-subgoal list. Use it as the source of slide headlines (built in `weekly_updates/`) and as a check that the slide story matches the document story. If you cannot reduce a subgoal to one phrase, the subgoal is not yet clear enough.

---

## 6. Rigorous Claims

`tracking.md`, slides, and paper drafts all argue for claims using evidence. Each claim must be calibrated to its evidence — not stronger, not weaker. The rules below catch the most common ways claims drift away from data.

### Calibrate claim strength to evidence

If the data supports the claim for 10/15 cases, write "for 10/15 cases" — not "the claim holds." If a finding is partial, say "partial." If a result depends on a single seed or a single setting, note the lack of robustness. If a claim depends on a deleted experiment whose data isn't currently in the repo, note that. Reviewers will find these gaps; flag them yourself.

### Classify each piece of evidence

For every entry in `paper.md`'s **Evidence** section, classify it as one of:

- **Central** — discriminates the hypotheses. If theory 1 and theory 2 predict different outcomes and the data picks one, it's central evidence.
- **Sanity check** — confirms a basic phenomenon. Both hypotheses predict the same outcome here. The result tells us "the experimental setup is working" but not "which theory is right."
- **Supporting** — consistent with the claim but not a discriminator. Includes methodological controls (e.g., that the metric is well-formed), generalization tests, robustness checks.

State each piece's classification explicitly. Otherwise sanity checks get cited as if they were central evidence.

### Articulate both hypotheses' predictions before running a control

Before designing or running a control experiment, write down both hypotheses and what each predicts the result will be. If both predict the same thing, the control is a sanity check, not a discriminator — useful, but it doesn't push between hypotheses. Note this in the run.py docstring and in `paper.md`.

This catches the failure mode of running a control, getting a result, and only later realizing it was consistent with everything you were testing.

### State an explicit Falsifier for every prediction

Every experiment plan (in `run.py` docstring, in `paper.md`'s Evidence section, and in any pre-experiment plan document) must include an explicit **Falsifier** clause: *the observation that would knock down the predicted result*. Phrase it as concretely as the prediction: "If X reaches Y under condition Z, the cascade-essential claim is challenged." Treat the Falsifier as a non-optional companion to the Predicted-Outcome.

Why this matters:

- Without a stated falsifier, any result drifts into being "consistent with the existing theory" post-hoc. The falsifier locks in ex ante what would force a re-read.
- It also disciplines the prediction: if you can't write a concrete falsifier, the prediction is too vague to test.
- When the data lands, the falsifier is what you check first — if it triggered, the section's claim must be weakened or rewritten before the result is integrated.

### Caveats inline

Each result statement includes its methodological caveats inline:

- If a comparison is asymmetric (e.g., "max over 30 random seeds" vs "single concept extraction"), say so where you state the result.
- If a test is single-seed or single-setting, say so.
- If a finding depends on an exp that didn't fully complete (partial data, manual recovery from logs), say so.

### Audit downstream when deleting an experiment

When pruning an experiment from the repo, search `tracking.md`, `paper.md`, slide decks (`weekly_updates/`), and the LaTeX `paper/` folder for downstream citations of its findings. Either:

- remove those citations, or
- demote them to a side-note that explicitly says "this finding lives in git history at commit `<hash>`, not in the current repo."

Otherwise the live document keeps citing data that the reader can no longer reproduce.

### Plain-language gloss

Any technical claim in `tracking.md`, slides, or paper drafts has a plain-English gloss within one paragraph. If a non-specialist reader can't restate the claim in their own words, the gloss is missing. Examples:

- "self-output prediction over a manipulated residual stream" → add: "the model is just running its normal next-token prediction on activations we tampered with — it doesn't notice the tampering, it just produces the output most consistent with whatever state we left it in."
- "z-score above the same-random distribution" → add: "the concept's measured value is more than 2 standard deviations above the random-vector baseline — i.e., not explained by random chance."

---

## 7. `related_papers/`

When a paper is cited in `paper.md`'s Related Work table, save a corresponding note in `related_papers/`:

```
related_papers/
├── <short_citekey>.md     ← one-paragraph summary + relation-to-our-work + key numbers
├── <short_citekey>.pdf    ← the paper itself (optional; gitignored if large)
```

The `paper.md` Related Work table is the *summary*; the `related_papers/` folder is the *reading-pile detail*. Don't inline long-form reading notes into `paper.md`.
