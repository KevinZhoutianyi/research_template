# Experiment Rules

Re-read this before writing experiment code, training scripts, or analysis.

## 1. Code style

Logic is minimal: every function, branch, and helper serves the core idea. No defensive type checks, input sanitization, or edge-case handling unless required (exception: Pydantic type annotations, which Pydantic needs).

Explanation is generous: comments, docstrings, illustrative prints, and example invocations teach what the code does. Keep them.

| What | Default |
|---|---|
| Logic (functions, branches, helpers, error handling) | minimal, must serve the goal |
| Explanation (comments, docstrings, example calls, log lines) | generous |

Section comments label major blocks only, formatted exactly `=== <section> ===`, no blank line after.

## 2. Correctness

Final code has zero tolerance for bugs; the cure is testing, not careful writing. Use Pydantic models over tuples (`output.loss`, not `output[0]`); prefer frozen models. Anything unit-testable should get pytest coverage, but wait until asked before writing tests; meanwhile flag untested code. Prefer simple control flow that takes instrumentation (prints, log hooks) without restructuring.

## 3. Figure code

All figure code follows the `/paper-figure` skill; invoke it before editing any figure script. It carries the data-plot template (Okabe-Ito named constants, one global rcParams block, variance bands when stds exist), the separate method-diagram convention (serif type, hairlines, square corners, one accent), and the render-then-read check.

## 4. Experiment visualization

Every experiment has a `visualize.py`; its required content (input-output contract, one fully concrete example, dataset/run stats) and style rules live in the `/paper-figure` skill.

## 5. Compute and storage

### Clusters

| cluster | login | storage |
|---|---|---|
| Delta (NCSA) | `delta.ncsa.illinois.edu` | `/data/<project>/` |
| Endeavour (USC CARC) | `ssh tzhou029@endeavour.usc.edu` (USC VPN) | `/project2/robinjia_875/tzhou029/` |
| Local A100 node (AWS) | the current working box (no scheduler, no VPN) | `/home/ubuntu/<project>_ext/` (node-local) |

On Endeavour redirect the HF cache (home quota is small): `export HF_HOME=/project2/robinjia_875/tzhou029/.cache/huggingface`.

### Endeavour SLURM

Lab allocation `robinjia_875`: ~60 A6000, 20 A100.

| partition | use | limit |
|---|---|---|
| `nlp_hiprio` | default | 8 GPUs/student, priority on condo nodes |
| `nlp` | overflow | preemptible; checkpoint frequently |

A6000 48GB is the default (`--gres=gpu:a6000:1`); A100 80GB only when the model does not fit. Default request `--cpus-per-task=8 --mem=32G`. Availability: `noderes -f -g -p nlp`.

**Never SSH into a compute node's IP to run GPU work.** Always go through SLURM (`sbatch`, or `srun` for interactive): submit from the login node and let the scheduler place you. A node SLURM lists as idle may have its GPUs held by another job, so bypassing the scheduler means a later `sbatch` can land on the same node and fail on out-of-memory or device-busy. Node hostnames belong only in `--exclude` lists for known-flaky nodes, never as connection targets.

### SLURM job shape (any cluster)

- **Never run compute on the login node.** This covers GPU work AND CPU-only work (batch API harnesses, container runs): the login node is shared and unmanaged, and a crashed local run leaks processes and container mounts onto it. Submitting jobs, queue/log inspection, and seconds-long single-file analysis are the only login-node activities; anything with a worker pool, a container, or a runtime over ~1 minute is a batch job.
- **One job = one `srun` process, no background processes inside the job.** The process owns its GPUs directly; when the job dies, SLURM reaps the whole step and nothing is left holding GPU memory. Parallelism comes from MORE JOBS (N-way sharding, one shard per node, merge at the end), never from background processes inside one job.
- **No server-in-job (e.g. a vLLM server backgrounded inside the batch script).** A background server turns every non-happy-path job exit into orphaned workers holding GPU memory on a node the scheduler then hands to other users as "idle". If a server is ever unavoidable, quarantine it: `setsid` + EXIT-trap group-kill + block-until-dead (hold the node rather than return it dirty).

### Local GPU node

8x A100-SXM4-40GB (note: 40 GB, not 80), 96 CPUs, ~1 TB RAM. No SLURM: never write `sbatch`/`srun`/`squeue` here; launch directly and background.

- Environment: build once with `uv venv && uv pip install -e .`, run as `uv run python ...`. Confirm `torch.cuda.device_count()` prints 8 before anything long.
- Pick GPUs explicitly: check `nvidia-smi --query-gpu=index,memory.used,utilization.gpu --format=csv`, then pin with `CUDA_VISIBLE_DEVICES=0 ...`. Run independent experiments on different indices instead of one job hogging the box.
- Detach jobs that must survive the session:

```bash
mkdir -p logs
CUDA_VISIBLE_DEVICES=0 nohup uv run python train.py > logs/m1_$(date +%m%d_%H%M).log 2>&1 &
echo "PID $!"
```

### File storage

Large files (checkpoints, datasets, generated outputs) live outside the repo; the repo holds code, configs, and small artifacts (figures, summary JSON). Regenerable per-run outputs may stay in the experiment dir, gitignored. Layout under the cluster base path: `<project>/checkpoints/`, `datasets/`, `outputs/`.

### If the project routes API models through a LiteLLM proxy

- Launch the proxy with `LITELLM_MODE=PRODUCTION`. Without it, litellm runs `load_dotenv()` on import and finds the repo's `.env` by walking up from site-packages (the venv lives inside the repo), silently loading expiring credentials regardless of cwd. The proxy then dies mid-pipeline with auth errors. Prefer non-expiring auth (instance role via the boto3 default chain) for anything longer than a token lifetime.
- Find the provider's throttling point once, then budget workers across ALL simultaneously running jobs, not per job.
- Project-specific launch commands and model aliases belong in the experiment's README.

## 6. Logging and monitoring

Runs must be reproducible and inspectable from logs alone. Before the run starts, print the config (every hyperparameter that affects results):

```
=== Training ===
model:      Llama-3-8B
dataset:    OpenWebText (10M tokens)
objective:  causal language modeling (cross-entropy)
lr:         3e-4 | batch_size: 32 | max_seq_len: 512 | epochs: 3
```

Each eval pass logs a few input/generation/label triples so behavior is visible at a glance.

After launching a job, hand control back. Do not sit in a polling loop waiting for it: report the job id and how to watch it (`squeue` or the log path on clusters; `kill -0 <PID>`, `tail` the log, `nvidia-smi` on a local node), and let the user drive from there.

## 7. Smoke-test expensive jobs

Before any job longer than ~30 minutes: run the full code path at tiny scale (load the model, one iteration or one sample, save the real `results.json`). Only then launch the full run. This catches the failures that make long jobs worthless: offload bugs, missing files, broken save paths, malformed configs. Implement as a `--smoke` flag or a 5-minute time limit.

## 8. Do not rename directories with running jobs

Before renaming or moving anything an active job writes to, confirm no running job holds that path (`squeue -u $USER` on clusters; `ps`/PIDs locally). A job holding the old path string finishes in memory and crashes at save time. If a job is running: wait, save elsewhere and migrate after, or defer the rename. The same applies to `git mv` and branch switches with uncommitted renames.
