# Programming Guide

## About Me

<!-- Update this section with your name, role, and research focus. -->
- I [YOUR NAME] am a PhD student doing ML research at [INSTITUTION].

## Programming Philosophy

The purpose of all code is to serve as educational material for the *student reader*. The student reader is someone who is reading the code for the sake of learning the concept implemented therein. To aid in teaching the student reader, all code should be simple, straightforward, and structured so as to be as easy as possible to parse and understand on all levels. To meet this pedagogical goal, adhere to the following guidelines:

### Focus on the core idea

All code should clearly contribute to the core idea of the program. Exclude all code which is tangential or orthogonal to the core idea. For example, if you are writing a program to calculate the factorial of a user input, focus on writing the factorial function itself above all else. Do not include code which deviates from the core idea to do things such as sanitize inputs, annotate types, catch edge case errors, etc. This is an opinionated take, but it is an important part of my focus on simplicity and core ideas. The only exception to this is type annotations in Pydantic classes, which absolutely should be included when Pydantic expects it. Read more about Pydantic in the Correctness section later.

### Name variables well

It should be clear at a glance what the purpose of a variable is. The student reader should be able to follow the code easily, which means variable names should not include abbreviations but should also not be excessively long either. When in doubt, think about what is easiest on the eyes and brain of the student reader.

### Use comments for the benefit of the student reader

As the student reader reads the code, there is lots of information that would help their learning process that isn't immediately apparent from the code itself. This is where comments come in. The following are the main categories of comments to include:

### Performance improvements

High performance code can sometimes be complex and difficult to parse, which goes against the ideal of teaching the student reader. When you encounter this situation, first think about how you can write code which is both elegant and performant. But in cases where there is a true, unavoidable tradeoff, prefer the simplest approach but note that this code has room for performance improvements and how to go about implementing them. These comments need not be long explanations, just enough to teach the student reader something about where they can go next.

**format:** `NOTE: [performance improvement] <content>`

### Thought process explanations

The code you write will be a result of a detailed thought process which is not self evident to the reader. Whenever this thought process presents a learning opportunity, take advantage of it and explain to the student reader why something is the way it is. They may not have thought about things this way before, or they may have a different opinion about what to do. Regardless, the reader can benefit from certain non-obvious insights into the decision making process.

**format:** `NOTE: [thought process] <content>`

### Pedagogical information

This is a core avenue for teaching the student reader. When there are opportunities to use advanced techniques to make code better in some way (often simpler, less memory-intensive, etc.), use these techniques and call them out to the student reader. In addition, there might be non-obvious side effects or mathematical insights behind certain pieces of code. Whenever it may benefit the student reader and it isn't clear from the code, call out pedagogical insights explicitly with a comment.

Here's a great example of this from a python program:

\# NOTE: [pedagogical] CrossEntropyLoss combines log-softmax and negative log-likelihood
\# in one step. It expects raw logits (not softmax outputs), which is why the model's
\# final layer has no activation function.

**format:** `NOTE: [pedagogical] <content>`

### Shape explanations

The shape of tensors is of importance to the ML code you will be writing. If at any point you reference the shape of a tensor, make a callout explaining what concept this refers to. For example, .size(0) might represent the batch size, and it's important to explain this with a comment. Additionally, any time broadcasting is occurring it is important to explain the two shapes and how the broadcast happens. \*, @, and other possibly confusing shape-involved operations should be explained too.

**format:** `NOTE: [shape] <content>`

### Flagging possible edge cases

As mentioned before, it's important not to bog down code with edge case error handling because it distracts from the core idea. However, these edge cases can still be important. To call attention to these for teaching purposes and possible future handling, add a comment explaining what they are.

**format:** `NOTE: [edge case callout] <content>`

### Optimize the layout of code for the student reader

