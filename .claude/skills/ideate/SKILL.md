---
name: ideate
description: Structured brainstorming and idea cards — when the user wants to brainstorm the next experiment or research direction ("我们讨论一下下一步", "有什么idea", "brainstorm"), or when Claude proposes an experiment idea in any conversation. Every proposed experiment is presented as an idea card (question, hypothesis with falsifier, minimal experiment, cost, decision options); free-form idea prose is not a proposal. Not for executing an already-agreed experiment.
---

# Ideation and Idea Cards

Two uses: a brainstorming session that ends in idea cards, and the standing format for
describing any experiment idea in chat. Both exist because a free-form idea paragraph hides
the three things a decision needs: what would falsify it, what the smallest test costs, and
what the alternatives are.

## The idea card

Every experiment idea, whether from a brainstorm or proposed mid-conversation, is presented
in this five-part form:

1. **Question** — one sentence, plain language, no coined terms. What we do not currently know.
2. **Hypothesis and falsifier** — what we expect and why (one or two sentences grounded in
   something observed: a transcript, a number, a prior result), then the falsifier stated as
   concretely as the prediction: "if X reaches Y under Z, the hypothesis is wrong". A
   hypothesis without a falsifier is a hope, not a hypothesis.
3. **Minimal experiment** — the smallest run that moves belief: dataset and split, the one
   variable changed, what is held fixed, the comparison that decides it. One variable per
   comparison; a design changing two things at once goes back to the drawing board.
4. **Cost** — wall-clock and compute in this project's terms (nodes x hours, or "CPU-only
   sbatch, ~2h"), and what it displaces (which running or planned work waits).
5. **Decision options** — 2-4 concrete labeled options with trade-offs (root CLAUDE.md:
   decisions are prompted as options), one of which is always "do not run it". Then wait; the
   card is a prompt for the user's call, not an announcement.

In chat, the card is a short section with five bold labels, not a wall of prose. Numbers in
the card that come from real files cite their source; guesses are marked as guesses.

## A brainstorming session

When the user opens a brainstorm (rather than reacting to one idea):

1. **Anchor.** Restate the project goal in one sentence and where we stand against it (the
   current headline result and its biggest weakness). Pull from `paper.md` and the experiment
   READMEs, not memory.
2. **Diverge.** Generate candidate directions across distinct kinds — at least one from each
   that applies: (a) a weakness in the current result (a confound, a missing control), (b) a
   gap the related work leaves open (check `related_papers/` notes, "Where it pressures our
   claims"), (c) a cheaper or harder version of what already works, (d) something the data
   already collected can answer without a new run.
3. **Converge.** Kill candidates that fail a one-sentence goal link, duplicate a planned
   experiment already in `paper.md`, or have no reachable falsifier. Rank survivors by
   information-per-cost.
4. **Cards.** Write the top 2-4 as idea cards and present them as the decision.
5. **Land.** The chosen card's minimal experiment becomes a (planned) row in the `paper.md`
   outline naming the section it serves. An unchosen card worth keeping gets one (parked) line
   there; the rest are dropped, not archived.

Done when: every idea on the table is either a card, a (planned)/(parked) line in `paper.md`,
or explicitly dropped, and the user has made the call (or the cards are in front of them
awaiting it).
