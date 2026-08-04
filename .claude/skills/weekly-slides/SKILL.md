---
name: weekly-slides
description: Write or edit a weekly-update slide deck (doc/weekly_updates/YYYY-MM-DD/slides.tex, Beamer) or post_talk_notes.md. Invoke BEFORE building the deck, since the rules govern what earns a slide, not just formatting. Use for a week with a live talk; a written report nobody presents is /weekly-update, and an ad-hoc status answer in chat is /progress-report.
---

# Weekly Update Slide Rules

## 1. Goal first

Run the goal-driven workflow from the root CLAUDE.md: state the deck's goal in one sentence, list subgoals, and name the subgoal every slide serves. No subgoal, no slide.

A weekly update's goal is usually "convince the advisor we made progress on X this week". Slides about config bumps, file formats, or setup details almost never serve that goal.

## 2. Files

- Beamer source at `doc/weekly_updates/YYYY-MM-DD/slides.tex`; copy every image into the same folder so it uploads to Overleaf as-is.
- After the talk, write `post_talk_notes.md` in the same folder: what was flagged or pushed back on (with enough context to be useful weeks later), and the plan going forward as a table (model x dataset x task x prediction).

## 3. Audience and tone

The advisor and collaborators already know the project. Keep it minimal: only what they need to follow the result. No infrastructure detail beyond an inline phrase. No padding slides ("open questions", "next steps") unless there is real content for them. When the user says "do not over-complicate", read it as: the dataset, the experiments, the results, nothing else.

## 4. Structure

- No title slide.
- Slide 1 frames the deck: the question it answers and the argument it will build. After slide 1 the audience knows what claim is coming and what evidence will support it.
- The narrative thread stays visible in slide titles and transitions ("Evidence 1:", "But does this scale?"). A deck that reads as a disconnected list of experiments has failed even if every slide passes the subgoal check.
- Every slide must answer two questions for the reader: (1) why are we looking at this? and (2) what does it tell us? A slide that shows only a result without explaining the motivation is a data dump. For experiment slides: state the prediction before showing the finding.
- No slides that are just notes or prose. If a slide has no figure, table, or concrete number, it belongs in the presenter's voice. Exception: the framing slide and the "what stays open" slide.
- Order: framing, setup context, core claim, results, real open questions, next steps as a table. Skip anything the audience already knows.

## 5. Claims, not categories

Every slide title is a one-sentence conclusion, not a label. "Moderate Memorizes, Easy Truly Generalizes", not "Experiment 1 Results".

No result dumps: state the insight as the title, show the one or two numbers that support it, move detail tables to backup. Exception: when the user explicitly asks for a full per-task table or a verbatim prompt on a slide, render it cleanly (scriptsize, green/red markup) instead of arguing it down to a summary.

Minimal text: more than 4-5 lines on a slide is too much. The presenter's voice fills in context.

One idea per slide. A definition + an example + a conclusion is three slides.

## 6. Figures

- Readable when projected: one large example per slide, never a 4-up grid of small panels.
- `\includegraphics[width=\linewidth,height=0.78\textheight,keepaspectratio]{...}`.
- Too small in the rendered PDF means regenerate at higher resolution or with fewer panels, never cram.
- Slides and their figures get the stranger-read pass from the `/verify-paper` skill: render the PDF, read every page as the audience, trace arrows and check label collisions before committing.

## 7. LaTeX

- Tables over prose for structured comparisons.
- Works/Fails predictions: `\color{green!60!black}` / `\color{red!70!black}`.
- No `\titlepage`, no author slide.
