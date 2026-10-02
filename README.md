# Research Template

Create a project with shared code and support files under `src/`, numbered
experiments, and one result narrative.

```bash
./init_project.sh myproject /path/outside/template/myproject
cd /path/outside/template/myproject
uv sync --extra dev
uv run pytest
```

The initializer copies committed files only, replaces the package name, and
initializes Git with documentation checks. It never copies local environments,
credentials, caches, or research results.

## Layout

```text
project/
├── README.md
├── CLAUDE.md
├── pyproject.toml
├── src/
│   ├── myproject/       # importable shared package
│   ├── configs/         # shared settings
│   ├── data/            # canonical inputs and ignored bulk data
│   ├── tests/           # shared tests
│   ├── slurm/           # launchers and ignored logs
│   └── githooks/        # documentation checks
├── experiments/
│   └── 01_example/      # first scientific question
├── doc/
│   ├── result.md        # findings and evidence links
│   ├── paper/           # manuscript and Overleaf assets
│   ├── related_papers/
│   ├── example_papers/
│   └── weekly_updates/  # use only when needed
├── archive/
│   └── MANIFEST.md      # original paths and recovery notes
└── tmp/                # ignored scratch
```

The root holds project metadata and these four persistent directories.
`tmp/` is disposable scratch. `init_project.sh` exists only in the template;
generated projects do not include it.

## Experiments and results

Number experiments by the argument's questions, with no fixed count or inherited
scientific conclusions. Document the question, protocol, command, evidence, and
limits in each folder. Add real runners and figures when needed, not placeholders.

All experiments import the package under `src/`. Shared configuration, inputs,
tests, and scheduler scripts live alongside it. Keep small results beside their
experiment and large generated files in ignored bulk storage. Use shared path
definitions, not hard-coded user paths. `PROJECT_ROOT` selects the checkout when
using a wheel installed outside the project.

`doc/result.md` is the current scientific narrative. Write the manuscript from
validated evidence there; separate `doc/status.md` and `doc/paper.md` files are
not required. Job records belong beside their experiment. Archived templates do
not require recreating retired files.

## Hidden files and tools

Keep `.git` and `.gitignore` at the root. `.claude/` remains where the tool
discovers its skills and hooks. Keep `.venv/` in its standard ignored location:
moving an installed environment can break executable paths. Pytest and Ruff
caches go under `src/`. Add `.gitmodules` only for actual submodules.
Never commit personal tool settings or publish agent instructions to Overleaf.

Existing writing, figure, verification, and cleanup skills remain available.
The current layout contract in root `CLAUDE.md` overrides historical paths in
bundled skills. The documentation hook lives in `src/githooks/`.

## Archiving and verification

Check callers, result links, and active jobs before moving files. Record
recoverable moves in `archive/MANIFEST.md`. Preserve historical source hashes
and data supporting current claims. Update paths, imports, tests, and launchers
together, then verify before resuming computation.

`uv run pytest` discovers `src/tests/`. Configure the scheduler account,
partition, resources, and environment for each project; `src/slurm/` provides a
generic wrapper without site-specific defaults.
