# Working Guide

**Re-read this file periodically during long conversations.** After extended implementation work (e.g., multiple rounds of code changes, waiting for jobs, debugging), re-read CLAUDE.md before the next task to avoid drifting into mechanical execution and losing sight of the project goals.

This file contains **universal project rules**. Context-specific rules live in subdirectory CLAUDE.md files:

| where | what it governs |
|---|---|
| `doc/CLAUDE.md` | how to write `paper.md`, `tracking.md`, weekly-update slides, and the related-papers section. Contains the two-file split rules, paper.md structure, tracking.md structure, rigorous-claims rules. |
| `doc/weekly_updates/CLAUDE.md` | slide formatting and presentation rules. |
| `experiments/CLAUDE.md` | code style, correctness, compute, experiment logging. |
| `theory/CLAUDE.md` | theory writing rules: no obvious theorems, justify assumptions, concrete takeaways, tightness, necessity, proof intuition. |

The LaTeX version of the paper lives at `doc/paper/`; see `doc/paper/README.md`.

---

## 0. Feedback File

**The user writes feedback into `doc/paper/feedback.md` after reading the paper or experiments.** At the start of every session, read that file and act on every bullet before doing anything else. After acting on a bullet, delete it from the file. If a bullet is ambiguous, ask before acting.

Typical content: paper paragraph too long, wrong framing in a section, experiment result misrepresented, tracking.md entry stale. The user does not write this file during a conversation — they write it after reading on their own. Do not add bullets to it yourself.
*(This is distinct from `doc/weekly_updates/YYYY-MM-DD/post_talk_notes.md`, which records advisor feedback after a talk.)*

---

## 1. Goal-Driven Work

**Whenever you design an experiment or build a slide deck, start by identifying the goal (or subgoal). Every piece of content must visibly serve that goal — if a slide, paragraph, table, plot, or experimental knob does not advance it, remove it.**

Workflow:

1. **State the goal in one sentence.** ("Show that method X outperforms baseline Y on benchmark Z under condition W.") If you cannot state it in one sentence, the goal is not yet clear enough — clarify before producing content.
2. **List the subgoals.** Each subgoal is something the audience or experiment must establish on the way to the goal.
3. **For every slide / experiment knob / paragraph, name which subgoal it serves.** If you cannot name one, cut it.
4. **Re-check at the end:** does the deck / experiment, read top to bottom, straight to the goal? Anything that detours, defends, or self-justifies should be cut.

This is the **first filter**, applied before slide-density, audience-tone, or figure-quality rules. Those rules only matter for content that has already passed the goal filter.

---

## 2. Tables over prose

For results, configs, comparisons, or any structured information, use a markdown table instead of bullets or paragraphs. Applies to written reports, `tracking.md` entries, and printed experiment summaries.

---

## 3. Git: Commit and Push

When adding a new experiment, updating tracking.md, or making any substantive change, **commit and push immediately** — don't wait for the user to ask. The user should never have to manually push.

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

**Always verify your output against the relevant subdirectory CLAUDE.md before declaring any task done.** The subdirectory rules are not optional checklists — they are the definition of "done" for that domain:

| task type | verify against |
|---|---|
| Paper edits (`paper.md`, `main.tex`) | `doc/CLAUDE.md` — body-structure rules + self-verification checklist + render-and-read workflow |
| Experiment code or analysis | `experiments/CLAUDE.md` — code style, correctness, smoke-test, logging |
| Figure code (`make_figures.py`) | `experiments/CLAUDE.md` §3 — research template: Okabe-Ito colors, no inline rcParams overrides, variance bands mandatory |
| Slide decks (`weekly_updates/`) | `doc/weekly_updates/CLAUDE.md` — slide formatting rules |
| `tracking.md` updates | `doc/CLAUDE.md` — three-way consistency invariant (experiments ↔ paper claims ↔ tracking) |

If you edit a paper section and do not run the body-structure checklist, you have not finished the task. If you write experiment code and do not smoke-test it, you have not finished the task. Verification is part of the work, not a separate optional step.

---

## 6. New Projects: New ntfy.sh Topic

When setting up a new project, generate a new unique ntfy.sh topic name and set it in `.claude/settings.local.json` in the hook commands (both the `PreToolUse` edit-notification hook and the `Stop` hook). Do not reuse the topic from another project. The topic name should follow the pattern `tzhou4-claude-<random6>` (6 random alphanumeric characters).
