---
name: progress-report
description: Structure for any "where are we / how is it going / status" answer to the user. Invoke before drafting the reply — the report is framed around the goal, never around activity.
---

# Progress Reports Are Measured Against the Goal

When the user asks for status or progress (any "where are we" update, not a one-off factual
answer), frame the report around the goal, never around activity. Structure, in this order:

1. **Restate the goal in one sentence**, with the success criterion and how it is measured ("beat baseline B and competing method M on benchmark Z, K seeds, reported as mean successes / N").
2. **State progress against that goal** -- met / not met / partial, and *why* -- not a list of what you did. "We led once (+1.7) and tied once, both inside the noise band, so not yet demonstrated" beats "I ran two evals."
3. **Compare our method to the baseline AND to the other methods** side by side in one table (root CLAUDE.md rule 2: tables over prose).
4. **Report results that do not support us** plainly. A run where we tie or lose is part of the status and is never omitted or softened.
5. **End with the single next step that moves toward the goal.**

"What I did this round" is a separate, shorter section placed AFTER the goal status -- never the
headline.

Test: the first two sentences must tell the user whether we are closer to beating the baseline
than last time. If they only say what ran, rewrite.
