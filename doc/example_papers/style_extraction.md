# Style extraction from the exemplar papers

Distilled from the three PDFs in this folder; every quote is verbatim from the source.
Organized by dimension so a writer drafting one thing (a title, a caption, a table) reads one
section. When the extraction is not enough, open the PDF itself. Regenerate this file when the
PDF set changes.

The three exemplars, abbreviated below:

| tag | paper | style role |
|---|---|---|
| H2O | H2O: Heavy-Hitter Oracle for Efficient Generative Inference of LLMs (NeurIPS 2023) | systems/method paper: observation-first arc, named artifact |
| FOURIER | Pre-trained LLMs Use Fourier Features to Compute Addition (NeurIPS 2024) | mechanism-analysis paper: declarative finding titles, figures do the arguing |
| ROME | Locating and Editing Factual Associations in GPT (NeurIPS 2022) | causal-analysis paper: trace-then-intervene narrative, interpretive captions |

---

## 1. Titles

Three legitimate forms, one per exemplar; pick by what the paper is:

- **Named method + colon + benefit** (H2O): "H2O: Heavy-Hitter Oracle for Efficient Generative Inference of Large Language Models". The title names the artifact, not the finding.
- **The finding as a full declarative sentence** (FOURIER): "Pre-trained Large Language Models Use Fourier Features to Compute Addition". The title IS the one-line result; §3's title mirrors it.
- **Gerund pair naming the two halves of the work** (ROME): "Locating and Editing Factual Associations in GPT". Verb-driven, 7 words, names the object of study and the model family.

