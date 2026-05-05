# Weekly Update Slide Rules

Re-read this before writing any slides.

---

## 1. Goal first (always)

Before writing any slide, run the Goal-Driven Work workflow from the root CLAUDE.md:

1. State the deck's goal in one sentence.
2. List subgoals.
3. For each slide, name the subgoal it serves — if none, do not write the slide.

A weekly update's goal is usually *"convince the advisor we made progress on X this week"*. Slides that explain config bumps, file formats, or any setup detail almost never serve that goal — drop them.

---

## 2. File organization

- Save Beamer source at `notes/weekly_updates/YYYY-MM-DD/slides.tex`.
- Copy every image used into the same folder so the entire folder uploads to Overleaf as-is.
- After the talk, record audience feedback + resulting plan in `notes/weekly_updates/YYYY-MM-DD/feedback.md`.

`feedback.md` contents:
- **Feedback from presentation:** what was flagged, suggested, or pushed back on (with enough context to be useful weeks later).
- **Plan going forward:** a table of planned experiments (model × dataset × task × prediction).

---

## 3. Audience and tone

The audience is the **advisor and collaborators** — they know the project and prior work.

- **Keep it minimal.** Only what the advisor needs to follow the result. Cut anything implementation-detail, defensive, or self-justifying.
- **Don't over-explain technical infrastructure.** Tokenizer vocab sizes, BOS-token IDs, file formats, exact CLI flags → at most one inline phrase ("bumped node-ID cap from 31 to 100"). **Never dedicate a slide to a config change.**
- **Don't pad.** No "open questions" slide unless there are real questions. No "next steps" slide unless next steps aren't obvious from the results. No protocol slide unless the protocol is the contribution.
- When the user says *"do not over-complicate"*, read it as: drop everything except (1) what the dataset is, (2) what the experiments are, (3) what the results are.

---

## 4. Structure

- **No title slide** — audience already knows the project and presenter.
- **Start with a framing slide** that states the question the deck answers and previews the argument structure. The audience should know after slide 1 what claim you are building toward and what evidence you will show.
- **The narrative thread must be visible to the audience, not just internally tracked.** Slide titles, framing sentences, and transition text ("Evidence 1:", "But does this scale?") should make it obvious how each slide advances the argument. A deck where every slide passes the subgoal check but reads like a disconnected list of experiments has failed this rule.
- Cover topics in this order, skipping anything the audience already knows:
  1. Framing slide: the question + argument preview
  2. Dataset / setup context (what data, what model, how it differs from prior work)
  3. Core theoretical claim
  4. Current experimental results
  5. Open questions to discuss with collaborators
  6. Next steps as a table (model × dataset × task × prediction)

---

## 5. Claim-driven slides, not data dumps

**Every slide is a claim, not a category.** The slide title is a one-sentence conclusion. The body is the minimal evidence supporting that claim.

Bad titles (category labels):
- "Experiment 1 Results"
- "Probe Accuracy Across Layers"
- "Attention Ablation Results"

Good titles (claims):
- "Moderate Memorizes, Easy Truly Generalizes"
- "Full-BFS Targets Fix Held-Out Generalization"
- "CoCoNut Has a Short Program, CoT Does Not"

**No result dumps.** Do not fill slides with tables of numbers, accuracy columns, or statistical summaries and expect the audience to extract the insight. Instead:
1. State the insight as the slide title.
2. Show only the 1--2 numbers, figures, or comparisons that support it.
3. Move detailed tables to backup slides.

**Tell a story, not a report.** The deck should read as:
1. What problem are we studying?
2. Why do existing methods/understanding fall short?
3. What is our hypothesis?
4. What evidence supports it?
5. What broader insight follows?

Each slide advances this narrative. If a slide only makes sense as "here's more data," it belongs in backup.

**Minimal text.** If a slide has more than 4--5 lines of text, it has too much. Cut to the one sentence that matters and let the figure or table carry the rest. The presenter's voice fills in context --- the slide is not a script.

---

## 6. Slide density

**One idea per slide.** A definition + an example + a conclusion is three slides, not one. When in doubt, more slides with less on each.

---

## 7. Figures

- Figures must be **readable when projected**. A 4-up grid of small example graphs is unreadable on a slide — use one large example per slide, or split into multiple slides.
- Use `\includegraphics[width=\linewidth,height=0.78\textheight,keepaspectratio]{...}` so figures fill the slide while preserving aspect ratio.
- If a figure looks too small in the rendered PDF, regenerate it at higher resolution or with fewer panels — never cram more onto the slide.

---

## 8. LaTeX style

- Tables over prose for all structured comparisons.
- Works/Fails predictions in tables: `\color{green!60!black}` / `\color{red!70!black}`.
- No `\titlepage`, no author/institute slide.
