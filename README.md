# Research Template

A template for AI/ML research projects driven with [Claude Code](https://claude.com/claude-code).
It ships the directory skeleton of a research project (paper, experiments, weekly
updates) together with the rules and skills that make an AI assistant productive inside it:
what to write where, how results are reported, and which gates a change must pass before it
counts as done.

Start a new project:

```bash
./init_project.sh myproject ~/projects/myproject
cd ~/projects/myproject
git init && git add -A && git commit -m "scaffold from research_template"
git config core.hooksPath .githooks   # enable the language gate
```

`init_project.sh` copies everything except git history and replaces `PROJECT_NAME` throughout.

## Layout

| path | what it holds |
|---|---|
| `CLAUDE.md` | the root working guide (see below) |
| `doc/paper.md` | the working draft of the argument: goal, thesis, outline, per-section evidence |
| `doc/paper/` | the LaTeX paper for Overleaf; mirrors `paper.md`, lags it |
| `doc/related_papers/` | one note per cited paper (written by the `/read-paper` skill) |
| `doc/example_papers/` | exemplar PDFs plus `style_extraction.md`, the distilled style reference every doc follows |
| `doc/weekly_updates/` | weekly progress reports, one folder per week |
| `experiments/` | numbered, self-contained experiment folders; `experiments/src/` holds the shared code all experiments import |
| `theory/` | theory writing, with its own rules |
| `tmp/` | throwaway scratch (gitignored, deletable at any time) |
| `data/` | checkpoints, datasets, large outputs (gitignored; may symlink to bulk storage) |
| `.claude/skills/` | the eight skills (see below) |
| `.claude/hooks/` + `.claude/settings.json` | the skill-prematch hook |
| `.githooks/pre-commit` | the language gate on staged docs |

## The CLAUDE.md architecture

One design law governs every rule file: **every rule has exactly one home.** A rule lives in
one place at full strength; every other file that needs it points there. The alternative
(restating a rule wherever it applies) was measured in a real project before this design:
one writing rule had drifted into five files with five wordings, and fixing it meant finding
all five. The layers, top to bottom:

| layer | file | answers | size |
|---|---|---|---|
| always loaded | `CLAUDE.md` (root) | what must never be violated, and where everything else lives | ~60 lines |
| per directory | `doc/CLAUDE.md`, `experiments/CLAUDE.md`, `theory/CLAUDE.md` | what the files in this directory are and the constraints specific to them | 30-190 lines |
| per task | `.claude/skills/*/SKILL.md` | how to do one kind of task and when it counts as done | ≤180 lines each |
| enforcement | `.githooks/`, `.claude/hooks/` | which checks run without anyone remembering them | two scripts |

### Root `CLAUDE.md`

Three parts, deliberately short so that all of it survives in attention during long sessions:

- **A routing table**: one row per task type (doc edit, experiment code, figures, weekly
  update, status answer, reading a paper, brainstorming, deleting), naming the skill or
  directory file that owns the rules.
- **Safety rules, full text.** The rules whose violation is expensive and hard to reverse
  stay verbatim in the root file, never behind a pointer: the compute posture (scheduler
  discipline, caps, what is free vs metered — filled in per project at init), prove-then-delete
  for dead code, commit-and-push after substantive changes, and decisions-presented-as-options
  (at any "what should we do" moment, present 2-4 labeled options with trade-offs and wait).
- **Behavior rules, one line each.** Goal-first work (relate, never enumerate), ask-don't-assume
  (one targeted question when a reading changes the outcome), verify-each-step, surgical changes,
  tables over prose, reports that carry their own context, plain language with a worked
  example, everything earns its place. Each line names where the full rule lives.

### Directory rules

- `doc/CLAUDE.md` — the map of the doc folder (which file is canonical for what), the
  motivation-first writing rule, claims-and-evidence calibration (claim strength matched to
  the data, every prediction carrying a falsifier), framing methodology (sketch first,
  stance fixed up front, mechanism verified against data before prose), LaTeX/table/figure
  conventions, and the consistency rule: experiment results and paper claims always agree.
- `experiments/CLAUDE.md` — correctness
  through tests rather than careful writing, per-project compute rules, logging that makes
  runs reproducible from logs alone, and smoke-testing anything longer than ~30 minutes.
- `theory/CLAUDE.md` — no obvious theorems, every assumption justified, a concrete takeaway
  after every theorem, tightness shown for every bound.

## The skills

Skills are task-triggered procedures. Two patterns repeat across them, and they are the point
of the whole setup:

**The delivery-gate pattern.** Producing work and verifying work are separate steps, and a
task is not done until it passes its gate. Writing experiment code follows
`experiments/CLAUDE.md`; declaring it done invokes `/verify-experiment`. Drafting prose
follows the style rules; declaring the edit done invokes `/write-paper`. The gates are
checklists with teeth: they run scripts, read rendered output, and report what is still red
instead of declaring victory.

**The single-home pattern.** A skill that owns a rule set carries it in `references/` files
that other layers point into. The house writing style lives in
`write-paper/references/style.md` and nowhere else; `doc/CLAUDE.md` and the root file point
at it.

### Writing and verification

- **`/write-paper`** — the biggest skill, invoked at two points of any doc edit: before
  drafting (it loads `references/style.md`, the single home of the structure and language
  rules: banned words and shapes, no emphasis markup, third person, plain-word test) and
  before declaring done. The gate runs: the stranger-read pass (re-read with zero context,
  checking dangling referents, categories without instances, figure renders), the reverse
  outline (list every paragraph's first sentence and check they map onto the section's
  claim — the only check that catches a section whose paragraphs are individually fine but
  collectively off-claim), `scripts/check_prose.sh` (greps for the banned language),
  a 10-point checklist (declarative titles, `results.json` backing for causal claims,
  numerical consistency between body and tables), `scripts/render_pages.sh` (compile the
  LaTeX and read every page as an image), and a reject-risk pass (read as a reviewer looking
  for a reason to reject, answer with pointers into the text or the word "missing").
  `references/ai-writing-patterns.md` holds eleven AI-writing patterns with before/after
  rewrites at paragraph scale; `references/abstract-and-intro-templates.md` holds
  sentence-level scaffolding for abstracts and introductions.
- **`/verify-experiment`** — the delivery gate for experiment code. Scopes the diff, runs
  pytest on report-bound paths (scoring, statistics, data processing get tests by default,
  not on request), smoke-tests changed pipelines, and rules out the seven AI-research
  failure modes from `references/ai-research-failure-modes.md` (implementation bug passing
  self-review, hallucinated result, shortcut reliance, bug reframed as a finding, ...), each
  verdict marked CLEAR / SUSPECTED / INSUFFICIENT EVIDENCE with named evidence.
- **`/scientific-figure-making`** — the house figure style for matplotlib: semantic palette,
  minimalist spines, tightened y-limits, export policy, uncertainty bands wherever results
  carry stds, and a separate serif-hairline convention for method diagrams. Six `references/`
  files with tutorials and 25 local demo scripts. Done-when includes actually opening the
  exported file and looking at it.

### The research loop

- **`/read-paper`** — a paper in (arXiv link, PDF, title), two artifacts out: a note in
  `doc/related_papers/` and a verified BibTeX entry. The note is opinionated by design:
  summary, relation to our work (overlap named head-on, separable deltas numbered), where it
  pressures our claims, and key facts to cite. Metadata is always fetched, never recalled;
  bib entries carry `author = {TBD}` for the human to fill from verified metadata. If the
  paper threatens a claim currently in `paper.md`, that surfaces in chat and lands in
  the affected `paper.md` section, never silently filed.
- **`/cleanup`** — prove-then-delete, for anything that clutters the repo: dead code, dead
  docs, scratch/tmp files, stale checkpoints, and structure drift. A general "repo is a mess"
  request triggers a five-category sweep presented as a findings table before anything is
  deleted. Per-category proof standards (grep for callers, check half-live files, no running
  job holds the path, no report reads the artifact); results data is never deleted to tidy up.
  Deletion is its own commit, and the commit message says what proved it dead.

### Reporting

- **`/weekly-update`** — the weekly Markdown progress report, invoked before gathering
  numbers because the rules govern how results are reported, not just prose: every number
  states its baseline and floor/ceiling, one variable per comparison, small-n results carry
  their noise, failures carry an evidence-based reason or "reason not yet established".
  Fixed section order ending on the Plan (each item with a prediction and falsifier); a
  Definitions section so the reader needs zero background; `scripts/check_language.sh` greps
  for research slang and self-justifying framing.
- **`/weekly-slides`** — the same week's report as a Beamer deck, for a week with a live
  talk. Every slide title is a one-sentence conclusion, one idea per slide, no padding
  slides. Pick one of the two forms per week, never both.
- **`/progress-report`** — the structure for any ad-hoc status answer in chat: goal restated
  first, progress judged against it (met / not met / partial and why), one comparison table
  including unfavorable results, single next step. Never a list of activity.

## Enforcement

Two hooks exist because "remember to invoke the skill" is the weakest link in any rule
system:

- **`.githooks/pre-commit`** (enable once with `git config core.hooksPath .githooks`) runs
  `check_prose.sh` on staged `paper.md` / `proposal.md` / `doc/paper/*.tex` and
  `check_language.sh` on staged weekly updates. A hit blocks the commit; the fix is a
  rewrite, never an allowlist entry.
- **`.claude/hooks/skill-prematch.sh`** (wired via `.claude/settings.json`,
  UserPromptSubmit) matches each user prompt against bilingual keyword lists and injects a
  one-line reminder naming the matching skill; silent when nothing matches. The keyword
  lists mirror the skill descriptions — update both together when adding a skill.

Neither hook replaces reading the rules; they catch the forgetting.

## Adding a rule or a skill

1. Decide the home by the layer table: safety → root full text; behavior → root one-liner
   pointing at the detail; task procedure → a skill; directory fact → that directory's
   CLAUDE.md.
2. Write it once. Add pointers (not restatements) where it will be needed.
3. If it is greppable, add the pattern to the matching check script; if it is a new skill,
   add a routing-table row and a keyword line in `skill-prematch.sh`.
4. New rules earn their permanence: a lesson from one incident starts as a project memory or
   a one-line rule with its trigger named, and grows into a full section only when it fires
   again.
