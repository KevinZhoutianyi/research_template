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
- Cover topics in this order, skipping anything the audience already knows:
  1. Dataset / setup context (what data, what model, how it differs from prior work)
  2. Core theoretical claim
  3. Current experimental results
  4. Open questions to discuss with collaborators
  5. Next steps as a table (model × dataset × task × prediction)

---

## 5. Slide density

**One idea per slide.** A definition + an example + a conclusion is three slides, not one. When in doubt, more slides with less on each.

---

## 6. Figures

- Figures must be **readable when projected**. A 4-up grid of small example graphs is unreadable on a slide — use one large example per slide, or split into multiple slides.
- Use `\includegraphics[width=\linewidth,height=0.78\textheight,keepaspectratio]{...}` so figures fill the slide while preserving aspect ratio.
- If a figure looks too small in the rendered PDF, regenerate it at higher resolution or with fewer panels — never cram more onto the slide.

---

## 7. LaTeX style

- Tables over prose for all structured comparisons.
- Works/Fails predictions in tables: `\color{green!60!black}` / `\color{red!70!black}`.
- No `\titlepage`, no author/institute slide.
