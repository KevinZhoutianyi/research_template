# Paper-writing lessons from author revisions

An author revision can change the scientific argument even when it looks like a rough
language edit. Before polishing it, identify the question the author is trying to make
readers ask, the explanation they want to develop, and the evidence that can support it.

These lessons come from revising an introspection paper in September 2026. The evidence
includes the author's abstract, introduction, methods, results, and conclusion rewrites,
requests for simpler language, figure preferences, and a comment asking for
random-intervention affirmative rates.
The explanations of why those edits matter are interpretations of the edits. They are
not quotations of the author's private reasoning or new experimental findings.

## 1. Recover the intended contribution before improving sentences

The earlier introduction centered a comparison: does removing a shared vector component
preserve more concept information than shrinking the whole vector? The author's rewrite
asked a broader explanatory question: what makes the model report an intervention, and
what lets it identify the injected concept?

That change affects the order of the evidence. Random perturbations become a test of what
the report responds to. Shared structure becomes a possible explanation for the remaining
concept-versus-random difference. Projection and remainder injections test how the two
components affect reporting and naming. Matched shrinking checks whether component size
explains the result. Silent steering then illustrates a use of the separation.

The lesson is to preserve the author's chosen question while checking the proposed answer.
A technically careful draft can still organize the paper around the wrong contribution.
Read the story document for the intended claim and the pipeline for what was actually
measured. Neither document substitutes for an explanation written for a new reader.

## 2. Turn the experiment sequence into a chain of questions

The author added questions about whether detection reflects the injected concept, any
perturbation, or a signal repeated across layers. Those questions explain why the controls
exist. Listing the controls alone leaves that reasoning to the reader.

| What the reader already knows | What remains unanswered | Comparison that addresses it |
|---|---|---|
| A model can report an injection and name its content. | Does combining those requests affect the measured report? | Separate report and naming questions; compare report questions with and without an identity request. |
| Reports and naming are scored separately. | Could a report respond to a perturbation without identifying a concept? | Compare concept vectors with matched random pushes. |
| A random perturbation can change reporting. | Does repeating a direction across layers matter? | Compare independent layerwise directions with one repeated direction at matched injected magnitudes. |
| Concept vectors produce stronger mean reports than the random reference. | Does structure shared across concept vectors contribute? | Construct a shared direction from training concepts and evaluate alignment on held-out concepts. |
| Alignment predicts reporting. | What changes when each component is injected by itself? | Inject the projection and remainder separately; measure reporting and naming. |
| Removing a projection reduces the injected magnitude. | Is the remainder's naming advantage just a magnitude effect? | Compare with the full vector shrunk to the same injected displacement. |
| The remainder retains candidate-name preference. | Does the model actually generate concept-related text? | Generate under neutral prompts and score the resulting text. |

In the manuscript, write the missing inference as a sentence. For example: an affirmative
report could reflect the perturbation itself, which motivates matched random pushes.
Adding a connective to an experiment list does not supply that inference. This explanatory
order also does not imply that exploratory analyses were planned before seeing results.

The author's later introduction makes the first distinction explicit before describing any
measurement: does the model detect that its state was perturbed, and does it identify the
semantic content of the perturbation? The next sentence states why the distinction matters:
an affirmative response can arise from either capability. Only then does the paper introduce
separate detection and identification measurements. This order gives the reader the problem,
the ambiguity, and the measurement that resolves it.

## 3. State the alternative explanation before introducing its control

A control is easier to understand when the prose first names the explanation it rules in or
out. The latest revision does this repeatedly:

| Observation | Alternative explanation | Test |
|---|---|---|
| Concept injection elicits affirmative reports. | The model may be responding to an unusual intervention rather than its semantic content. | Compare with displacement-matched random perturbations. |
| Alignment with a shared direction predicts reporting. | The association may not reveal what information the aligned component carries. | Inject the projection and remainder separately and measure both detection and identification. |
| The remainder preserves more target-name information. | Removing the projection also reduces intervention magnitude. | Compare the remainder with a full vector shrunk to the same displacement. |
| The remainder ranks the target highly. | A fixed candidate ranking may not change generated text. | Generate from neutral prompts and score whether the text is on topic. |

This pattern is stronger than procedural narration. "We next run a random control" says what
happens in the paper. "An affirmative report could reflect the perturbation itself" tells the
reader why that control is necessary and what its result can establish.

## 4. Explain a measurement through the problem it addresses

