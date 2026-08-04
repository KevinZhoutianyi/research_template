# Sentence scaffolding for the abstract and the introduction

`doc/CLAUDE.md` §1 Style and `SKILL.md` §4 fix the *structure* of these two sections: the abstract
stays under 10 rendered lines and carries the thesis, two or three headline numbers, and the scope;
the introduction has no subsections, runs as flowing prose, and ends in a numbered contributions
list. What neither that file nor the `/verify-paper`
checklist supplies is the sentence layer: which sentence goes where, and what shape it takes.

Adapted from `Master-cai/Research-Paper-Writing-Skills` (MIT), which repackages Peng Sida's
(彭思达) writing notes. The source is written for method papers, where the contribution is a module
and the target is a benchmark number. The skeletons below are generalized so they also fit an
explanation or analysis paper, where the contribution is an account of an existing phenomenon and the
target is what produces a behaviour. Substitute the project's own subject matter when filling one.

Skeletons are scaffolding for a draft, not a template to submit. Fill one, then delete the seams:
identical sentence openings across paragraphs are a tell, and `doc/CLAUDE.md` §1 Language governs
the final wording regardless of what a skeleton suggested.

---

## Before writing either section

Answer these four in plain sentences, and do not start drafting until all four have answers. If
answer 1 is not a specific problem and answer 3 is not a mechanism, the draft will drift.

1. What problem or phenomenon do we address, and why does the existing account not settle it?
2. What is our claim, in one sentence a reviewer could falsify?
3. Why does it hold, mechanically, not just correlationally?
4. What does a reader know afterwards that they could not have predicted?

`doc/CLAUDE.md` §2a already forbids polishing prose over an unsettled thesis. These four questions
are the settling.

---

## The abstract

Three shapes. Pick by what the paper's spine actually is; do not mix two.

### Shape A: problem, then solution or decomposition

1. The problem or phenomenon, stated as something a reader can picture.
2. The scope of the work (datasets, models, sizes, settings).
3. What prior accounts get wrong or leave out, with its number.
4. What we contribute, split into its parts, with a number per part.
5. How the parts compose, with the headline number.

### Shape B: problem, insight, mechanism

When one idea unlocks the whole result and the reader needs it before the parts make sense.

1. The problem and its scope.
2. What prior work leaves unresolved, and the technical reason.
3. The insight, in one sentence, no implementation.
4. What the insight makes possible or measurable.
5. The evidence, with the headline number.

### Shape C: several contributions

When there are two or three independent results and no single spine. Each gets one sentence carrying
**the finding and what it rules out or enables**, never the finding alone.

1. The problem and scope.
2. Contribution 1 + what it buys.
3. Contribution 2 + what it buys.
4. Contribution 3 + what it buys.
5. The scope limit.

Sentence-level rules for all three shapes:

- The first sentence names this paper's specific subject. If it could open any paper in the area,
  cut it. Banned openings: "Large language models have achieved remarkable success", "In recent
  years", "Deep learning has revolutionized".
- A named component appears with its name only, no mechanism. The mechanism belongs in the intro.
- No sentence carries two messages.
- Every claim here is one a body section measures. An abstract claim without a section behind it is
  the fastest way into `/verify-paper` §5's contribution row.

---

## The introduction

The order to think in is backwards; the order to write in is forwards.

**Think backwards** (answer before drafting):

1. What is the problem, and why is there no settled solution?
2. What do we contribute: a new task, a new metric, a new mechanism, a new control, or a new
   instrument?
3. Why does it work mechanically, and what does that let a reader predict?
4. Which prior results does the reader need in hand before our claim lands?

**Write forwards:**

```
Para 1   The problem or phenomenon, and that it is open, with citations.
Para 2   How prior work approaches it, concretely enough that the reader sees the setup.
Para 3   What that leaves unsettled, and the technical reason it does.
Para 4   Our approach, and how the paper is organized around its steps.
Para 5   The definitions we adopt, from whose criteria, and which one each result addresses.
Para 6   Numbered contributions.
Para 7   The limits, stated at the front.
```

### Paragraph 1: the problem and the open question

