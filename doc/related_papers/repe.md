# Representation Engineering: A Top-Down Approach to AI Transparency

Andy Zou et al. (21 authors), arXiv preprint (v4, March 2025; no venue found on arXiv or via
Semantic Scholar). arXiv: [2310.01405](https://arxiv.org/abs/2310.01405)

Status: read abstract + §2 (related work), §3 (LAT method), §4 (honesty results) from the PDF,
2026-08-08. DEMO NOTE for the skill test: the "our work" below is the template's fictional
retrieval-vs-memory example project. Matters to us as the standard citation for reading
concept directions from hidden states, the technique our PCA-on-hidden-states analysis is an
informal version of.

## Summary

The paper names and organizes "representation engineering" (RepE): studying and steering a
model through population-level representations (directions in hidden-state space) rather than
neurons or circuits. Its reading baseline, Linear Artificial Tomography (LAT), has three
steps: present paired stimuli that differ only in the target concept (e.g. "pretend you're an
honest / dishonest person"), collect hidden states at those tokens, and fit a linear direction
(typically the top principal component of activation differences) that scores the concept.
Its control baselines add or subtract such directions (contrast vectors) or fine-tune low-rank
adapters against representation-space losses (LoRRA). Applied to honesty on LLaMA-2 and
Vicuna models, reading the model's internal truthfulness concept instead of its output
likelihood raises TruthfulQA MC1 by 18.1 points over zero-shot, state of the art at the time,
and supports lie detection and honesty steering across scenarios.

## Relation to our work

The overlap: both read hidden-state directions to tell which internal source a model is using.
Their honesty experiments show a model's output can contradict what its internals represent
("models often know the true answer even when they generate incorrect outputs", citing Burns
et al. 2022) — that is structurally our claim that a model answers from memory while the
passage says otherwise.

Deltas:

1. They read a general concept (truthfulness, honesty) elicited by role-play stimuli; we read
   a source attribution (passage vs. parametric memory) elicited by giving or withholding the
   retrieved passage. Our contrast is between input conditions, theirs between instructed
   personas.
2. They steer behavior with the extracted direction (contrast vectors, LoRRA); we only
   diagnose. If our ignore-rate result holds, their control methods are the natural follow-up
   experiment: subtract the memory direction and test whether passage-following recovers.
3. Their evaluation target is a public benchmark (TruthfulQA); ours is a constructed
   popularity split where passage and memory disagree by design, so we can score source use
   directly instead of inferring it from truthfulness.

## Where it pressures our claims

- "Hidden states separate by condition" (our PCA figure) cannot be presented as novel; LAT is
  the established, stronger version (supervised direction, causal validation by steering). Our
  novelty must rest on the retrieval-vs-memory contrast and the popularity split, not on the
  reading technique.
- Their TruthfulQA result shows internal-representation readouts can beat output-based
  scoring by large margins, which pressures any claim of ours that output answers alone
  measure what the model "knows" — our ignore-rate is an output measure and should say so.

## Key facts to cite

- LAT pipeline: stimulus pairs differing in the target concept -> hidden states -> linear
  (PCA-based) direction; figure 4 of the paper walks the honesty example.
- Unsupervised honesty reading raises TruthfulQA MC1 by 18.1 points over zero-shot, SOTA at
  publication, on LLaMA-2 chat models (their Table 1; means and stds in their Table 8).
- Distinguishes imitative falsehoods (repeating misconceptions) from hallucinations, citing
  Lin et al. 2021 for the former; TruthfulQA targets the imitative kind.
- Positions itself against circuits-level interpretability: representations, not neurons or
  circuits, as the unit of analysis.
- 56-page arXiv preprint with code at github.com/andyzoujm/representation-engineering; no
  peer-reviewed venue found as of this read.
