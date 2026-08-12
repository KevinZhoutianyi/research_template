# Style extraction from the exemplar papers

Distilled from the five PDFs in this folder; every quote is verbatim from the source.
Organized by dimension so a writer drafting one thing (a title, a caption, a table) reads one
section. When the extraction is not enough, open the PDF itself. Regenerate this file when the
PDF set changes.

The five exemplars, abbreviated below:

| tag | paper | style role |
|---|---|---|
| H2O | H2O: Heavy-Hitter Oracle for Efficient Generative Inference of LLMs (NeurIPS 2023) | systems/method paper: observation-first arc, named artifact |
| FOURIER | Pre-trained LLMs Use Fourier Features to Compute Addition (NeurIPS 2024) | mechanism-analysis paper: declarative finding titles, figures do the arguing |
| ROME | Locating and Editing Factual Associations in GPT (NeurIPS 2022) | causal-analysis paper: trace-then-intervene narrative, interpretive captions |
| LOOKBACK | Language Models Use Lookbacks to Track Beliefs (ICLR 2026) | causal-abstraction paper: hypothesize-then-verify arc, coined-mechanism vocabulary, prediction-first captions; the one ICLR exemplar, so the venue-format reference |
| LATENTMEM | LatentMem: Customizing Latent Memory for Multi-Agent Systems (arXiv 2602.03036, 2026) | agent-systems method paper: the opener-figure reference; its Figure 1 is a page-1 paradigm comparison (§5a) |

---

## 1. Titles

Three legitimate forms, one per exemplar; pick by what the paper is:

- **Named method + colon + benefit** (H2O): "H2O: Heavy-Hitter Oracle for Efficient Generative Inference of Large Language Models". The title names the artifact, not the finding.
- **The finding as a full declarative sentence** (FOURIER): "Pre-trained Large Language Models Use Fourier Features to Compute Addition". The title IS the one-line result; §3's title mirrors it.
- **Gerund pair naming the two halves of the work** (ROME): "Locating and Editing Factual Associations in GPT". Verb-driven, 7 words, names the object of study and the model family.

