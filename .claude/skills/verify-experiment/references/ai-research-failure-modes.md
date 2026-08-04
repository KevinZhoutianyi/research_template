# The seven ways an AI-assisted result goes wrong

Source: Lu et al. (2026), *Towards end-to-end automation of AI research*, Nature 651, 914-919
(doi:10.1038/s41586-026-10265-5), Limitations section, Figure 2, Supplementary A.2.9. Their system
was the first to get an AI-written paper through blind review, and the failure modes they catalogued
are the ones a human-in-the-loop workflow hits too. Reached here via
`imbad0202/academic-research-skills` (CC BY-NC 4.0); the taxonomy and the Lu citation are theirs, the
detection questions below are rewritten for this template's workflow.

Why a list rather than "be careful": **all seven produce output that looks like competent work.** A
number computed by buggy code reads exactly like a correct one. A Methods paragraph describing an
experiment nobody ran reads exactly like a faithful one. Reading the result harder does not
distinguish them; only checking the result against something outside itself does.

Answer every mode with a pointer to evidence outside the draft, or `INSUFFICIENT EVIDENCE`. That
verdict is a finding, not a pass.

---

## Mode 1: An implementation bug that passes self-review

Off-by-one, wrong variable, silent divide, wrong flag, a scale factor applied in the wrong place.
The code runs, the top-level number looks reasonable, and it goes into the paper.

- Does every number in the changed path trace to a saved `results.json` produced by a run that
  exited 0? Was the log read, or only the summary line?
- Is any effect size suspiciously round: exactly 0.5, exactly double the baseline, exactly zero
  variance across seeds? A constant leaking through a broken path lands on round numbers.
- Do error bars actually differ across conditions, or are they identical to more digits than the
  data could justify?
- For any derived quantity whose scale is set in one file and gated in another: is the scaling in the
  same expression that builds the quantity? A scale set in the producer and assumed in the consumer
  is where this mode lives, and it survives review because nothing looks broken.

## Mode 2: A hallucinated citation

A reference that does not exist, is miscited, or is credited with a finding it does not contain.

Covered by `doc/CLAUDE.md` §4: bib entries carry title + url + year with the author field left for a
human to fill from verified metadata, author names are never typed from memory, and an unverified
entry renders visibly as such in drafts. Also covered there: never call a human-supplied citation
fabricated on a single database miss, and name which sources were searched instead.

## Mode 3: A hallucinated experimental result

A number that no run produced: averaged differently than the paper says, taken from a crashed run,
or written to fit the narrative.

- For every "X% of", "N of M", and fold-change in the draft: which `results.json` key holds it, and
  does recomputing from that file reproduce it?
- Does a stated seed or sample count match the number of run directories that actually exist?
- Harder than mode 2, because there is no external database. The check is against our own logs.

## Mode 4: Shortcut reliance

The result is real, but it was produced by a route other than the one claimed.

- Is there a control that removes the most obvious alternative route, matched on everything else?
- Do the ablations vary the claimed mechanism, or incidental knobs around it?
- Is the baseline strong enough that beating it requires the claimed mechanism?
- If the response to an intervention is non-monotone in the intervention's size, a control measured
  at a different size is not a control. Match the size, and say so.

## Mode 5: A bug reframed as a novel finding

Mode 1 plus narrative: the unexpected output is a bug, and the write-up builds a story on it. The
paper reads *more* interesting than the correct version would have.

- Does the draft contain "surprisingly", "unexpectedly", "counterintuitively", or "contrary to our
  hypothesis"? For each: does any prior work predict the opposite? If nothing does, the surprise may
  be a defect rather than a finding.
- Did the surprising result appear on the first run, or only after debugging? First-run surprises
  carry the most risk.
- Was it reproduced from scratch, in a fresh process, from raw inputs?

## Mode 6: Methodology fabrication

The Methods text describes what a reasonable version of the experiment would look like, not what
ran.

- Does every setting named in the write-up (hyperparameters, data sizes, model ids, operating
  points, sample counts) appear in the run script or its config, checked by opening the file?
- Does the write-up describe a preprocessing or scoring step that cannot be pointed to in code?
- Does it use the past tense for anything that has not run? `doc/CLAUDE.md` §3 requires unrun work
  to be framed as a prediction with a falsifier and tracked as a next step, never as a result.
- **The check that catches it:** re-derive the mechanism from the data before writing prose about
  it, and quote a verbatim generation or sample from the run rather than reconstructing one. This is
  `doc/CLAUDE.md` §2a's rule, and this mode is why it exists: prose that runs ahead of the data can
  get a mechanism assignment backwards and survive many commits.

## Mode 7: Frame-lock

A commitment made early that later stages are structurally downstream of, so nothing later can back
out of it. The work ends up well-executed and answering the wrong question.

- Knowing what is known now, would the framing or the measurement be chosen the same way?
- Does the write-up contain "in hindsight" or "we realized later"? Those are frame-lock tells.
- Is the contribution better explained by the chosen framing, or in spite of it?

---

## Verdicts

Per mode, one of:

- **CLEAR**, with the evidence named in one line (a file, a log, a control that was run).
- **SUSPECTED**, when a question above returned a concerning answer. Report it before the numbers,
  not in a footnote.
- **INSUFFICIENT EVIDENCE**, when it cannot be ruled in or out from what exists. Modes 1, 3, 5, and
  6 landing here are blocking: they are exactly the modes that need artifacts outside the draft.

A `SUSPECTED` or blocking `INSUFFICIENT EVIDENCE` verdict goes in the report and in `tracking.md` as
a next step. It does not get resolved by rewriting the sentence more carefully.
