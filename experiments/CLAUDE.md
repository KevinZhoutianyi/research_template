# Experiment Rules

Re-read this before writing experiment code, training scripts, or analysis.

---

## 1. Code Style

### Focus on the core idea

All **code** must clearly contribute to the core idea of the program. Exclude code that is tangential or orthogonal — input sanitization, defensive type checks, edge-case handling — unless explicitly required. The exception is type annotations in Pydantic classes, which Pydantic itself relies on.

### Explanation is not code

The "minimalism" rule applies to **logic**, not to readability aids. Comments, docstrings, illustrative prints, and small example invocations help me understand what was written and why — keep them generously.

| What | Default |
|---|---|
| Logic (functions, branches, helpers, error handling) | minimal — must serve the goal |
| Explanation (comments, docstrings, example calls, log lines) | generous — they teach me what the code does |

### Section comments

Use sparingly to label major blocks (`=== Training ===`, `=== Evaluation ===`, `=== Main ===`):

- Format exactly as `=== <section> ===` with three equals signs on each side.
- No blank line after the section comment.

---

## 2. Correctness

Final code has zero tolerance for bugs. The solution is rigorous testing and verification, not just careful writing.

### Pydantic

Use Pydantic models instead of vanilla tuples for runtime type checking and clarity (`output.loss` over `output[0]`). Prefer frozen (immutable) models when possible.

### Pytest

Any code that can be unit-tested should be unit-tested with pytest. **Wait until I ask before writing tests**, but warn me about untested code — a project is not complete without rigorous testing.

### Code structure for instrumentation

Prefer simple control flow. Keep print statements / logging hooks easy to add later. Choose layouts that make instrumentation natural rather than awkward.

---

## 3. Experiment Visualization

Every experiment must have a `visualize.py` that generates figures a reader can understand **without reading code or configs**. The figures must show:

1. **Task description** — what the model is asked to do (e.g., "Which candidate is reachable from root?").
2. **Example inputs/outputs** — a concrete example with the graph, root, candidates, answer, and any intermediate reasoning targets (e.g., neighbor_k / latent token targets).
3. **Dataset stats** — split sizes, graph size, BFS depth, and any key structural parameters.

The goal: someone looking only at the figures should fully understand the task, the data, and what makes this experiment different from others.

---

## 4. Compute & Storage

### Clusters

| cluster | login | lab/personal storage |
|---|---|---|
| **Delta (NCSA)** | `delta.ncsa.illinois.edu` | `/data/latent_space_reasoning/` |
| **Endeavour (USC CARC)** | `ssh tzhou029@endeavour.usc.edu` (USC VPN) | `/project2/robinjia_875/tzhou029/` |

On Endeavour, redirect HF cache (home quota is small):
`export HF_HOME=/project2/robinjia_875/tzhou029/.cache/huggingface`

### Endeavour SLURM

Lab allocation `robinjia_875`: ~60 A6000 GPUs, 20 A100 GPUs.

| partition | use | GPU limit | notes |
|---|---|---|---|
| `nlp_hiprio` | default | 8 GPUs/student | priority on condo nodes |
| `nlp` | overflow | — | preemptible; checkpoint frequently |

| GPU | flag | when |
|---|---|---|
| A6000 (48 GB) | `--gres=gpu:a6000:1` | default |
| A100 (80 GB) | `--gres=gpu:a100:1` | only if model won't fit on A6000 |

Default resource request: `--cpus-per-task=8 --mem=32G`.
Check availability: `noderes -f -g -p nlp`.

### File storage

All large files (checkpoints, datasets, generated outputs, anything not committed to git) **must live outside the repo**. The repo is for code, configs, and small artifacts only (figures, summary CSVs).

Suggested layout (same on both clusters, under the cluster's base path above):

```
<base_path>/latent_space_reasoning/
  checkpoints/   # model weights saved during training
  datasets/      # raw and preprocessed data
  outputs/       # large generated outputs
```

---

## 5. Experiment Logging

Always include structured logging so runs are reproducible and inspectable from logs alone.

### Training-start summary

Print before the first epoch:

```
=== Training ===
model:      Llama-3-8B
dataset:    OpenWebText (10M tokens)
objective:  causal language modeling (cross-entropy)
lr:         3e-4 | batch_size: 32 | max_seq_len: 512 | epochs: 3
```

### Evaluation samples

Log a few input/generation/label triples per eval pass so behavior is visible at a glance:

```
=== Evaluation sample (3 of 128) ===
example 1:
  input:      "Translate to French: The cat sat on the mat"
  generation: "Le chat s'est assis sur le tapis"
  label:      "Le chat était assis sur le tapis"
```

### Config logging

Any hyperparameter that affects results must be logged before the run begins.

### Job monitoring

After submitting a SLURM job, **do not return control to the user and wait for them to ask about results**. Instead, sleep and poll `squeue` / log files periodically until the job finishes, then report the final results (val acc, train acc, probe figures, errors). The user should see the outcome without having to ask.
