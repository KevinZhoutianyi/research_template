# Working Guide

**Re-read this file periodically during long conversations**, before the next task after extended
implementation work, so the project goals stay in view.

**Every rule has exactly one home.** This file holds safety rules (full text) and behavior rules
(one line + pointer). Task procedures live in skills; directory facts live in subdirectory
CLAUDE.md files.

## Routing

| task | rules live in |
|---|---|
| doc edits (`paper.md`, `proposal.md`, LaTeX) | `/write-paper` (style.md before drafting, gate before done) + `doc/CLAUDE.md` |
| experiment code / analysis | `experiments/CLAUDE.md` while writing; `/verify-experiment` before done |
| theory writing | `theory/CLAUDE.md` |
| figures (paper, updates, `visualize.py`) | `/scientific-figure-making` |
| weekly updates | `/weekly-update` (Markdown) or `/weekly-slides` (live talk); invoke before drafting |
| status answers in chat | `/progress-report` |
| reading a paper into `related_papers/` | `/read-paper` |
| deleting or tidying anything (code, docs, tmp files, checkpoints, structure) | `/cleanup` (prove dead first) |

## Safety rules (full text; these do not move)

- **Compute posture (per-project; state at init).** Which cluster/scheduler, what is free vs
  metered, the parallelism posture, any self-imposed caps. Example (an AWS-sponsored project):
  API calls are unlimited and free, so optimize wall-clock speed with maximum request
  parallelism; every compute job goes through `sbatch` on a compute node, never the login node;
  GPU jobs self-capped at 40 nodes across all concurrent jobs. Details: `experiments/CLAUDE.md` §5.
- **Delete only what is proven dead** via the `/cleanup` procedure; never on suspicion.
- **Commit and push after any substantive change.** The user never has to ask.
- **Decisions are prompted as options.** At any "what should we do" moment (framing, next
  experiment, restructuring), present 2-4 concrete labeled options with trade-offs and wait.
  Executing an agreed plan needs no prompt; setting direction always does.

## Behavior rules (one line each; the pointer holds the detail)

- **Goal first, told as a story.** State the goal in one sentence before designing anything;
  every part serves a named subgoal, and threads that drift get cut. Every piece of writing —
  docs AND chat replies — reads as one line the reader can follow (what was asked, what was
  found, what follows), never a bare inventory of items; relate each item to the goal, or drop
  it. The full narrative rule: `doc/CLAUDE.md` §1 "One story, told once".
- **Ask, don't assume.** When a request has more than one reasonable reading and the choice
  changes the outcome, ask one targeted question before acting. Trivial ambiguity gets a stated
  assumption ("assuming X; say otherwise"), never a silent guess.
- **Verify each step.** A task is done when it passes its gate in the routing table, not when
  the code runs. Skipping the checklist means the task is not finished.
- **Surgical changes.** Touch only what the request requires; remove what your change orphaned;
  do not improve adjacent code.
- **Everything lives inside the repo; nothing outside it is touched.** All files Claude
  creates — scratch, demos, checkpoints, outputs — go inside the repo: throwaway work in
  `tmp/` (gitignored, deletable at any time), keepable artifacts in their layout-table home.
  Never write, move, or delete anything outside the repo directory unless the user explicitly
  asks. The repo stays clean: every tracked file has a home named in the README layout table,
  and the repo root gains a new entry only by an explicit user decision.
- **Tables over prose** for results, configs, and comparisons, everywhere.
- **Reports carry their own context.** Define every coined term at first use in every report;
  translate each headline number into its concrete meaning. The test: the reader can repeat the
  claim to a third person without a follow-up question.
- **Plain language, then an example.** The user runs several projects in parallel and does not
  carry context between conversations: open with the everyday-words version, ground each
  abstraction in one worked example from this project, re-establish any background a reply leans
  on (never "as discussed"), and never cite a run ID or config tag as if remembered (restate in
  words).
- **Everything earns its place, nothing is invented.** Every sentence is grounded (checked
  this session, or explicitly marked unverified — a plausible guess stated as fact is the
  worst failure this file names) and necessary (changes what the reader knows or decides).
  Chat follows the house language rules too (`/write-paper` references/style.md, "Chat
  replies"): no em dash, contrast constructions at most once per reply, vary the
  colon-then-elaboration join.

Enforcement that does not rely on memory: a git pre-commit hook (`.githooks/`; enable with
`git config core.hooksPath .githooks`) runs the language checks on staged docs, and a
UserPromptSubmit hook suggests the matching skill; neither replaces reading the rules.
