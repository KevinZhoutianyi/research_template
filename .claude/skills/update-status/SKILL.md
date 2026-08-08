---
name: update-status
description: Check whether doc/status.md (the one-screen project dashboard) needs updating, and apply the update. Invoke at the end of any experiment or doc change — the delivery gates (/verify-experiment, /write-paper) name this as their closing step — and whenever a result lands, a hypothesis is falsified, a subgoal is added or dropped, or the goal/thesis wording changes. Skip only when the change touched nothing the dashboard reports.
---

# Keeping status.md Current

`doc/status.md` is trusted precisely because it is always current; a stale dashboard is worse
than none. This skill is the check that runs at the end of a change, not a rewrite session:
usually it edits one row and takes a minute.

## The check

Diff what just changed against what the dashboard reports. Any YES below means edit
`status.md` in the same commit as the change:

| what just happened | what to update |
|---|---|
| a result landed (new headline number, new `results.json`) | the matching subgoal row: status + result-so-far line; the **Verdict** line if the headline moved |
| a hypothesis was falsified | flip the row, and the Verdict line |
| a subgoal was added, dropped, or reordered | the table, together with the `paper.md` Outline (same commit) |
| an issue opened or resolved | the **Open issues** list (same definition as the weekly update's section; this list is the living version) |
| a next step was chosen, finished, or abandoned | the **Next steps** list |
| `paper.md`'s Goal or Thesis wording changed | the quoted one-liners here, verbatim, same commit |

Nothing above happened (a refactor, a style fix, a figure re-export): say so and stop. Do not
touch the file just to touch it.

## Rules

- **State only, never argument.** One line per row; the detail lives in `paper.md` and the
  experiment README the row points at. If an update needs a paragraph, the paragraph belongs
  elsewhere and the row gets its one-line summary.
- **The Verdict word is earned.** supported / partially supported / under test / falsified —
  pick by the statistical hard rules (`doc/CLAUDE.md` §2): a single run cannot move the
  verdict to "supported"; a gap inside the rerun spread stays "under test".
- **Same commit.** The status edit rides with the change that caused it (`doc/CLAUDE.md` §5
  three-way consistency), never a separate "update status" commit later.
- Plain language throughout: the reader of this file has zero background (same standard as
  the weekly update).

Done when: every row the change touched is current, the Verdict line matches the strongest
claim the evidence allows, and the file still fits on one screen.
