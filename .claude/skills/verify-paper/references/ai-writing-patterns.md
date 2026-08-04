# AI writing patterns: what to change, shown at paragraph scale

`doc/CLAUDE.md` §1 Language bans a list of words and shapes, and `scripts/check_prose.sh` greps for
them. A word list tells you a sentence is wrong; it does not show you the rewrite. This file is the
rewrite half: the patterns that survive a word-level grep, each with a before and after at the
scale the damage actually happens, which is the paragraph.

Adapted from [Wikipedia:Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
(WikiProject AI Cleanup) via the `humanizer` skill (MIT). The pattern taxonomy is theirs; the
before/after pairs below are written in the register of an empirical paper, so the target voice is
the one `paper/example_papers/` sets rather than a Wikipedia voice.

Two rules govern every rewrite here:

1. **Every claim in the original survives.** Compressing is allowed; dropping a number is not.
2. **No new fact.** A rewrite may not introduce a number, name, or citation the source did not
   have. Replacing a vague claim with a specific one is allowed only when the specific number is
   already in the results.

---

## 1. Inflated significance

The tell is a sentence whose content is "this matters", added on top of a sentence that already
said what happened. `doc/CLAUDE.md` bans grading our own results; this is the same failure wearing
importance instead of praise.

**Watch for:** plays a key role, underscores the importance of, is a testament to, marks a shift,
represents a turning point, reflects broader, contributes to our understanding of, sets the stage
for, evolving landscape, indelible mark, deeply rooted.

**Before:**
> The magnitude-matched control marks a pivotal step in this line of work, underscoring the
> importance of strong baselines and reflecting a broader move in the field toward stronger
> controls. Against it, 74 of 99 cases clear.

**After:**
> Against the magnitude-matched control, 74 of 99 cases clear.

The claim about the field was not measured. Cut it, and the number moves to the front where it is
the whole point of the paragraph.

---

## 2. Superficial analysis with an -ing clause

A participial clause tacked onto a finished sentence to add depth. It reads as a second finding but
carries no measurement, and it is the single most common way a paragraph acquires a sentence that
`doc/CLAUDE.md` §1 Motivation-first would have rejected.

**Watch for:** `, highlighting`, `, underscoring`, `, emphasizing`, `, showcasing`, `, reflecting`,
`, symbolizing`, `, demonstrating`, `, contributing to`, `, suggesting that` when nothing was
tested.

**Before:**
> The first component fires the response on four of five models, highlighting its role as the
> trigger and reflecting the separability of the two mechanisms.

**After:**
> The first component fires the response on four of five models, and produces the second effect on
> none of them, 0 of 192 samples per model.

The -ing clause restated the section's thesis; the replacement is a second measurement. When the
clause cannot be replaced by a measurement, it gets a period and becomes a claim that must then
survive the reject-risk pass, or it gets cut.

---

## 3. Copula avoidance

An elaborate verb standing in for "is" or "has". It costs a word and buys nothing, and in a results
sentence it hides whether a definition or a finding is being stated.

**Watch for:** serves as, stands as, functions as, represents, constitutes, boasts, features,
offers.

**Before:**
> The matched control serves as the baseline that a genuine effect must exceed, and the first
> component represents the projection onto a shared direction.

**After:**
> The matched control is the baseline a genuine effect must exceed. The first component is the
> projection onto a shared direction.

---

## 4. Negative parallelism and tailing negation

"Not only X but Y", "it is not merely X, it is Y", and clipped negations bolted onto a sentence end
("no guessing", "no confound"). The construction promises a contrast and delivers emphasis.

A real contrast is not this pattern. "The relation holds on the measured items, not only on the
constructed ones" states which of two things was tested and stays.

**Before:**
> The effect is not merely a response to content, it is a response to magnitude. Same size, same
> direction throughout, no content present.

**After:**
> Part of the effect is a response to magnitude rather than to content: a single content-free
> direction, at the same magnitude, moves the measurement on every model.

---

## 5. Rule of three

Three items where the evidence supports two, or four. Not greppable; caught by counting. The test
is whether the third item was measured or supplied to fill the cadence.

**Before:**
> The decomposition is portable, interpretable, and constructible.

**After:**
> The decomposition reproduces the effect on held-out items, on all five models tested.

"Interpretable" was not measured. Two of the three words were a rhythm.

---

## 6. Synonym cycling

Rotating terms for one referent because repetition felt clumsy. In a paper it is worse than
clumsy: the reader cannot tell whether "component", "direction", and "axis" are one object or
three. `doc/CLAUDE.md` §2a fixes this for the central term; the rule applies to every named object.

**Before:**
> The first component fires the response. This direction is shared across items, and the trigger
> axis contributes little of the content.

**After:**
> The first component fires the response. The component is shared across items, and it contributes
> less content than a matched control does.

Pick one name per object, where it is defined, and never vary it for rhythm.

---

## 7. False range

"From X to Y" where X and Y are not endpoints of one scale. It sounds like coverage and states
nothing.

**Before:**
> Our analysis spans from the geometry of the representation to the behavior of the output.

**After:**
> We measure two things: the projection onto a shared direction, and the probability the model
> assigns the target token.

A range over a real scale is fine and stays: "32B to 235B parameters" has endpoints.

---

## 8. Authority tropes

Phrases that announce a deeper truth is coming, followed by an ordinary claim wearing ceremony.

**Watch for:** the real question is, at its core, fundamentally, what really matters, the deeper
issue, the heart of the matter.

**Before:**
> At its core, what really matters is whether the effect is causal. Fundamentally, this is a
> question about dependence.

**After:**
> The control tests dependence: does the effect depend on which item was used, or only on the fact
> that something was applied?

---

## 9. Aphorism formulas

"X is the Y of Z", "the language of", "the currency of", "X becomes a trap". A formula that turns a
measurement into a slogan and loses the number on the way.

**Before:**
> The representation is the canvas on which the output is painted, and magnitude is the currency the
> effect trades in.

**After:**
> The effect rises with the magnitude of the intervention, whether or not the intervention carries
> content.

---

## 10. Manufactured punchlines and staccato drama

A run of short fragments engineered to land. This one needs care, because `doc/CLAUDE.md` §1
Language mandates short declarative sentences: "X reaches 99.7%. Y fails at 63.3%." **That is the
house style and it stays.** The pattern to catch is different: short sentences that carry no
measurement, stacked for tone.

**Before:**
> Then the control was applied. No content. No recognition. Nothing left of the claim.

**After:**
> Against the control, 25 of the 99 cases fall inside it.

Test: does each short sentence carry a number or a named object? If yes, it is house style. If the
run of them is carrying only escalation, it is this pattern.

---

## 11. Hyphenated compound overuse

Uniform hyphenation, including after the noun. Keep the hyphen when the compound modifies a
following noun; drop it when the compound follows what it describes.

- Keep: "a matched-magnitude control", "the counterbalanced probe", "held-out items".
- Drop: "the control is matched magnitude", "the probe is counterbalanced".

---

## What not to flag

An aggressive pass is worse than none if it rewrites correct prose. None of the following is
evidence on its own:

- **Formal vocabulary.** The tells are specific words (§1, §8), not all long words. The field's own
  terms of art are the correct words.
- **A single "however".** Connectives are AI-coded only when stacked.
- **One short emphatic sentence.** See §10; this project mandates them.
- **Passive voice in a methods sentence.** Sometimes the passive is the right topic position.
  `doc/CLAUDE.md` prefers first-person plural, and the fix is usually "We measured", but a passive
  that puts the old information first is not a defect.
- **Repetition of a defined term.** See §6. Repeating a defined name a dozen times is correct;
  varying it is the defect.
- **Unhedged claims.** Confidence calibrated to the data is the rule (`doc/CLAUDE.md` §2), not a
  tell.

The signal is a **cluster**. One inflated verb means nothing; an inflated verb plus a rule of three
plus an -ing clause in the same paragraph means the paragraph was written for cadence and needs the
rewrite, not a word swap.

---

## How to run this

`scripts/check_prose.sh` greps the mechanical subset: §1, §2, §3, §8, and filler phrases. The rest
(§4, §5, §6, §7, §9, §10, §11) are read-checks with no reliable grep, and they are the reason this
file exists rather than a longer regex.

For each hit or read-check finding: rewrite at paragraph scale, then re-read the paragraph and ask
the two questions that make the loop converge.

1. What still reads as written-for-cadence rather than written-to-report?
2. Does the rewrite state any number, name, or citation the original did not have?

A yes to the second is a defect even when the rewrite reads better.