LOOKBACK is a second instance of the FOURIER form ("Language Models Use Lookbacks to Track
Beliefs"): subject + verb + coined term + task. Two of the exemplars now use the declarative
finding-sentence title, and both embed a coined mechanism name in it, which primes the term
before the abstract defines it. LATENTMEM is a second instance of the H2O form ("LatentMem:
Customizing Latent Memory for Multi-Agent Systems"): the named artifact, a colon, then a
gerund phrase naming what it does and for whom.

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
- LOOKBACK: an explicit hypothesize-then-verify split at the section level. §2 defines the
  coined mechanism abstractly (source/address/pointer/payload, before any experiment), §4 is
  titled "Hypothesized High-Level Causal Model of Belief Tracking" and states the algorithm as
  a causal model with "variables with structural roles that do not refer to the details of a
  transformer architecture", §5 is "Verifying the Hypothesized Causal Model": every §5
  experiment exists to localize one §4 variable. The paper says the contract out loud: "In
  Section 5, we will present experiments to verify that the causal model's variables align with
  representations in the transformer." §6 then perturbs the setting (visibility) and reuses the
  same machinery, a template for any mechanism section: state the mechanism first as a claim, then
  key each experiment to the variable it verifies.
- Formality is quarantined: informal definitions/theorems in the body explicitly tagged
  "(informal)" (H2O), numbered Definition/Remark environments in the appendix (FOURIER
  Appendix A, H2O Appendix D). Proofs always deferred. LOOKBACK defers full pseudocode of its
  causal model to an appendix ("Appendix G presents the full pseudocode") and keeps prose plus
  one schematic in the body.

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

LOOKBACK's abstract (~226 words, inside the H2O ceiling) opens with two questions ("How do
language models (LMs) represent characters' beliefs, especially when those beliefs may differ
from reality?"), then dataset, then the coined term with its inline definition ("a pervasive
algorithmic pattern that we call a lookback mechanism, which enables the LM to recall important
information when it becomes necessary"), then the mechanism narrated in its own vocabulary. A
question-opening abstract is a legitimate fourth shape; the numbers-near-the-end rule still
holds (its abstract carries no result numbers at all, like FOURIER).

## 3a. Introduction anatomy

Extracted paragraph by paragraph from all three intros; the agreement across them is the
check. An intro is 5-9 paragraphs of 1-8 sentences each (H2O: 9 paragraphs; FOURIER: 5;
ROME: 6), and the moves come in a fixed order:

1. **Problem, with one worked instance.** All three open on the problem and make it concrete
   within two paragraphs: H2O computes one cost example ("a 30 billion-parameter model with an
   input batch size of 128 and a sequence length of 1024 results in 180GB of KV cache");
   FOURIER quotes its running prompt ("Put together 15 and 93. Answer: ___"); ROME asks its
   question and grounds it ("The Space Needle is located in the city of" -> "Seattle").
2. **The gap.** Why the obvious or prior fixes fall short, as a triage of named alternatives
   (H2O sorts prior work into three failure modes; FOURIER contrasts prior small-model
   interpretability with pre-trained LLMs).
3. **The turn.** One pivot sentence from problem to solution ("Fortunately, our preliminary
   exploration has yielded intriguing observations...", H2O; "We use two approaches.", ROME).
4. **The approach, walked through evidence-first and keyed to sections.** The mechanism or
   observations narrated in order, each clause pointing at its section or figure ("In §3, we
   show that..." / "In Section 4, we present..."). The method IS NAMED here, always: "named
   heavy-hitters (H2)" then "we propose Heavy-Hitter Oracle (H2O)"; "Fourier
   features—dimensions in the hidden state that..."; "a Rank-One Model Editing method (ROME)".
   No exemplar leaves its method or central finding unnamed.
5. **Payoff or zoom-out.** Headline validation (H2O: models, hardware, 29x/29x/3x) or a
   two-sentence significance paragraph (FOURIER), calibrated per §3 above.

Numbers in the intro are rationed the same way in all three: the opening worked example, the
key evidence magnitude, and (H2O only) the closing headline results. ROME's intro carries ZERO
result numbers; the gap/turn/approach paragraphs are number-free in all three. A draft intro
dense with percentages in every paragraph does not look like these papers.

Figure 1 is referenced from the intro when it exists as a teaser (H2O three times, ROME three
times); FOURIER's intro references no figure. A contribution bullet list is optional (H2O has
a section-indexed one; FOURIER and ROME carry contributions in prose).

**The shape check, run on any draft intro:** (a) list each paragraph's move and match against
the five-move order above; (b) confirm the method/central finding is named, once, in move 4;
(c) count result numbers outside the worked example and the payoff paragraph: more than a
couple is a shape violation, not a style nit; (d) confirm exactly one turn sentence.

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
- **Prediction-first caption** (LOOKBACK): the caption leads with the causal model's prediction,
  then reports whether the intervention confirmed it, in one breath. Verbatim (Fig. 4): "The
  causal model predicts that if we alter the 'Answer Payload' of the original to instead take
  the value of the counterfactual answer payload, the output should change from coffee to tea;
  the gray curve in the line plot shows this does occur when patching residual vectors at the
  ':' token beyond layer 56, providing evidence that ...". This is the interpretive school
  sharpened for causal work: prediction, result, verdict, all inside the caption. The
  falsifier-first house rule maps onto it directly.
- Color/typography semantics are decoded inside the caption. Verbatim (ROME Fig. 6): "Prompts
  are italicized, green and red indicate keywords reflecting correct and incorrect behavior,
  respectively..."
- Uncertainty named where shown: "We show the mean and the standard deviation of the
  validation accuracy across 5 random seeds." (FOURIER Fig. 7b).

## 5a. The opener figure (LATENTMEM Figure 1)

LATENTMEM is the reference for the page-1 figure of an agent or method paper. Its Figure 1
sits beside the introduction, single-column, and is a paradigm comparison, not the method
pipeline; the pipeline is its Figure 2, arriving with §4.1 "Overall Pipeline". The two figures
divide the labor: Figure 1 sells the delta, Figure 2 explains the machine. Anatomy of
Figure 1, all verifiable on page 1 of the PDF:

- **Two panels side by side, prior paradigm left, theirs right.** Left is titled "Current MAS
  Memory" with a frozen-snowflake icon on a grey fill; right is "LatentMem MAS Memory" with a
  flame icon on a tinted fill. The fills carry the claim: grey means fixed and handcrafted,
  tinted means learnable.
- **The same skeleton on both sides.** The actors (Task, Agent1, Agent2, Agent3) appear in
  identical positions in both panels, so the reader compares only the middle mechanism: a
  "Token Space" holding "Handcrafted Memory Patterns" that emits a strip of identical token
  tiles, against a "Latent Space" emitting one distinct compact glyph per agent.
- **The claimed failure modes are drawn inside the prior panel.** Red warning annotations
  ("memory homogenization", "long-context memory") sit on the left panel, and each has a
  visually parallel fix on the right: identical tiles against distinct per-agent glyphs, a
  long tile strip against one compact glyph per agent. The intro's gap statement is inside
  the figure.
- **Arrows are labelled with their operation** ("Retrieve", "Context Injection", "Embedding
  Injection"); auxiliary inputs feed the mechanism as side boxes with dashed arrows
  ("External Memory Trajectory", "Agent Role Profiles"); a one-item inline legend decodes the
  coined glyph ("Latent memory").
- **Caption, verbatim:** "The paradigm comparison between existing multi-agent memory and
  LatentMem. Instead of relying on handcrafted memory units, LatentMem extracts agent-specific
  memories from the latent space by combining raw trajectories with agent profiles." The
  formula: name the comparison, then one "Instead of [prior mechanism], [ours does new
  mechanism]" sentence.

The visual language transfers along with the structure: rounded panels and boxes, tinted
panel fills (neutral grey for the prior paradigm, a cool tint with a dark border for ours),
centered bold serif panel titles, serif box labels, and the failure modes in bold red inside
the prior panel. Two departures from the exemplar: emoji icons (the snowflake, the flame) are
dropped because they do not render reliably in matplotlib, and box hues stay within the
colorblind-safe palette, with the single warm accent reserved for the learned object.

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
- Coined-vocabulary discipline (LOOKBACK): the paper mints a small closed lexicon (source,
  address, pointer, payload, ordering ID/OI, binding lookback, answer lookback, visibility
  lookback), defines each once in §2/§4, then uses the terms with total consistency through
  every section title, caption, and appendix; new experiments reuse the lexicon rather than
  minting more. The pattern: a term per role, never a synonym rotation.

## 9. What not to imitate

- H2O's typos ("Comparsion", "Quantatively") and its enthusiasm markers ("Surprisingly",
  "Fortunately", "It is obvious that"): the house style bans grading our own results.
- ROME's header direction arrows (see §6 above; house rule overrides).
- FOURIER's occasional grammatical slips in headings ("Does Fourier Features Generalize?").
