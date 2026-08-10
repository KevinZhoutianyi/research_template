---
name: blind-review
description: Blind referee + full blind reproduction of the paper — invoke when the user asks for 盲审 / 盲复现 / "review the paper without the code" / "reproduce the paper from scratch". Phase 1 reads ONLY the rendered PDF and judges the story's logic as a reviewer who has never seen this repo. Phase 2 isolates all project code, reimplements every experiment from the paper's own text, and RUNS them all on the cluster, blind. Phase 3 (non-blind) compares the blind numbers against the paper's and diffs the blind implementation against the real one. Manual-invoke only: this consumes real GPU budget end to end by design; invoking the skill IS the approval to run. Not for style or number-vs-data checks (that is /write-paper's gate and the audit tests).
---

# Blind Review and Blind Reproduction

Two questions the with-code audit cannot answer, because access to the code contaminates both:
does the paper's story hold up for a reader who cannot peek at what we meant, and does the paper
contain enough information to reproduce its results. Both are answered by agents whose entire
universe is the rendered PDF.

The costly failure mode is leaked context: a "blind" reviewer who has seen the repo's internal
vocabulary produces false confidence. Isolation is a prompt boundary around a cell directory
inside the repo, and it is verified rather than trusted (canary check, §5). Any report that
fails the canary check is discarded, not patched.

## 0. Setup: the isolation cell

The cell lives INSIDE the repo, at `blind_review/<date>/`; isolation is enforced by prompt
boundary and canary check, not by leaving the repo (nothing this project does writes outside
the repo).

1. Render the paper fresh with the project's build command (see `doc/CLAUDE.md` for this project's build command).
2. Create the cell: `mkdir -p blind_review/<date>/work` at the repo root and copy ONLY the
   rendered PDF there as `paper.pdf`. Nothing else: no README, no bib, no figures directory.
   The cell's `work/` outputs are committed with the report (large run outputs follow the
   project's usual rule for large files, pointed at from `work/`).
3. Build the canary list before spawning anything: 10-20 tokens that appear in the repo but
   not in the PDF (grep the PDF text to confirm absence). Draw them from four wells, none of
   which a PDF-only reader could know: internal metric or field names the paper renamed or
   never uses, run/experiment identifiers, script and directory names, and terms from
   deleted or internal-only docs. Save the list at `blind_review/<date>/canaries.txt` and
   never mention its contents to a blind agent.
4. Every blind agent's prompt states: "Your only input is
   <repo>/blind_review/<date>/paper.pdf. You have never seen the rest of this repository. Do
   not open, grep, glob, or list ANY path outside <repo>/blind_review/<date>/, and run no git
   commands. Write everything you produce under .../work/." Blind agents get NO other repo
   paths, no experiment names, no hints beyond the PDF. The only sanctioned resources outside
   the cell are public model/data caches and the cluster's job-submission command.

## 1. Phase 1 — the blind referee (story and logic only)

Spawn 2-3 referees in parallel, each with one lens, each reading only the PDF:

- **Logic-chain referee.** Reconstruct the paper's argument as a chain: claim per section, what
  evidence the section offers, whether the conclusion follows from THAT evidence alone. Flag
  every leap (conclusion stronger than the shown evidence), every circularity (evidence that
  presupposes the claim), every internal contradiction (two numbers or two statements that
  cannot both hold).
- **Alternative-explanation referee.** For each headline result, propose the strongest
  alternative explanation consistent with everything the paper shows, and check whether the
  paper's own controls rule it out. A control the paper describes but whose result is not shown
  counts as not shown.
- **Completeness referee (optional third).** What would this reviewer ask for in a rebuttal:
  missing baselines, missing conditions, results referenced but never presented.

