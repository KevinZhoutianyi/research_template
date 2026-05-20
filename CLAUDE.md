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

**The `tracking.md` at the repo root is the canonical template.** Read it before starting, and copy its section structure and patterns into the live document for your project. The rules below describe *why* it's structured that way; the template shows *how* to apply them concretely. When you modify `tracking.md` for a real project, the patterns in the template (Q&A mechanism sections, evidence classification, discovery-arc narration, "what we do NOT claim" calibration, appendices) are not optional decorations — they are the rules in action.

Canonical structure (see `tracking.md` for fully-fleshed-out examples of each):

```
## Goal
  - Plain-language setup (3–6 sentences a non-specialist can follow)
  - Thesis (one sentence)
  - Prior work and what makes the question hard (with a theory-1 vs theory-2 table)

## Outline
  Subgoal-to-experiment table. Every subgoal names the concrete experiment(s) that achieve it.

## §N Subgoal: <name> (<status>)
  - **Claim:** one sentence stating what this subgoal proves.
  - **Evidence:** experiments under this subgoal, each tagged Central / Sanity check / Supporting.
  - **Context:** prior work positioning.

  Special pattern for §2 controls: include a "discovery arc" narrating how the
  controls developed (observation → naive control → loophole → refined control →
  discriminator), so readers see *why* the naive version wasn't enough.

  Special pattern for §3 mechanism: structure as explicit Q&A.
  Each Q maps to a subsection; each gets a one-sentence answer with citation.
  Synthesis recaps Q&A in a single table + names what we explicitly do NOT claim.

## Related Work
  Table of papers with columns: Paper | Relation to our work.

## Status (live)
  - Active runs (job ID, ETA, purpose)
  - Recently completed (finding, where integrated)
  - Recently failed jobs (failure mode, resolution) — so failures aren't re-attempted blindly
  - Next steps

## Reframing for slides
  Terse one-phrase-per-subgoal list; checks that slide story matches document story.

## Appendix A — Key terms
  Definitions of technical terms, so the body links here instead of defining inline.

## Appendix B — How to read the metrics
  Primary metric definition, common-confusion pre-empt, z-score formula.
```

Rules:
- Every subgoal states a **claim**, not just "test X." The claim is what we want the evidence to prove.
- Every experiment must live under a subgoal. If it doesn't trace back to the goal, ask why we're running it.
- When a run completes, update its entry under the relevant subgoal with the finding.
- Keep active run status (job ID, ETA) inline with the experiment bullet.
- External papers go in the **Related Work** table, not inline in subgoals. Subgoals contain our evidence; related work explains how others' results support or contrast with our claims.
- Distinguish **context** (prior work already solved this) from **our contribution** (we show this).
- **Mechanism sections should be Q&A, not lists of facts.** Each Q maps to one subsection and gets a one-sentence answer with citation. A reader scanning the section should be able to extract the mechanism claims from the Q&A alone.
- **Technical terms go in an appendix and are linked from the body.** Keeps the main narrative readable. Do not define terms inline more than once.
- **Document failures.** A failed-jobs table prevents the same broken approach from being re-attempted.

---

## 4. Rigorous Claims

`tracking.md`, slides, and paper drafts all argue for claims using evidence. Each claim must be calibrated to its evidence — not stronger, not weaker. The rules below catch the most common ways claims drift away from data.

### Calibrate claim strength to evidence

If the data supports the claim for 10/15 cases, write "for 10/15 cases" — not "the claim holds." If a finding is partial, say "partial." If a result depends on a single seed or a single setting, note the lack of robustness. If a claim depends on a deleted experiment whose data isn't currently in the repo, note that. Reviewers will find these gaps; flag them yourself.

### Classify each piece of evidence

For every entry in `tracking.md`'s **Evidence** section, classify it as one of:

- **Central** — discriminates the hypotheses. If theory 1 and theory 2 predict different outcomes and the data picks one, it's central evidence.
- **Sanity check** — confirms a basic phenomenon. Both hypotheses predict the same outcome here. The result tells us "the experimental setup is working" but not "which theory is right."
- **Supporting** — consistent with the claim but not a discriminator. Includes methodological controls (e.g., that the metric is well-formed), generalization tests, robustness checks.

State each piece's classification explicitly. Otherwise sanity checks get cited as if they were central evidence.

### Articulate both hypotheses' predictions before running a control

Before designing or running a control experiment, write down both hypotheses and what each predicts the result will be. If both predict the same thing, the control is a sanity check, not a discriminator — useful, but it doesn't push between hypotheses. Note this in the run.py docstring and in tracking.md.

This catches the failure mode of running a control, getting a result, and only later realizing it was consistent with everything you were testing.

### Caveats inline

Each result statement includes its methodological caveats inline:

- If a comparison is asymmetric (e.g., "max over 30 random seeds" vs "single concept extraction"), say so where you state the result.
- If a test is single-seed or single-setting, say so.
- If a finding depends on an exp that didn't fully complete (partial data, manual recovery from logs), say so.

### Audit downstream when deleting an experiment

When pruning an experiment from the repo, search `tracking.md`, slide decks, weekly updates, and paper drafts for downstream citations of its findings. Either:

- remove those citations, or
- demote them to a side-note that explicitly says "this finding lives in git history at commit `<hash>`, not in the current repo."

Otherwise the live document keeps citing data that the reader can no longer reproduce.

### Plain-language gloss

Any technical claim in `tracking.md`, slides, or paper drafts has a plain-English gloss within one paragraph. If a non-specialist reader can't restate the claim in their own words, the gloss is missing. Examples:

- "self-output prediction over a manipulated residual stream" → add: "the model is just running its normal next-token prediction on activations we tampered with — it doesn't notice the tampering, it just produces the output most consistent with whatever state we left it in."
- "z-score above the same-random distribution" → add: "the concept's measured value is more than 2 standard deviations above the random-vector baseline — i.e., not explained by random chance."

---

## 5. Git: Commit and Push

When adding a new experiment, updating tracking.md, or making any substantive change, **commit and push immediately** — don't wait for the user to ask. The user should never have to manually push.

---

## 6. Surgical Changes

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

## 7. Verify Each Step

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
