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

**The body is ONE numbered walk through the story, where each numbered step is exactly one
sentence of the argument followed by a table of its experiments** -- never a story section
first and a separate experiment/plan list after (a reader then has to join the two lists
themselves; a real report review flagged exactly this split as the failure). Each step is:

> N. **<the argument sentence -- one sentence, nothing more>**
>
> | experiment | what it shows | progress |
> | --- | --- | --- |
> | <what is concretely DONE: who acts on what data under what setup> | <what this experiment establishes for THIS sentence> | <state + numbers so far, or "planned <when>"> |

One row per experiment serving that sentence; a step whose evidence is already settled gets
one row with progress "done" and the headline number. Prose beyond the one sentence goes
into the table cells, not around them.

**Both description cells are written for a reader with zero project context** (same standard
as the weekly update's plain-language rule; a live report was corrected on both cells):

- The *experiment* cell describes the procedure, not a run tag, and is SELF-CONTAINED: every
  row names the model(s), the benchmark and split ("AppWorld's 40 held-out test tasks", not
  "the tasks"), the repeat count, and the budget, even when the previous row already said
  them -- "the same model" / "同一模型" forces the reader to walk back up the table (a live
  report was corrected for this). "Sonnet naive, 100 steps" is a condition label the reader
  cannot decode; write "bare Claude Sonnet 4.5 solves AppWorld's 40 held-out test tasks
  alone, 3 seeds, up to 100 actions per task". Internal tags (cond names, run ids) never
  appear.
- The *what it shows* cell states the inference in plain words a non-specialist can repeat,
  tied to the step's sentence: not "floor anchor" but "how many tasks the agent solves with
  no help at all -- the number every other row must beat". If the cell needs a coined term,
  define it inline.

**A story beat is a sentence of the ARGUMENT, not a work category.** "Agents lose long tasks
to recurring process mistakes" is a beat; "Motivation" is a label. "The gain comes from the
lessons, not from being watched" is a beat; "main results" and "reviewer-requested baselines"
and "writing" are work categories -- a numbered list of those is a task list wearing numbers
(the second failure the same review flagged). If a work item supports no argument sentence,
it goes in the closing next-step line, not in the walk.

**Table rows are MEASUREMENTS only.** A row must measure something about the research claim
(a score, a gap, a count from run data). Engineering work -- a pipeline fix, a robustness
backstop, passing unit tests, a refactor -- is not an experiment and never gets a row (a live
report put "guidance backstop + 31 tests, done" in an experiment table and was corrected). If
the engineering matters to the story, it earns at most one clause inside the step sentence
("...method, whose learning loop is hardened against teacher-style variance"), or the step is
dropped entirely; a method step with no measurement rows usually should not be a step.

Structure, in this order:

1. **Restate the RESEARCH goal in one sentence** -- what the paper/report will claim and how
   it is measured ("show that lessons learned offline by a stronger teacher lift a frozen
   agent on held-out tasks, measured as bank beating both the bare agent and the empty-bank
   reviewer on K seeds"). The research goal, not the delivery milestone: "finish the final
   presentation with all baselines" is a deadline, and it goes in one clause AFTER the goal
   sentence, never in place of it (a live report opened with the deadline and was corrected).
2. **State progress against that goal in one or two sentences** -- met / not met / partial, and *why*. "We led once (+1.7) and tied once, both inside the noise band, so not yet demonstrated" beats "I ran two evals."
3. **The numbered story-with-experiments walk** (the body, rule above). Order the steps as the argument flows -- motivation, method, main evidence, mechanism, boundaries, cost -- and attach every running or planned experiment to the step it serves. An experiment serving no step either gets its own step (if it changes the story) or is cut from the report.
4. Condition-comparison numbers go in the step's table too (extra columns or rows), never as prose after it.
5. **Report results that do not support us** plainly, inside their step. A run where we tie or lose is part of the status and is never omitted or softened. Claim strength follows the statistical hard rules in `doc/CLAUDE.md` §2 "Statistical reporting" (single run, no strength claim; gap inside the spread, say so; mid-run counts are direction only, never a claim).
6. **End with the single next step that moves toward the goal**, plus anything only the user can do.

Test: the first two sentences must tell the user whether we are closer to beating the baseline
than last time, and every numbered step must answer "which experiment, how far along" without
the reader jumping to another section. If story and experiments live in separate lists, rewrite.
