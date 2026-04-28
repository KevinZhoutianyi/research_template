# Working Guide

**Re-read this file periodically during long conversations.** After extended implementation work (e.g., multiple rounds of code changes, waiting for jobs, debugging), re-read CLAUDE.md before the next task to avoid drifting into mechanical execution and losing sight of the project goals.

This file contains universal rules. Context-specific rules live in subdirectory CLAUDE.md files:
- `experiments/CLAUDE.md` — code style, correctness, compute, experiment logging
- `notes/weekly_updates/CLAUDE.md` — slide formatting and presentation rules

---

## 1. Goal-Driven Work

**Whenever you design an experiment or build a slide deck, start by identifying the goal (or subgoal). Every piece of content must visibly serve that goal — if a slide, paragraph, table, plot, or experimental knob does not advance it, remove it.**

Workflow:

1. **State the goal in one sentence.** ("Show that superposition CoCoNut still works at depth 12.") If you cannot state it in one sentence, the goal is not yet clear enough — clarify before producing content.
2. **List the subgoals.** Each subgoal is something the audience or experiment must establish on the way to the goal.
3. **For every slide / experiment knob / paragraph, name which subgoal it serves.** If you cannot name one, cut it.
4. **Re-check at the end:** does the deck / experiment, read top to bottom, straight to the goal? Anything that detours, defends, or self-justifies should be cut.

This is the **first filter**, applied before slide-density, audience-tone, or figure-quality rules. Those rules only matter for content that has already passed the goal filter.

---

## 2. Tables over prose

For results, configs, comparisons, or any structured information, use a markdown table instead of bullets or paragraphs. Applies to written reports, `tracking.md` entries, and printed experiment summaries.

---

## 3. Session Tracking (`tracking.md`)

Maintain `tracking.md` at the repo root. **Add a new entry at the start of every working session.** This is the running research log — it must make it possible to pick up exactly where you left off after any break.

Each entry contains:

- Date + time the session started
- One-line focus summary
- Status table covering all active and recently completed runs (columns below)
- Findings, surprises, next steps

**Required status-table columns:**

| experiment | method | task | epoch | stage | val acc | status | ETA |
|---|---|---|---|---|---|---|---|

| column | format | example |
|---|---|---|
| experiment | directory name | `01_small_superposition_reachability` |
| method | model + key hyperparams | `Coconut (bs=128, lr=1e-4)` |
| task | one-line description | `binary reachability` |
| epoch | `current/total` | `167/300` |
| stage | curriculum stage if any | `4/4` |
| val acc | `correct/total = %` | `238/258 = 92.2%` |
| status | running/complete/queued/crashed | `running (GPUs 0,1)` |
| ETA | UTC finish time, from recent epoch timing | `Mar 27 ~18:30 UTC` |

Update at the start of each session **and** whenever any status changes. Always include ETAs for running experiments.

---

## 4. Surgical Changes

Touch only what you must. Clean up only your own mess.

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: every changed line should trace directly to the user's request.

---

## 5. Verify Each Step

Transform tasks into verifiable goals and loop until verified.

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Examples:

- "Add validation" → write tests for invalid inputs, then make them pass.
- "Fix the bug" → write a test that reproduces it, then make it pass.
- "Refactor X" → ensure tests pass before and after.

Strong success criteria let you loop independently. Weak criteria ("make it work") require clarification — ask before starting.