Output per referee, structured: `{section, finding, severity (fatal/major/minor/question),
quote from the paper, why it does not follow}`. Style, grammar, and formatting are out of scope
(that is /write-paper's gate); only the argument is in scope.

## 2. Phase 2 — blind reproduction, one result at a time

One blind agent (or one per major result if budget allows) works only from the PDF:

1. **Inventory.** List every quantitative result the paper commits to, from the paper alone:
   each table, each figure panel, each in-prose number, with the section that defines its
   method. This inventory is the reproduction contract; it must come from the PDF, not from
   memory of what we ran.
2. **Per result, write the reproduction.** In `work/repro/<result-id>/`, write actual runnable
   code (Python) implementing the method as the paper describes it: prompt strings, injection
   mechanics, metrics, aggregation, gates. Where the paper is silent on a needed decision, the
   agent must (a) record the gap in `GAPS.md` with the exact question a reproducer would ask
   ("at which token position is the metric read?", "is the control seeded per item or shared?"),
   (b) make the most natural choice, and (c) mark the choice in code with `# PAPER-SILENT:`.
   The gaps file is the phase's primary product: every entry is a methods sentence the paper
   owes the reader.
3. **Classify each result:** `SPEC-COMPLETE` (code written with zero PAPER-SILENT marks) /
   `UNDERSPECIFIED` (code written, N gaps recorded) / `UNREPRODUCIBLE-AS-WRITTEN` (the
   description is too incomplete to attempt).
4. **Run everything.** Invoking this skill is the approval to spend the compute; there is no
   per-experiment ask. The blind agent smoke-tests each reproduction (tiny scale, full code
   path, per the project's smoke-test rule), then submits the full runs through the cluster
   scheduler under the project's compute posture (see the compute-posture rule in `CLAUDE.md`), polls to completion, and executes its own analysis code on its
   own outputs. Every result in the
   inventory gets a blind number and a blind figure/table written under `work/results/`.
   Model weights and tokenizers come from the shared public cache (weights are not project
   code; the isolation boundary is our code and results, not the models under study). Derived
   artifacts are part of the reproduction: anything the project computed from the models
   (extracted vectors, fitted probes, built datasets) the blind agent re-derives from the
   paper's description rather than reading the repo's caches; reading a cached derived
   artifact is reading our code's output, which breaks the blind. If a needed input is
   neither derivable from the paper nor a public artifact, the result is classified
   UNREPRODUCIBLE-AS-WRITTEN with the missing input named, and skipped rather than faked.

## 3. Phase 3 — compare, then diff (orchestrator, not blind)

Only after phase 2's runs are complete and its outputs frozen does anyone look at both sides.

**First the numbers.** For every result in the inventory, place the blind number next to the
paper's: `REPRODUCED` (within the result's own uncertainty, or same sign and magnitude class
where no uncertainty is published) / `PARTIAL` (direction holds, size differs beyond that) /
`FAILED` (sign flip, or effect absent) / `NOT-RUN` (with the reason). A FAILED cell is the
skill's highest-severity finding and is investigated before the report ships: the divergence
diff below usually locates whether the blind implementation, the real one, or the paper's
description is at fault.

**Then the implementation.** For every reproduction file and every `GAPS.md` entry, compare
against the real implementation:

- **Paper omission**: the blind code guessed; the real code decided; the paper never said.
  → a methods sentence to add (these are the cheap, high-value fixes).
- **Paper-implementation mismatch**: the blind code faithfully implements the paper's words and
  they differ from what the real code does. → severity by whether the difference could move a
  reported number; these findings outrank everything else in the report.
- **Benign divergence**: both implementations are consistent with the paper's words and with
  each other's results.

## 4. Report

One file, `doc/blind_review_<date>.md`: referee findings ranked by severity, the reproduction
scoreboard (every paper result with its blind number, the paper number, and
REPRODUCED/PARTIAL/FAILED/NOT-RUN), the full gaps list, the divergence table, and the GPU-hours
actually spent. One row in `doc/status.md` open issues. The report states which phase-1/phase-2
outputs were discarded by the canary check, if any.

## 5. The canary check (isolation integrity)

Before accepting any blind output, grep it for every token on the canary list. A single hit
means the agent saw the repo: discard that agent's entire output and note the discard in the
report. Do not edit hits out; contaminated blindness cannot be restored by redaction.

## Done when

The report exists with all three phases (or states which were skipped and why), every blind
output passed the canary check, every inventory result carries a scoreboard verdict (NOT-RUN
only with a named reason), every FAILED cell has a phase-3 diagnosis, and status.md carries the
row. Nothing is left as a menu: the runs are the skill.
