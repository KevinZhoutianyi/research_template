---
name: cleanup
description: The prove-then-delete procedure for anything that clutters the repo — dead code, dead docs, scratch/tmp files, stale checkpoints and outputs, and structure drift (folders that stopped matching the documented layout). Invoke ONLY when the user explicitly asks to delete or clean up ("clean up", "tidy", "delete X", "清理", "the repo is a mess") — never proactively; noticing clutter mid-task means mentioning it, not invoking this. Goal: the repo stays concise and every file has a home.
disable-model-invocation: true
---

# Cleanup: Keep the Repo Concise

The repo tells one mainline story: the current method, the experiments that back it, the docs
that report it. Anything else — failed code, superseded docs, scratch files, stale checkpoints,
folders that drifted from the documented layout — dilutes that story and misleads the next
reader. Once proven unneeded, delete it; git history keeps the record. The target state is the
root CLAUDE.md's clean-repo rule: every tracked file has a home named in the README layout
table, and nothing untracked lingers.

Two live copies of the same pipeline are worse than clutter, they are a correctness bug: a fix
lands in one copy while the other stays authoritative, and nothing in either file says which is
which. (Measured in a real incident: two scripts both implemented the full experiment loop; a
denominator fix was applied to the copy no run script had invoked for days, while the live copy
kept the bug.)

## The sweep (a "repo is a mess" request)

When the request is general ("clean this up", "the repo is a mess") rather than about one file,
walk these five categories in order; each has its own proof standard below.

1. **Untracked clutter.** `git status --porcelain` — scratch dirs, venvs, one-off test scripts,
   downloads. These have the lowest bar: never part of the story, so prove only that nothing
   unpushed or irreplaceable is inside (for a repo: clean status and no unpushed commits; for
   data: it is regenerable or copied elsewhere).
2. **Dead code.** Unused scripts, duplicate pipelines, orphaned entry points.
3. **Dead docs.** Superseded writeups, reports the mainline story absorbed, empty placeholder
   files whose folder is gone.
4. **Stale artifacts.** Checkpoints, logs, and outputs no run, report, or paper claim still
   reads. Distinguish from LIVE results data (see the data rule below).
5. **Structure drift.** Files parked at the wrong level (a doc at the root, code inside
   `doc/`), folders not in the README layout table, names that stopped matching contents. The
   fix is a `git mv` or a layout-table update, not necessarily a deletion — drift can mean the
   table is stale, and then the table is what gets fixed.

Present the findings as a table (path | category | evidence it is dead | proposed action) and
wait for the user's call before deleting anything not trivially scratch. Deleting is cheap to
propose and expensive to be wrong about.

## Proof standards (prove it dead first; the commit message says what proved it)

- **Code:** `grep -rn` the name across `*.py`, `*.sh`, and `doc/` — no callers, no imports, no
  launch script, no doc that tells someone to run it. Beware the HALF-LIVE file: a module whose
  functions are imported but whose `main()` is dead — delete the dead entry point, keep the
  imported wiring. Check imports (`import X as W`) separately from script invocations.
- **Docs:** no other doc links to it, and its claims are either superseded (the newer doc says
  so) or absorbed into the mainline story. A failed-direction writeup whose verdict is recorded
  in the experiment's README needs no standalone file.
- **Checkpoints and outputs:** dead only if no active run writes to it, no committed script
  reads it, and no report or paper number traces to it. When in doubt, ask: which claim would
  become unverifiable if this vanished? No answer after a real search = stale.
- **Any path:** no running job holds it (`squeue`/`ps` before deleting).
- **The data rule:** results artifacts a report still reads (`results.json`, `runs/<name>/`)
  are DATA, not clutter — never delete these to tidy up. If a reader and writer disagree on a
  filename, fix the disagreement rather than deleting either side.

## Landing it

- Deletion is its own commit, separate from any fix that exposed it, so a revert of either
  does not drag in the other. The commit message states what proved each path dead.
- A recurring offender earns prevention, not just removal: a `.gitignore` entry for artifact
  patterns, or a layout-table row that gives the file class a home.
- Delete only when every proof step above passes. If any step fails or stays uncertain, leave
  the content in place and record what blocked the proof (a comment or the conversation), so
  the next reader does not re-derive it.