Section-title conventions, consistent across all three and with `doc/CLAUDE.md` §2a:
top-level sections are noun phrases ("Problem Setup", "Observations", "Empirical Evaluation");
finding-claims live one level down. FOURIER puts declaratives at the subsection level
("Fourier Features are Causally Important for Model Predictions"); ROME uses gerund-led
subsections ("Confirming the Importance of Decisive States Identified by Causal Tracing") and
colon subtitles where the head names the artifact and the tail the instrument ("Evaluating
ROME: Our COUNTERFACT Dataset"). All three use **bold run-in paragraph headings** below the
subsection level; in FOURIER many are themselves one-sentence findings ("LLMs progressively
compute the final answers.").

## 2. Paper structure

All three stage the argument the same way at the top level: setup, observation/trace, method
or causal test, evaluation, related work late, conclusion short.

- H2O: Intro -> Related Work and Problem Setting -> **Observations** (a dedicated section
  between setup and method; each observation gets bold run-in labels "Observation." ->
  "Insights.") -> Method -> Empirical Evaluation -> Conclusion. The intro pre-states the three
  observations as bold mini-findings that later become section titles, and its contribution
  bullets are section-indexed ("In Section 3, we explore...").
- FOURIER: mechanism sections run correspondence-then-causality: behavior (§3.1) ->
  observational probe (§3.2) -> causal ablation (§3.3) -> where the mechanism comes from (§4).
  Each results section opens with a roadmap paragraph carrying §-references.
- ROME: two parallel-titled halves encode the arc: "Interventions on Activations for Tracing
  Information Flow" then "Interventions on Weights for Understanding Factual Association
  Storage". A hinge subsection (§2.3) states the hypothesis and ends by posing the test; a
  late subsection closes the loop back to the trace (§3.4). Limitations is a numbered
  subsection inside the experiments section.
- Formality is quarantined: informal definitions/theorems in the body explicitly tagged
  "(informal)" (H2O), numbered Definition/Remark environments in the appendix (FOURIER
  Appendix A, H2O Appendix D). Proofs always deferred.

## 3. Abstract shape

Common skeleton (6-9 sentences): problem wide -> specific gap -> "In this paper / This paper
shows" -> the key observation or finding, with any coined term defined inline -> method or
mechanism in one sentence -> evidence, hedged exactly to its strength -> implication ->
(artifact URL). Numbers appear only near the end (H2O: "by up to 29x, 29x, and 3x"), or not at
all (FOURIER defers all numbers to the body).

Term-coining move, verbatim (H2O): "Our approach is based on the noteworthy observation that a
small portion of tokens contributes most of the value when computing attention scores. We call
these tokens Heavy Hitters (H2)."

Inline definition move, verbatim (FOURIER): "...add numbers using Fourier features—dimensions
in the hidden state that represent numbers via a set of features sparse in the frequency
domain."

Calibrated closing move, verbatim (ROME): "Our results confirm an important role for mid-layer
feed-forward modules in storing factual associations and suggest that direct manipulation of
computational mechanisms may be a feasible approach for model editing." ("confirm" for the
measured part, "suggest ... may be" for the extrapolation, in one sentence.)

## 4. Prose voice

- First-person plural "we" throughout; present tense for claims and analysis ("Figure 6
  shows", "We find"), past tense only for procedures ("We constructed").
- **Section openers state the goal, then a roadmap.** Verbatim (FOURIER §3): "In this section,
  we analyze the internal mechanisms of LLMs when solving addition tasks... We first show
  that... (§3.1). We then show that... (§3.2). Finally, we demonstrate through targeted
  ablations that... (§3.3)." ROME opens sections with a question: "We wish to test our
  localized factual association hypothesis: can storing a single new vector association using
  ROME insert a substantial, generalized factual association into the model?"
- **Hedging is graded to evidence.** Strong verbs for measured results ("demonstrate",
  "reveal", "confirm"); "posit", "hypothesize", "suggests", "leads us to hypothesize" where
  evidence is indirect. FOURIER's scope qualifier "primarily" appears in nearly every
  statement of its mechanism split. ROME grades novelty explicitly, verbatim: "The presence of
  strong causal states at a late site immediately before the prediction is unsurprising, but
  their emergence at an early site at the last token of the subject is a new discovery."
- **Objections are raised and answered in place.** Verbatim (H2O): "However, it is impractical
  to deploy such an algorithm because we do not have access to the future-generated tokens.
  Fortunately, we empirically observe that local H2 ... is equally effective." Verbatim
  (ROME, pre-empting a metric criticism): "We find that zsRE's specificity score is not a
  sensitive measure of model damage, since these prompts are sampled from a large space of
  possible facts."
- **Transitions turn the previous result into the next problem.** Verbatim (H2O): "The
  previous section showed the sparse nature of attention blocks in pre-trained LLMs, which
  provides the opportunity for designing small KV cache size... However, determining the best
  eviction policy that preserves generation accuracy presents a combinatorial challenge."
- One running example threaded through the whole paper and re-quoted verbatim at each reuse
  (FOURIER: "Put together 15 and 93. Answer: 108").
- Coined terms introduced once with "which we term X" / "We call these tokens X", then used
  everywhere including titles and table headers.

## 5. Figure captions

Two schools among the exemplars; this project follows the interpretive school (ROME/FOURIER),
which matches `doc/CLAUDE.md` ("captions open with the question the figure answers"):

- **Interpretive caption** (ROME, FOURIER): first sentence is a claim or scope statement, then
  a panel-by-panel walkthrough with (a)(b)(c) woven into prose, ending with the conclusion or
  a cross-reference to the contrast figure. Verbatim (ROME Fig. 2): "Average Indirect Effect
  of individual model components over a sample of 1000 factual statements reveals two
  important sites. (a) Strong causality at a 'late site' ... is unsurprising, but strongly
  causal states at an 'early site' in middle layers at the last subject token is a new
  discovery. (b) MLP contributions dominate the early site. (c) Attention is important at the
  late site. Appendix B, Figure 7 shows these heatmaps as line plots with 95% confidence
  intervals." Verbatim (FOURIER Fig. 6): "...there are no outlier Fourier components, in
  contrast with the clear outlier components in the fine-tuned model (Figure 3)."
- **Descriptive caption** (H2O): what is plotted, encodings and axes named, condition
  appended; the finding lives in body prose. Acceptable only when the body sentence referencing
  the figure states the finding immediately.
- Color/typography semantics are decoded inside the caption. Verbatim (ROME Fig. 6): "Prompts
  are italicized, green and red indicate keywords reflecting correct and incorrect behavior,
  respectively..."
- Uncertainty named where shown: "We show the mean and the standard deviation of the
  validation accuracy across 5 random seeds." (FOURIER Fig. 7b).

## 6. Table captions and conventions

- **The caption interprets the markup, with a worked example.** Verbatim (ROME Table 4):
  "Quantitative Editing Results. 95% confidence intervals are in parentheses. Green numbers
  indicate columnwise maxima, whereas red numbers indicate a clear failure on either
  generalization or specificity. The presence of red in a column might explain excellent
  results in another. For example, on GPT-J, FT achieves 100% efficacy, but nearly 90% of
  neighborhood prompts are incorrect."
- **The caption is a legend for non-obvious cells.** Verbatim (H2O Table 3): units in the
  caption "(token/s)", hardware named, every notation decoded ("'OOM' means out-of-memory").
- Caption formula: noun-phrase title + one sentence stating the finding or the fixed
  conditions (FOURIER Table 1: "Removing low-frequency components from attention modules
  (blue) or high-frequency components from MLP modules (red) does not impact performance").
- Conventions: baseline/unedited model as the first row; same decimal count down a column;
  CIs in parentheses next to each number (ROME) or noted absent; ROME uses per-column
  direction arrows in headers, but this project's house rule (`doc/CLAUDE.md` §4) overrides:
  direction goes in the caption in words, never as arrows.
- A plain-language translation of a metric can live in the caption. Verbatim (ROME Table 6):
  "Out of the unrelated facts that GPT-2 used to get right, how many are now wrong?"

## 7. Algorithm and method blocks

- Formal pseudocode is optional. ROME and FOURIER have none: ROME presents its method as three
  bold run-in steps, each an infinitive phrase stating the step's purpose ("Step 1: Choosing
  k* to Select the Subject." / "Step 2: Choosing v* to Recall the Fact." / "Step 3: Inserting
  the Fact."), each paragraph opening by linking to the motivating evidence, giving the
  procedure with one displayed equation, and closing with a practical detail or appendix
  pointer.
- When pseudocode is used (H2O Algorithm 1): placed beside the worked-example figure that
  illustrates it, reusing exactly the symbols of the body's definitions; an explicitly
  "formal and detailed version" lives in the appendix. The body walks through the algorithm
  via the figure ("We assume that the budget size of KV cache is 3. Following the completion
  of the fourth decoding step, the KV embeddings associated with the third token are
  evicted...").
- Equations can carry their own reading aids: underbraced term labels in the math itself
  (ROME Eqn. 4: "(a) Maximizing o* probability", "(b) Controlling essence drift").

## 8. Notation

- Just-in-time, prose-first, never a body notation table: "We represent each fact as a
  knowledge tuple t = (s, r, o) containing the subject s, object o, and relation r connecting
  the two." (ROME). Every symbol defined in running text at first use.
- Two-tier rigor: informal in the body with a pointer ("We provide formal definitions in
  Appendix A", FOURIER), numbered Definition/Remark environments in the appendix. H2O tags
  body definitions "(informal)" and follows each with a plain-English Remark.
- Simplifications declared, not hidden: "dependence on the input x is omitted for notational
  simplicity" (ROME); "For simplicity, we ignore the subscript N in the following paper"
  (FOURIER). Notation clashes disambiguated in footnotes ("Unrelated to keys and values in
  self-attention.", ROME).

## 9. What not to imitate

- H2O's typos ("Comparsion", "Quantatively") and its enthusiasm markers ("Surprisingly",
  "Fortunately", "It is obvious that"): the house style bans grading our own results.
- ROME's header direction arrows (see §6 above; house rule overrides).
- FOURIER's occasional grammatical slips in headings ("Does Fourier Features Generalize?").
