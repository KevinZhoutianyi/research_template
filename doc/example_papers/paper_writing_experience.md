# Paper-writing lessons from author revisions

An author revision can change the scientific argument even when it looks like a rough
language edit. Before polishing it, identify the question the author is trying to make
readers ask, the explanation they want to develop, and the evidence that can support it.

These lessons come from revising an introspection paper in September 2026. The evidence
includes the author's abstract and introduction rewrite, requests for simpler language,
figure preferences, and a comment asking for random-intervention affirmative rates.
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

## 3. Explain a measurement through the problem it addresses

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

## 4. Choose statistics that answer the sentence the author wants to write

The author's Table 1 comment asked for the coherent-random yes rate so the paper could say
how often a random push makes the model report detection. A mean probability margin cannot
answer that frequency question. Two distributions can have the same mean and different
fractions above the affirmative threshold.

The revised table therefore keeps the mean score and adds an affirmative-rate column. In
this study, the random rate is 25.6% for Coder-32B and 74.2% for Llama-70B. These are means
of rates computed within eligible concepts, using valid draws, followed by equal weighting
across concepts. They are not percentages of every attempted draw. Qwen-72B's 4.2% rate
comes from a restricted valid subset, so its 10.13% random-read validity stays beside it.

The reusable rule is to work backward from the claim: frequency needs an outcome rate,
average preference needs a score, and a comparison needs the relevant baseline. State the
threshold, denominator, exclusions, and aggregation unit. Distinguish a percentage rate
from a percentage-point change and from a probability margin.

## 5. Let the abstract explain what was learned

The author's abstract replaced much of the construction procedure with the roles of random
perturbations, a shared direction, and the remainder. The useful intent is to make the
finding easy to retell. A reader should leave knowing what the observations explain and
why that explanation matters, without reconstructing a sequence of analysis steps.

Preserve that explanatory emphasis while checking the scientific description. Three kinds
of evidence do not automatically establish three additive components of a vector. A
coherent random control is a comparison, not a proven third component of each concept
vector. The abstract can state the distinct observed effects without claiming a complete
mechanism. Keep detailed controls and their numerical advantages where they support the
argument in the results.

## 6. Preserve the question while correcting an unsupported answer

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

## 7. Make the action and its object explicit

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

## 8. Make figures and tables carry a particular inference

The author wanted the overview figure to explain the injection setting, then the vector
decomposition, then the effects of injecting each component. This order gives readers the
prerequisites for interpreting the result. A removal-only plot would omit what the shared
projection does when injected by itself.

The author also retained side-by-side generated examples while keeping population rates
in prose and supporting tables. Examples answer what an effect looks like; rates answer
how often it occurs. Neither replaces the other. A compact baseline table remains useful
when it lets readers compare concept and random effects directly, even if larger numerical
tables belong in the appendix.

## 9. Treat collaboration as part of writing correctness

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
contains the abstract and introduction changes and the Table 1 comment. Compare it with its
parent to distinguish the author's changes from later completions. Title and synchronization
preferences were explicit author instructions in the same collaboration. The worked examples
above illustrate writing choices; the project manuscript and research records retain the
full experimental definitions and evidence.
