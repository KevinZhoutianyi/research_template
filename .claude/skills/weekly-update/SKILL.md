---
name: weekly-update
description: Write or edit a weekly-update progress report (doc/weekly_updates/YYYY-MM-DD/update.md) or post_talk_notes.md. Invoke BEFORE gathering numbers or drafting — the rules govern how results are reported, not just the prose. This is the committed weekly file; an ad-hoc status answer in chat is /progress-report.
---

# Weekly Update Rules

The weekly update is a **Markdown progress report** (`.md`), not a
PDF, not a LaTeX article, not a slide deck, and not paper prose. It records what happened this
week and what the plan is, for a reader who tracks the project week to week. (Older updates under
`archive/` are LaTeX/PDF; do not add new ones in that form.)

Start from [template.md](template.md) for a new update. Before committing, run
`scripts/check_language.sh <update.md>` (banned-metaphor and self-justification greps).

## 0. Two principles above all others

These govern every sentence; the numbered rules below are how you satisfy them.

- **Every claim is grounded, nothing is invented.** Each number traces to a real
  `results.json` or run log; each mechanism ("the steerer misdiagnoses billing as technical")
  is read from actual transcripts, not guessed. If you have not verified it, do not write it as
  fact: write "not yet established" and put verifying it in the Plan. No plausible-sounding
  filler, no rounded-up hopes, no "should help" stated as "helps". When in doubt, go read the
  data before writing the sentence.
- **The update is a story, not a list of facts.** It has one logical line the reader can follow:
  a question, what we did to answer it, what we found, what that forces us to ask next, each
  section handing to the next. Result 2 exists because Result 1 raised its question; the Plan
  follows from what the Results did and did not show. A reader must be able to say "they asked X,
  tested it this way, found Y, so next they do Z" after one read. Never a pile of disconnected
  true statements; if a paragraph does not advance the line, cut it or move it to `tracking.md`.

## 1. Goal first

Run the goal-driven workflow from the root CLAUDE.md: state the update's goal in one sentence,
list subgoals, and name the subgoal every section serves. The goal is usually "show the sponsor
and advisor what moved this week and what happens next". Config bumps, file formats, and setup
details almost never serve that goal.

## 2. Files

- One Markdown file per update at `doc/weekly_updates/YYYY-MM-DD/update.md` (one file per
  track if the project has parallel tracks). GitHub-flavored Markdown: `#`/`##` headers, pipe tables,
  fenced code blocks for any verbatim quote. No LaTeX, no PDF, no compiled artifact. Show
  direction-of-change with bold for wins and italic for losses/regressions, not color.
- Title (the top `#`) is just the date: `# YYYY-MM-DD Weekly Update`. No
  tagline, no summary in the title.
- After any talk or sponsor meeting, write `post_talk_notes.md` in the same folder: what was
  flagged or pushed back on (with enough context to be useful weeks later), and the plan going
  forward as a table.

## 3. Language: plain, literal, concise

**Assume the reader has zero background knowledge.** They have not read previous updates, the
paper, or the codebase, and definitions do not carry over between updates. Concretely:

- **No research slang or metaphor.** Banned: "knob", "lever", "standout", "a wash", "cashes
  out", "fires the falsifier", "landed", "cell", "arm", "harness" (say "the same setup"),
  "slice". Say what happened literally: not "temperature is the one knob that mattered" but
  "one training setting (temperature 2) scores 18/34; every other setting we tried scores
  3--10". If a sentence needs the metaphor to be short, rewrite the sentence.
- **Every number states its baseline.** A score is meaningless without its floor and ceiling:
  write "improved from 5/34 to 18/34 (no correction: 0/34 by definition; written text: 34/34 by
  definition)", never a bare "18/34". Changes are stated as "from a to b", not "reached b".
- **Short sentences, one fact each.** Prefer "The vectors do help: 17 of their 19 rescues are
  games text also rescues." over multi-clause constructions.
- Every condition name that appears in a table (naive, text, vectors, vectors + gate) is defined
  before or at its first table, in words a non-specialist can repeat.
- Not too much detail: one table and 3-5 bullets per result; sub-variants collapse into a "best
  variant" row unless the variant is the point. Full sweeps and per-cell provenance live in
  `tracking.md`.
- Report final results only, in absolute terms. **No comparisons to superseded or failed
  versions** ("last week's compressor failed", "improved over the old design") -- the reader
  tracks this week, and failure history lives in `tracking.md`. Bug histories and superseded
  numbers never appear; show the current best-known number for each cell as if it were always
  so.

## 4. Structure

The section order is fixed (all headers are Markdown `##`, except the top title `#`):

1. `## What this project is` -- 3-5 sentences only: what an LLM agent is, what the
   system does, the question the project asks, what model/hardware. No definitions here beyond
   what those sentences need.