The layout of code should be simple to follow above all else. This means the control flow should be easy to follow, but also the code should be easy to follow with the eye. For example, a function which only runs once during initialization could be written out inside the main function instead of factored out into its own function. This isn't always obvious, so always use your best judgement to determine what would most enhance the learning experience of the student reader. Just keep in mind that function calls can be opaque.

## Style nitpicks

### Section comments

- Add a small number of section comments to the extent that they enhance readability for the student reader. For example, `=== Training ===`, `=== Evaluation ===`, and `=== Main ===` in a model training program. Do not overuse these, and if you include them adhere to the following guidelines:
    - Format them exactly as `=== <section> ===` with the three equals signs on either side. This is for consistency.
    - Do not leave any blank lines after the section comment

### Prefer tables over prose for structured data

When reporting results, configs, comparisons, or any structured information, use a markdown table instead of bullet points or paragraphs. Tables are easier to scan and compare at a glance. This applies to written reports, `tracking.md` entries, and printed experiment summaries.

## Compute Environments

I work across two clusters. Key differences are noted below.

### Delta (NCSA)

- Login: `delta.ncsa.illinois.edu`
- Default storage for large files: `/data/PROJECT_NAME/`

### Endeavour (USC CARC)

- Login: `ssh tzhou029@endeavour.usc.edu` (requires USC VPN)
- Lab allocation: `robinjia_875` (~60 A6000 GPUs, 20 A100 GPUs)
- Personal lab space: `/project2/robinjia_875/tzhou029/`
- Redirect HF model cache (home quota is small): `export HF_HOME=/project2/robinjia_875/tzhou029/.cache/huggingface`

**Partitions:**

| partition | use | GPU limit | notes |
|---|---|---|---|
| `nlp_hiprio` | default | 8 GPUs/student | priority access on condo nodes |
| `nlp` | overflow | — | preemptible; checkpoint frequently |

**GPUs:**
- A6000 (48 GB): `--gres=gpu:a6000:1` — default choice
- A100 (80 GB): `--gres=gpu:a100:1` — use only for large models that won't fit on A6000

**Default resource request:** `--cpus-per-task=8 --mem=32G` — don't over-request shared node resources.

**Check node availability:** `noderes -f -g -p nlp`

## File Storage

All large files — model checkpoints, datasets, generated outputs, and anything that should not be committed to git — must be stored outside the repo. Use the repo only for code, configs, and small result artifacts (e.g. figures, summary CSVs).

**On Delta:** save under `/data/PROJECT_NAME/`

**On Endeavour:** save under `/project2/robinjia_875/tzhou029/PROJECT_NAME/`

Suggested layout (same on both clusters):
```
<base_path>/PROJECT_NAME/
  checkpoints/   # model weights saved during training
  datasets/      # raw and preprocessed data
  outputs/       # large generated outputs (e.g. decoded sequences, embeddings)
```

## Weekly Update Presentations

When asked to prepare a weekly update, produce a Beamer LaTeX presentation saved under `notes/weekly_updates/YYYY-MM-DD/slides.tex`. All images used in the slides must be copied into the same folder so the entire folder can be uploaded to Overleaf as-is.

After each presentation, record feedback and the resulting plan in `notes/weekly_updates/YYYY-MM-DD/feedback.md`. This file should contain:
- **Feedback from presentation**: what the audience flagged, suggested, or pushed back on — written with enough context to be useful weeks later.
- **Plan going forward**: a table of planned experiments (model × dataset × task × prediction) that follows from the feedback.

### Structure

- **No title slide** — the audience already knows the project and the presenter.
- Cover these topics in order, skipping anything the audience already knows as prior work:
  1. Dataset / setup context (what data, what model, how they differ from prior work)
  2. Core theoretical claim
  3. Current experimental results
  4. Open questions to discuss with collaborators
  5. Next steps with a table showing model × dataset × task × prediction

### Slide density

Prefer more slides with less content per slide. The audience is student researchers — each slide should communicate one idea clearly. Do not pack multiple concepts, results, and implications onto one slide. If a slide feels crowded, split it.

### Style

