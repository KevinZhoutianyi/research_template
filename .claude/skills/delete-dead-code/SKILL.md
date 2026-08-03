---
name: delete-dead-code
description: The prove-then-delete procedure for dead code and dead docs. Invoke whenever content looks dead (unused script, duplicate pipeline, orphaned entry point, a doc or report the mainline story no longer needs) — before deleting OR before deciding to leave it in place.
---

# Deleting Dead Code and Dead Docs

The repo tells one mainline story: the current method, the experiments that back it, the docs
that report it. Code or docs that failed, were superseded, or serve no future work dilute that
story and mislead the next reader -- so once proven unneeded, delete them; git history keeps the
record.

Two live copies of the same pipeline are worse than clutter, they are a correctness bug: a fix
lands in one copy while the other stays authoritative, and nothing in either file says which is
which. (Measured in a real incident: two scripts both implemented the full experiment loop; a
denominator fix was applied to the copy no run script had invoked for days, while the live copy
kept the bug.)

Prove it dead first, and say in the commit message what proved it:

- `grep -rn` the name across `*.py`, `*.sh`, and `doc/` -- no callers, no imports, no launch
  script, no doc that tells someone to run it.
- Beware the HALF-LIVE file: a module whose functions are imported but whose `main()` is dead.
  Delete the dead entry point, keep the imported wiring. Check imports (`import X as W`)
  separately from script invocations.
- For docs: no other doc links to it, and its claims are either superseded (the newer doc says
  so) or absorbed into the mainline story. A failed-direction writeup whose verdict is recorded
  in `tracking.md` needs no standalone file.
- No running job holds the path (`squeue`/`ps` before deleting).
- Results artifacts a report still reads (`results.json`, `runs/<name>/`) are DATA, not dead
  code -- never delete these to tidy up. If a reader and writer disagree on a filename, fix the
  disagreement rather than deleting either side.

Deletion is one commit, separate from the bug fix that exposed it, so a revert of either does
not drag in the other.

Delete only when every proof step above passes. If any step fails or stays uncertain, leave the
content in place and record what blocked the proof (a comment or the conversation), so the next
reader does not re-derive it.
