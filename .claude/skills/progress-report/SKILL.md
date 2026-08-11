---
name: progress-report
description: Structure for any status answer to the user — "where are we", "how is it going", "什么情况", "进展如何", or any request for progress. Invoke before drafting the reply — the report is framed around the goal, never around activity. This is the chat answer; the committed weekly file is /weekly-update.
---

# Progress Reports Interleave Story and Experiment, Step by Step

When the user asks for status or progress (any "where are we" update, not a one-off factual
answer), frame the report around the goal, never around activity. **Read `doc/status.md`
first** (the dashboard: goal, verdict, per-subgoal rows) and answer from it plus anything
newer than its last update; if the two disagree, the run data wins and status.md gets fixed
via /update-status.

**The body is ONE numbered walk through the story, where each numbered step carries its own
experiment and progress inline** -- never a story section first and a separate experiment/plan
list after (a reader then has to join the two lists themselves; a real report review flagged
exactly this split as the failure). Each step reads:

> N. **<story beat in one sentence>** -- experiment: <what runs/ran to establish it>;
> progress: <state + the number(s) so far, or "not started / planned for <when>">.

Structure, in this order:

1. **Restate the goal in one sentence**, with the success criterion and how it is measured ("beat baseline B and competing method M on benchmark Z, K seeds, reported as mean successes / N").
2. **State progress against that goal in one or two sentences** -- met / not met / partial, and *why*. "We led once (+1.7) and tied once, both inside the noise band, so not yet demonstrated" beats "I ran two evals."
3. **The numbered story-with-experiments walk** (the body, rule above). Order the steps as the argument flows -- motivation, method, main evidence, mechanism, boundaries, cost -- and attach every running or planned experiment to the step it serves. An experiment serving no step either gets its own step (if it changes the story) or is cut from the report.
4. Where a step's numbers compare conditions, use a small table inside that step (root CLAUDE.md: tables over prose).
5. **Report results that do not support us** plainly, inside their step. A run where we tie or lose is part of the status and is never omitted or softened. Claim strength follows the statistical hard rules in `doc/CLAUDE.md` §2 "Statistical reporting" (single run, no strength claim; gap inside the spread, say so; mid-run counts are direction only, never a claim).
6. **End with the single next step that moves toward the goal**, plus anything only the user can do.

Test: the first two sentences must tell the user whether we are closer to beating the baseline
than last time, and every numbered step must answer "which experiment, how far along" without
the reader jumping to another section. If story and experiments live in separate lists, rewrite.
