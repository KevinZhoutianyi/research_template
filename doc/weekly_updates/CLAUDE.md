# Weekly Update Rules

The rules for weekly updates live in skills, not here. Two forms exist and both skills stay
installed; the choice is per week, not per project:

- `/weekly-update` -- a Markdown progress report (`update.md`), for sponsors/advisors who read
  asynchronously, a catch-up for someone who missed a talk, or a week with no meeting. Comes with a
  template and a banned-language check script.
- `/weekly-slides` -- a Beamer deck (`slides.tex`), for a week with a live talk.

Pick by whether someone stands up and presents it. Both forms never get written for the same week.
Note below which form is this project's usual default.

**Invoke the chosen skill before drafting** -- before gathering numbers, not just before writing,
because the rules govern how results are reported (baselines, one-variable comparisons, noise
ranges, what earns a slide).

This project's usual default: `<fill at init>` (init_project.sh's "next steps" names this file;
if still unfilled when the first update is due, ask the user which form and fill it then)

Regardless of form: every claim is grounded in a real `results.json`, run log, or transcript;
nothing invented, nothing softened, no "should help" written as "helps". After any talk or
sponsor meeting, write `post_talk_notes.md` in the same folder.