2. `## Definitions` -- **a dedicated section, one bullet per term of art** (the project's
   terms of art). Each bullet: the term in bold, then one or two plain
   sentences, with a concrete example where one helps ("one game = one simulated-household task,
   e.g. 'put a hot potato in the garbage can'"). The body never uses a term before it appears
   here, and never re-defines inline what belongs here.
3. One `## Result N: <plain-language finding with its numbers>` per subgoal. Section
   titles are one-sentence conclusions carrying the key numbers ("on full games, every vector
   variant scores 65-69; text scores 88.8"), not topic labels.
4. `## Plan` -- every item names its prediction and, where one exists, its falsifier,
   both stated concretely ("if the score still sits at 67-69, then X"). This is the last
   section: the update ends on the Plan.
5. Appendix sections (`## Appendix: ...`) -- one verbatim example per claim type (a real test
   case, a rescued game, a broken game), quoted from committed run data, never composed. Put
   verbatim quotes in fenced code blocks.

**No Summary section.** Do not add a closing summary or recap; it duplicates the Result titles
(which are already one-sentence conclusions with their numbers) and the Plan. End on the Plan.

**Every result table is preceded by two labeled lines:**

- `**Data.**` -- which dataset, its size, and **exactly what is train and what is test**:
  how the split was made (by game, by time, ...), the counts on each side, and that they do not
  overlap -- or, if any overlap exists, state it plainly as a caveat instead of hiding it.
- `**Metric.**` -- what is counted, what a point means, and the floor/ceiling values with
  why they are the floor and ceiling.

Tables are Markdown pipe tables. A method section, when present, comes before the first Result
and may carry one worked end-to-end example (instance before category, per `doc/CLAUDE.md`).

**A workflow diagram is welcome when it earns its place.** For a method that is a pipeline or a
multi-stage flow, one figure can replace paragraphs. Rules: generate it with a committed
plotting script (save the `.py` beside the `.md`), reference it from the method section, follow the
`/scientific-figure-making` palette, and run the stranger-read pass on the render before committing -- every arrow
connects edge-to-edge between boxes (anchor arrows to box edges in code, do not hand-place
endpoints), no label overlaps a box or another label, every box and arrow is legible at the
width it will be viewed. A figure that just repeats the prose is cut.

**Parameters are experimental results, not design constants.** Never fix a parameter (k, a
temperature, a threshold) in the method description. The method text says the parameter exists
and is "chosen by experiment in Result N"; the result section shows the sweep over its values
and lets the table pick the winner ("k=32: best; used from here on").

**Quantified motivations get measured columns.** If the project's pitch is a quantified benefit
(fewer tokens, lower cost, less time), every result table carries the measured benefit as its
own column (e.g. "injected tokens" and "saved vs. text %"), computed honestly even when the
number is unflattering -- and the accompanying bullet says plainly whether the benefit is
currently real ("the saving is 2--10%, not yet meaningful").

## 5. Claims, not categories

State the finding as the section title or lead bullet, show the one or two numbers that support
it, and point to `tracking.md` for detail. Every number says what it counts (metric, n, split).
Results and comparisons go in booktabs tables, not prose (root CLAUDE.md rule 2); a table row
that needs explanation gets a bullet under the table, not a paragraph. Where a result is partial
or mixed, the title says so ("works on single steps, not yet on full games").

## 6. Rigor rules (each caught a real mistake in review)

- **Titles obey §3 and §4.3 even when they are correct conclusions.** A layperson reading only
  the title must get the finding, so no jargon or metaphor in it: not "the one-imperative-sentence
  requirement is load-bearing" but "making the steerer give one specific instruction, not a vague
  comment, is what makes it work".
- **One variable per comparison.** A row that changes two things at once (stronger model AND new
  design) proves nothing about either. Hold everything else fixed, vary the one thing the claim is
  about, and say in the Metric paragraph what is held fixed ("steerer fixed at Opus in both rows,
  so the only change is the design"). If two things genuinely differ, split into two comparisons.
- **When something does not work, give the failure reason from evidence, not just the number.**
  Not "our design loses on telecom (35.6 vs 48.8)" but "the steerer misreads billing as technical:
  0 of 37 notes mention the bill; steered trials score 0.07 vs silent 0.51". If the reason is not
  known, write "reason not yet established" and put finding it in the Plan; never a bare loss.
- **Small-n results carry their noise.** On a small test set (tens of tasks) a single run is
  fragile: report reruns or a range, and if the range overlaps the baseline say so ("the real gap
  is about +4, not the +12.5 a single run showed"). Never headline a number a rerun would not hold.
- **Few sections, not many.** Merge related findings into one Result with an arc (effect, then
  why/what-breaks-it, then generalization); about three Results total. Caveats and method checks
  are bullets inside a Result, not their own sections.

## 7. Verification

- Read the whole `.md` top to bottom (the stranger-read pass from `doc/CLAUDE.md`): every table
  renders as a table (header separator row present, columns aligned), every term used in the
  body appears in the Definitions section, every number carries its baseline, no filename /
  experiment-name / CLI / env-var leaks (those live in run-script docstrings or `tracking.md`).
- Every number matches its `results.json` or `tracking.md` row (three-way consistency).
- Run `scripts/check_language.sh <update.md>`: it greps the prose (fenced code blocks excluded)
  for the banned-metaphor list in §3 and for self-justifying framing about our own honesty
  (honest, whatever it shows, not hidden, visible not, to be fair, we do not hide, we do not
  soften, transparent, unflattering). Any hit is a rewrite: lead with the finding, state the
  number as fact (see `doc/CLAUDE.md` Language rules).
- Commit the `.md`. There is no compiled artifact.

Done when: every check in this section passes and `check_language.sh` exits clean. Until then the update is a draft, not done.