The author moved the motivation for fixed-choice scoring earlier. Free explanations mix
the behavior of interest with the ability to express an answer and with the judgment used
to score it. Reading answer probabilities reduces those expression and evaluation demands.
Separate naming questions also prevent the score for one response from requiring success
on the other.

Introduce that reason before notation. Then define the report score as the probability of
yes minus the probability of no, and explain how candidate names are ranked. Keep three
outcomes distinct throughout the paper: a detection report, preference among candidate
names, and text the model actually generates. A favorable name rank alone does not establish
generated identification or topic influence.

## 5. Choose statistics that answer the sentence the author wants to write

The author's Table 1 comment asked for the coherent-random yes rate so the paper could say
how often a random push makes the model report detection. A mean probability margin cannot
answer that frequency question. Two distributions can have the same mean and different
fractions above the affirmative threshold.

The revised table therefore keeps the mean score and adds an affirmative-rate column. In
this study, the random rate is 53.0% for Coder-32B and 93.7% for Llama-70B. These are means
of rates computed within eligible concepts, using valid draws, followed by equal weighting
across concepts. They are not percentages of every attempted draw. Only 10.13% of
Qwen-72B's random reads are valid, so that validity rate stays beside any rate computed from
the restricted subset.

The reusable rule is to work backward from the claim: frequency needs an outcome rate,
average preference needs a score, and a comparison needs the relevant baseline. State the
threshold, denominator, exclusions, and aggregation unit. Distinguish a percentage rate
from a percentage-point change and from a probability margin.

## 6. Let the abstract explain what was learned

The author's latest abstract follows an explanatory arc. It opens with the phenomenon, names
the abnormal-intervention confound, and asks whether semantic content and generic intervention
properties contribute differently to detection and identification. It then gives one concrete
concept-versus-random comparison before introducing the decomposition. The component ordering
answers the question, and silent steering states why the answer is useful.

That arc is more effective than an itinerary of wording tests, random controls, correlations,
component injections, and generation experiments. Each method appears only when it is needed
to understand a finding. The one numerical example anchors the central confound; the abstract
does not reproduce every cross-model rate or control.

Preserve that explanatory emphasis while checking the scientific description. Three kinds
of evidence do not automatically establish three additive components of a vector. A
coherent random control is a comparison, not a proven third component of each concept
vector. The abstract can state the distinct observed effects without claiming a complete
mechanism. Keep detailed controls and their numerical advantages where they support the
argument in the results.

## 7. Generalize the relationship that actually repeats

Cross-model evidence does not require every number or downstream effect to match. In this
study, the stable result is an ordering: across all six models, the shared projection produces
a stronger mean detection report, while the remainder gives a higher top-ten identification
rate. The size of the report reduction and the joint low-report, high-naming outcome vary by
model.

The revised paper states the repeated ordering first and places the exceptions beside the
claims they limit. It treats Qwen-72B as a limiting measurement case because coherent random
perturbations often invalidate its report readout, while retaining its complete results in the
appendix. This preserves the model in the study without making an unstable readout carry a
compact main figure.

The reusable lesson is to identify the invariant before writing "the result generalizes."
Generalize the comparison supported by every model, then describe model-specific effects at
their actual scope. Do not turn variation in one outcome into a vague claim that the whole
finding is inconsistent.

## 8. Use related work to locate the paper's exact question

The revised Related Work does more than group citations. Each paragraph ends by connecting a
literature to a design choice in the paper. Mechanistic interpretability motivates changing
representations and measuring what remains. Activation steering exposes intervention strength
as a confound, motivating matched displacement and generated-text checks. Introspection work
defines what prior studies already separated and leaves the structured-random and shared-
component questions for this paper.

This construction prevents two common failures. A citation catalog does not tell the reader
why the papers matter, while a list of shortcomings can misstate prior contributions. State
what the prior method establishes, then name the precise comparison that the present paper
adds.

## 9. Preserve the question while correcting an unsupported answer

Some author draft phrases express a hypothesis in compressed form. Completing them requires
checking the evidence, not silently treating them as established facts.

| Draft idea | What the evidence permits |
|---|---|
| Averaging strong-report vectors cancels concept information. | Averaging emphasizes shared structure. Whether semantic information remains requires measurement. |
| The remainder lets the model name the concept without detecting it. | State the naming measurement and the non-affirmative report. Neither proves absent internal detection. |
| Larger models rely more on anomaly detection. | Describe the observed model differences. A size explanation remains open when model family, training, and width also differ. |
| A direction controls detection. | An intervention can change reports without identifying the full computation that produces them. |

