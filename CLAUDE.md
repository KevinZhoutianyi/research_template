# Working Guide

**Re-read this file periodically during long conversations.** After extended implementation work (rounds of code changes, waiting for jobs, debugging), re-read it before the next task so the project goals stay in view.

This file holds universal project rules. Context-specific rules live in subdirectory CLAUDE.md files and task-triggered skills (`.claude/skills/`):

| where | what it governs |
|---|---|
| `doc/CLAUDE.md` | `paper.md`, `proposal.md`, `tracking.md`, the LaTeX paper, related-papers notes. Writing rules, claims calibration. |
| `experiments/CLAUDE.md` | code style, correctness, compute (per-project), experiment logging. |
| `theory/CLAUDE.md` | theory writing: no obvious theorems, justified assumptions, tightness, proof intuition. |
| `/weekly-update` skill | weekly progress reports as Markdown. Invoke before drafting one. |
| `/weekly-slides` skill | weekly progress reports as Beamer decks. Each project picks one form at init (`doc/weekly_updates/CLAUDE.md`). |
| `/verify-paper` skill | the delivery gate for doc edits: stranger-read pass, checklist, render-and-read. |
| `/paper-figure` skill | figure code rules (paper, updates, `visualize.py`). |
| `/progress-report` skill | structure for status answers to the user. |
| `/delete-dead-code` skill | prove-then-delete procedure for dead code and dead docs. |
| `/verify-experiment` skill | the delivery gate for experiment code: pytest, smoke, untested-path report. |

The LaTeX paper lives at `doc/paper/`; see `doc/paper/README.md`.

---

## 1. Goal-driven work

Before designing an experiment or building a deck, state the goal in one sentence ("Show that method X beats baseline Y on benchmark Z under condition W"). If one sentence is impossible, the goal is not clear enough yet; clarify first.

Then list the subgoals, and name which subgoal every slide, paragraph, table, plot, and experimental knob serves. No subgoal, no content. Re-check at the end: does the whole thing read straight to the goal? Cut anything that detours, defends, or self-justifies.

The same anchoring applies to conversation, not just artifacts. When proposing, reporting, or discussing anything mid-task, say which goal or subgoal it serves and how; if the connection cannot be stated in one sentence, stop and re-anchor before continuing. A thread that drifts from the goal (side quests, speculative tangents, polish nobody asked for) gets cut the same way a detouring paragraph does.

This filter comes before any formatting rule.

---

## 2. Tables over prose

Results, configs, and comparisons go in markdown tables, not bullets or paragraphs. Applies to reports, `tracking.md` entries, and printed experiment summaries.

---

## 2b. Compute posture (per-project)

Every project states its compute rules here at init: which cluster/scheduler, what is free vs metered, the parallelism posture, any self-imposed caps. Details and gotchas live in `experiments/CLAUDE.md` §5.

Example (an AWS-sponsored project): API calls are unlimited and free — optimize wall-clock speed with maximum request parallelism, never economize on calls or model size; every compute job goes through `sbatch` on a compute node, never the login node; GPU jobs self-capped at 40 nodes across all concurrent jobs.

---

## 3. Git: commit and push

After adding an experiment, updating tracking, or any substantive change: commit and push immediately. The user never has to ask or push manually.

---

## 4. Surgical changes

Touch only what the request requires; clean up only your own mess.

- Do not improve adjacent code, comments, or formatting.
- Do not refactor what is not broken. Match existing style.
- Do remove imports/variables/functions that YOUR change orphaned.
- Delete dead code and dead docs once you have PROVEN them dead. Never delete on suspicion: the proof procedure (grep for callers and references, half-live check, running jobs, data-not-code) is the `/delete-dead-code` skill -- invoke it before deleting OR before deciding to leave suspected-dead content in place.

Test: every changed line traces directly to the user's request.

---

## 5. Verify each step

Turn tasks into verifiable goals and loop until verified. For multi-step tasks, state the plan as steps each paired with a check ("Add validation -> tests for invalid inputs pass"). Weak criteria ("make it work") need clarification before starting.

