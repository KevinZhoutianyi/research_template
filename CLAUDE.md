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

## 3. Research Tracking (`tracking.md`)

Maintain a single `tracking.md` at the repo root. **Update it in place — never append new dated entries.** It is a living document, not a chronological log. It should read like a paper pitch — someone reading it top to bottom should understand the thesis, the claims, the evidence, and the gaps.

Structure:

```
## Goal
One sentence: the project's thesis.
Brief explanation: what theory predicts, why it fails in practice, what we show.

---

## Outline
Paper outline mapping sections to subgoals. Keeps the document connected to the final deliverable.

---

## Subgoal N: <name> (<status>)
**Claim:** One sentence stating what this subgoal proves.

### Evidence: <experiment name>
Results tables, key findings, probe figures.

### Context: <external work>
Brief note on related prior work that is context, not our contribution.

---
(repeat for each subgoal)

## Related Work
Table of papers with columns: Paper | Relation to our work.
Each entry explains how the paper supports or contrasts with our claims.

## Next steps
- ...
```

Rules:
- Every subgoal states a **claim**, not just "test X." The claim is what we want the evidence to prove.
- Every experiment must live under a subgoal. If it doesn't trace back to the goal, ask why we're running it.
- When a run completes, update its entry under the relevant subgoal with the finding.
- Keep active run status (job ID, ETA) inline with the experiment bullet.
- External papers go in the **Related Work** table, not inline in subgoals. Subgoals contain our evidence; related work explains how others' results support or contrast with our claims.
- Distinguish **context** (prior work already solved this) from **our contribution** (we show this).

---

## 4. Git: Commit and Push

When adding a new experiment, updating tracking.md, or making any substantive change, **commit and push immediately** — don't wait for the user to ask. The user should never have to manually push.

---

## 5. Surgical Changes

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

## 6. Verify Each Step

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