- `Whether [X], in the sense of [operational gloss], remains an open question.`
- `[Behaviour or result] has been read as evidence of [interpretation].`

Two rules: the operational gloss comes immediately, in the same sentence, because a reader who does
not know what X means operationally cannot judge anything that follows. And a phenomenon is stated as
a behaviour, not as a capability, until the paper has earned the capability word.

### Paragraph 2: how prior work approaches it

- `A line of recent work approaches this with [the setup].`
- `Take [the object], [do the operation], and [measure the outcome].`
- `Without [the intervention] the system typically [baseline]; with it, [effect].`

State the prior setup at the level of what was actually done. Describing it fairly and concretely is
what makes the gap in paragraph 3 land; a prior setup summarized vaguely makes the gap look like a
strawman, which is `/verify-paper` §5's soundness row.

### Paragraph 3: the gap, and its technical reason

- `Our question is what produces [the observation].`
- `[Prior work] omits that control.`
- `This looks like [interpretation], and it has been read as [claim]. But [gap].`

The important rule from the source, and the one most easily violated: **do not open with a naive
version of your own solution and then improve on it.** That shape makes the work read as an
increment on something obvious, even when it is not. State the gap; let the solution arrive as a
solution.

A gap has two halves and needs both: the observable limitation ("prior work omits the control") and
the technical reason it matters ("any intervention at that magnitude moves the measurement, so the
result alone is not evidence of the mechanism"). A limitation without a reason reads as a complaint.

### Paragraph 4: our approach

- `We explain it as [structure], doing [N] jobs in [relation].` (analysis paper)
- `We propose [name], which [what it does].` (method paper)
- `The account has [N] steps, and the paper is organized around them.`
- `The first is to [step 1] (§X). The second is that [step 2] (§Y).`
- `The order matters: [what the sequence adds over the sum].`

This is the paragraph where §-pointers are earned. `doc/CLAUDE.md` §1 bans meta-narrative ("as we
shall see", "the rest of this section"), and that ban holds; a `(\S\ref{...})` attached to a claim is
a citation of where the evidence lives, not narration of the document's own shape.

For a novel setup with no direct prior method, the alternative is to decompose the difficulty
instead: `This is challenging for [N] reasons. First, ... Second, ... Finally, ...`, each with its
observable limitation and its technical reason.

### Paragraph 5: the definitions

- `We adopt the [definition] from \citet{...}, who call [X] [Y] when it meets [N] criteria: ...`
- `We work at this level throughout and do not take up [the further question].`

Naming whose criteria, and declining the question we are not answering, is what keeps
`/verify-paper` §5's soundness row from opening. `doc/CLAUDE.md` §2a requires the central term be
defined by the source literature's own criteria and referred to the same way throughout.

### Paragraph 6: contributions

One bullet per claim, each `\textbf{}` lead naming the claim, then the numbers. Rules:

- A contribution is falsifiable. "We evaluate on six models" is a description of activity; "the
  effect holds on six models from four families, and each needs its own operating point" is a claim.
- The numbers go in the bullet. A bullet pointing at a section for its evidence is one sentence
  short.
- Two to four bullets. Five means two of them are the same claim.
- A negative result is a contribution when it rules something out, and it gets the same treatment as
  a positive one.

### Paragraph 7: the limits

- `Two limits are worth stating at the front.`
- `[Limit 1, stated as fact, with its number.] And [limit 2].`

`doc/CLAUDE.md` §1 puts caveats inline after the result they qualify and bans standalone Limitations
subsections inside experiment sections. This front-loaded paragraph is the intro's own version:
limits on the *paper's* scope, not on an individual measurement. It also pre-empts the reviewer
question it would otherwise invite, which is why it goes at the front rather than the end.

---

## Checks before the section is done

1. Does the first sentence of every paragraph state that paragraph's message, so that reading only
   those sentences gives the argument? (This is the reverse outline in `SKILL.md` §1b, applied to
   the intro.)
2. Does each paragraph carry one message?
3. Are the gap, its technical reason, and the mechanism that closes it all explicit?
4. Is every abstract and intro claim measured by a body section?
5. Is terminology identical to the body's?
6. Would this read as a strong opening inside one of the PDFs in `paper/example_papers/`?