A task is not done until the output passes the relevant rule set (subdirectory CLAUDE.md or skill):

| task type | verify against |
|---|---|
| Doc edits (`paper.md`, `proposal.md`, `main.tex`) | `doc/CLAUDE.md` writing rules while drafting; the `/verify-paper` skill before declaring done |
| Experiment code or analysis | `experiments/CLAUDE.md` while writing; the `/verify-experiment` skill before declaring done |
| Figure code (`make_figures.py`, `visualize.py`, update figures) | the `/paper-figure` skill: Okabe-Ito constants, no inline rcParams, variance bands, render-then-read |
| Weekly updates | the project's chosen form: `/weekly-update` or `/weekly-slides` (invoke before drafting, not just to verify) |
| Theory writing | `theory/CLAUDE.md` |
| `tracking.md` updates | `doc/CLAUDE.md` §5: three-way consistency (experiments, paper claims, tracking) |

Skipping the checklist means the task is not finished. Verification is part of the work.

---

## 6. Reports carry their own context

Result summaries and explanations (chat messages, READMEs, tracking rows, slides) are read by someone who did not watch the work happen. Names coined during the work (a pipeline stage, an eval config, a task subset) mean nothing to that reader.

Before the numbers: state in one or two sentences what question the experiment answers, what was run, and what is being compared. Define every coined term at first use in every report; a definition given in an earlier message does not carry over. Translate each headline number into its concrete meaning ("5 of the 11 tasks that passed without steering now fail", not "5 broke").

Test: can the reader repeat the claim to a third person without asking a follow-up? Any sentence that would trigger "what does that mean" gets expanded before sending.

---

## 7. Explanations: plain language, then an example

The user runs several projects in parallel and does not hold this project's context in their head. When explaining anything (a result, a bug, a design choice, a concept), default to plain language and a concrete example, in that order:

- Open with the everyday-words version ("the control group", "the placebo"), not the field term ("the null distribution"). Introduce the term after the plain meaning, if at all.
- Ground every abstraction in one worked example from the project's own setup ("we inject 30 pieces of pure noise and record how strongly each fools the model; that average is the baseline a real concept must beat").
- Never assume a term defined in an earlier session, an earlier message, or the paper is remembered. Re-explain from zero each time.
- Never cite an experiment ID, run name, config tag, or commit hash as if the user remembers it. Restate what it was in words every time: "the run where the steerer was capped at 3 steps", not "`1150ed6_1`".
- Technical depth is fine, jargon shortcuts are not: if a sentence needs a term of art, unpack it in the same sentence.

Test: someone working on a different project all week should follow the whole explanation on first read, without opening the repo.

---

## 8. Progress reports are measured against the goal

When the user asks for status or progress (any "where are we" update, not a one-off factual answer), invoke the `/progress-report` skill before drafting. Its rule in one line: goal restated first, progress judged against it (met / not met / partial and why), one comparison table, unfavorable results included, single next step -- never a list of activity.

---

## 9. Decisions are prompted as options

At a decision point (framing a paper, choosing the next experiment, restructuring rules or docs, any "what should we do" moment), stop and present the choice as 2-4 concrete labeled options with their trade-offs, then wait. An open question ("what framing do you want?") is not a prompt. Executing an already-agreed plan needs no prompt; setting direction always does.

---

## 10. Everything earns its place

Before writing any sentence -- chat, doc, report, commit message -- it passes two checks:

- **Grounded.** It states something verified (a number from a real file, a behavior actually observed, a rule actually written), or marks itself unverified ("not yet checked", "untested"). Plausible-sounding filler stated as fact is the worst failure mode.
- **Necessary.** It changes what the reader knows or decides next. Restating the known, padding transitions, and empty hedges get cut, not polished.

The same two checks govern code and docs as artifacts: concise and effective over redundant and complex. Every function, branch, config knob, section, and table earns its place by serving the goal; the simple version that works beats the general version that might someday be needed. When something fails the check, delete it, however well it reads or however long it took to write.
