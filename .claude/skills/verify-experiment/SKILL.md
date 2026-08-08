---
name: verify-experiment
description: The delivery gate for experiment code — run before declaring any experiment code change done. Runs pytest on report-bound code paths, smoke-tests changed pipelines, rules out the seven AI-research failure modes, and reports what remains untested. Code only; doc edits go through /write-paper.
allowed-tools: Bash(pytest *), Bash(git diff *), Bash(uv run pytest *)
---

# Experiment Code Verification

The rules being verified live in `experiments/CLAUDE.md` §2 (correctness) and §7 (smoke-test).
This skill is the gate: run every step that applies, fix what it catches, re-run until clean.

1. **Scope.** `git diff --name-only` against the merge base to list changed experiment files.
2. **Tests.** Run pytest on the packages the changed files belong to. Report the actual
   pass/fail counts, never "tests pass". Report-bound code (scoring, statistics, data
   processing) with no tests is a finding, not a footnote: write the missing tests now
   (per §2 they are on by default), or list each untested path with one line on why not.
3. **Smoke.** If a changed script has a `--smoke` flag or a tiny-scale invocation, run it and
   confirm the real artifact (`results.json`, figures) is written where the reader of the run
   expects it.
4. **Failure modes.** Tests prove the code does what it was written to do; they cannot show it was
   written to measure the right thing. Before any result reaches a report or the paper, rule out the
   seven modes in [references/ai-research-failure-modes.md](references/ai-research-failure-modes.md)
   (Lu et al. 2026, Nature): implementation bug that passes self-review, hallucinated citation,
   hallucinated result, shortcut reliance, bug reframed as a finding, methodology fabrication,
   frame-lock. Each gets `CLEAR` with named evidence, `SUSPECTED`, or `INSUFFICIENT EVIDENCE`.
   Modes 1, 3, 5, and 6 at `INSUFFICIENT EVIDENCE` block; the others are reported.
5. **Report.** One table: file | what changed | test status (n passed / n failed / untested +
   reason). Failures are quoted verbatim, not summarized. Any `SUSPECTED` or blocking
   `INSUFFICIENT EVIDENCE` verdict from step 4 goes above the numbers, not in a footnote.

A change is not done while a report-bound path is red, silently untested, or carrying an unresolved
failure-mode flag.