Place the limitation beside the inference it qualifies. Preserve the measured positive
finding. Several unrelated cautions at the end of a paragraph make the contribution harder
to recover and do not repair an earlier overstatement.

## 10. Make the action and its object explicit

The author asked what two polished sentences meant, then requested an easier version.
The difficulty came from an unclear referent and an overly strong necessity claim.

Earlier wording:

> Fluent explanations do not establish this connection. Testing introspection therefore
> requires connecting a model's report to a known internal change.

Clearer construction:

> A model can explain its answer fluently while leaving out factors that influenced it.
> One way to test whether its reports reflect its internal states is to change those states
> and check whether the model reports the change.

The revision names what may be missing, what is changed, and what is measured. It also
describes intervention as one test instead of the only possible test. For scientific prose,
prefer subjects and verbs such as we compare, the model reports, and removing the projection
changes the score. Replacing a difficult phrase with another abstract noun phrase rarely
solves the reader's problem.

Exemplar papers help with this reasoning: how an observation motivates a hypothesis, how an
intervention tests it, and how the conclusion follows. Their vocabulary and sentence lengths
are not a template to reproduce mechanically. Explicit author preferences take priority
over a fixed title form, paragraph count, or section order.

## 11. Make figures and tables carry a particular inference

The author wanted the overview figure to explain the injection setting, then the vector
decomposition, then the effects of injecting each component. This order gives readers the
prerequisites for interpreting the result. A removal-only plot would omit what the shared
projection does when injected by itself.

The author also retained side-by-side generated examples while keeping population rates
in prose and supporting tables. Examples answer what an effect looks like; rates answer
how often it occurs. Neither replaces the other. A compact baseline table remains useful
when it lets readers compare concept and random effects directly, even if larger numerical
tables belong in the appendix.

## 12. Let the conclusion reconstruct the explanation

The revised conclusion does not repeat the paper section by section. It first states the
component relationship, then names the two confounds that shape its interpretation: question
wording and coherent random perturbations. It follows the stable cross-model ordering with the
matched-magnitude result, the silent-steering application, and the amplified-remainder limit.
The final sentence states what the interventions do not establish.

A useful conclusion therefore mirrors the paper's inference rather than its chronology. State
the question answered, the evidence that changes the answer, the application enabled by that
answer, and the remaining boundary. A limitation belongs next to the claim it narrows; it
should not erase the measured result or appear as an unrelated disclaimer.

## 13. Treat collaboration as part of writing correctness

The author restored the title, asked for agent instructions to stay out of Overleaf, and
required revisions to begin with the latest Overleaf changes. These are boundaries on the
editing workflow. General permission to improve prose does not authorize a new title or
the replacement of a collaborator's argument.

Fetch the current shared manuscript, compare edits against the shared ancestor, and merge
the requested revision into the designated canonical files. Preserve unresolved comments;
remove a comment after addressing it. Keep agent instruction files in the research
repository. Recheck remote changes before publishing, verify the remote commit after the
push, and name the destination accurately. Updating a synchronization repository does not
by itself verify what appears in the Overleaf web editor.

## A short revision procedure

1. Read the author's draft, the story, and the experimental specification. Separate the
   intended question from provisional claims and language mistakes.
2. Write the main contribution in one sentence and map each paragraph to the question it
   answers. Preserve the author's sequence unless the evidence requires a stated correction.
3. Supply the missing reasoning between experiments before polishing individual sentences.
4. Check every result against its source, with the metric, model, population, and denominator.
5. Read continuously as someone new to the project. Check who acts, what changes, why the
   comparison is needed, and what follows from it.
6. Compile and inspect the rendered manuscript, including captions and nearby explanations.
7. Reconcile shared edits, push when authorized, and report the actual changes and destinations.

These are lessons from one collaboration. Apply the reasoning to a new paper's evidence and
author preferences; do not copy its model list, controls, numeric results, or section counts.

## Case record

The [author's September 16 draft](https://github.com/KevinZhoutianyi/introspection_residual_readout_overleaf/commit/768d2d7)
contains the earlier abstract and introduction changes and the Table 1 comment. The
[September 17 revision](https://github.com/KevinZhoutianyi/introspection_residual_readout_overleaf/commit/3842a54)
develops the two-question framing across the abstract, introduction, methods, results, and
conclusion. Compare each revision with its parent to distinguish the author's changes from
later completions. Title and synchronization preferences were explicit author instructions
in the same collaboration. The worked examples above illustrate writing choices; the project
manuscript and research records retain the full experimental definitions and evidence.