- Tables over prose for all structured comparisons.
- Use `\color{green!60!black}` / `\color{red!70!black}` for Works / Fails predictions in tables.
- No `\titlepage`, no author/institute slide.

## Session Tracking

Maintain a `tracking.md` file in the root of the repository. At the start of every working session, add a new entry. This file is the running log of all research activity and should make it easy to pick up exactly where you left off after any break.

Each entry should include:
- The date and time the session started
- A brief summary of what was worked on
- A status table covering **all active and recently completed runs** — see required columns below
- Any findings, surprises, or next steps

The status table must have these columns:

| experiment | method | task | epoch | stage | val acc | status | ETA |
|---|---|---|---|---|---|---|---|

- **experiment**: directory name (e.g. `01_superposition`)
- **method**: model + key hyperparams (e.g. `Coconut (bs=128, lr=1e-4)`)
- **task**: one-line description of what the model is predicting
- **epoch**: `current/total` (e.g. `167/300`)
- **stage**: curriculum stage if applicable
- **val acc**: latest validation accuracy as `correct/total = %`
- **status**: `running (GPUs X,Y)`, `complete (date)`, `not started`, `crashed (reason)`
- **ETA**: estimated finish time in UTC, calculated from recent epoch timing

Keep this table current — update it at the start of each session and whenever status changes. Always include ETAs for running experiments.

Example:
```markdown
## 2026-03-26 04:50

**Focus:** Large-batch training; resumed after SIGHUP

**Active runs:**

| experiment | method | task | epoch | stage | val acc | status | ETA |
|---|---|---|---|---|---|---|---|
| 01_foo | MyModel (bs=128, lr=1e-4) | classification | 167/300 | 4/4 | 238/258 = 92.2% | running (GPUs 0,1) | Mar 27 ~18:30 UTC |

**Next:** Start 02_bar once 01_foo finishes.
```

## Experiment Logging

When writing experiment code, always include structured logging so results are reproducible and interpretable.

### Training logs

At the start of training, print a summary of the key details:
- The dataset being used (name, size, any preprocessing)
- The training objective (e.g. cross-entropy, RLHF reward, contrastive loss)
- The model being used (architecture name, size, any modifications)
- Key config values (learning rate, batch size, max sequence length, number of epochs, etc.)

Example format:
```
=== Training ===
model:      Llama-3-8B
dataset:    OpenWebText (10M tokens)
objective:  causal language modeling (cross-entropy)
lr:         3e-4 | batch_size: 32 | max_seq_len: 512 | epochs: 3
```

### Evaluation logs

During evaluation, log each example in a human-readable format so you can inspect model behavior at a glance. Print a few sample examples (e.g. the first 3-5 in the batch) showing the input, generation, and ground truth label.

Example format:
```
=== Evaluation sample (3 of 128) ===
example 1:
  input:      "Translate to French: The cat sat on the mat"
  generation: "Le chat s'est assis sur le tapis"
  label:      "Le chat était assis sur le tapis"
```

### Config logging

Any hyperparameter or config value that affects results should be logged before the run begins. This makes it easy to reproduce a run from logs alone.

## Correctness

The work that I do has zero tolerance for bugs in final code. The solution to this is not to avoid writing bugs in the first place but rather to rigorously test and verify code.

### Pydantic

Use Pydantic models instead of vanilla tuples. This allows for runtime type checking and clarity. `output.loss` is much more meaningful than `output[0]`. Prefer immutable (frozen) models wherever possible to sidestep errors caused by mistaken reassignment.

### Pytest

Any code that can be unit tested should be unit tested. Use pytest to do this. Wait until I ask to write tests, but warn me about untested code and understand that a project is not complete if it doesn't include rigorous testing.

### Code structure

Code should be written so that adding instrumentation is easy and clear. Prefer simple control flow and keep in mind what print statements might be useful. This shouldn't affect code layout a ton, but just keep it in mind whenever there are clear layout wins that aid potential instrumentation.
