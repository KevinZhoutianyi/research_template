---
name: read-paper
description: Read a paper into the project — the user gives an arXiv link, PDF, title, or "看一下这篇" / "读一下这个paper". Produces one note in doc/related_papers/ (summary, relation to our work, where it pressures our claims, key facts to cite) and a verified references.bib entry. Also for updating an existing note after a deeper read. Not for casual "what is this paper about" answers with no note wanted — but offer to save one.
---

# Reading a Paper into the Project

One paper in, two artifacts out: a note at `doc/related_papers/<citekey>.md` and a verified
entry in `doc/paper/references.bib` (when the paper is likely to be cited). The note is written
for a future reader deciding whether this paper threatens or supports our claims, not as a
neutral book report.

## 1. Get the actual text

Fetch the source in this order: the arXiv abstract page, then the full PDF or HTML when the
relation to our work needs method-level detail. Read enough to answer the questions in §3;
abstract-only is acceptable for a peripheral paper, and the note's status line says which depth
was reached ("read via abstract", "read §3-4", "full read").

## 2. Verify the metadata (never from memory)

Every bibliographic fact comes from a fetched page, none from recall:

- Resolve title, first author, year, and venue from the arXiv page or the publisher/DOI page.
- Check for a published version of an arXiv preprint (OpenReview, ACL Anthology, the venue
  page): cite the published venue when one exists.
- The `references.bib` entry keeps this repo's convention (`doc/CLAUDE.md` §4): title + url +
  year + `author = {TBD}`. Never type author names into the .bib, even ones just read; the
  human fills them from verified metadata. The note MAY name the first author, copied from the
  fetched page.
- If the paper cannot be found at the location the user gave, search the title on Google
  Scholar and Semantic Scholar before reporting; say "could not confirm via X, Y", never
  "fabricated".

## 3. Write the note

`doc/related_papers/<citekey>.md`, citekey matching the .bib key. Sections, in order (the
house example: `expel.md`):

1. Header: title, first author + et al., venue, arXiv id and link.
2. A one-line status quote: read-depth and date, and one sentence on why this paper matters to
   us ("the single closest prior work to our Track A positioning").
3. `## Summary` — one paragraph, plain language: what the system/result is, the mechanism, what
   is reported. A reader who never opens the paper can repeat it.
4. `## Relation to our work` — the load-bearing section. Name the overlap head-on, then the
   separable deltas as a numbered list, each stating what they do vs what we do. When one of
   our own results bears on a delta (an ablation that measured their design choice), cite it
   with its numbers.
5. `## Where it pressures our claims` — what we can no longer claim as novel, which of our
   sentences this paper forces us to weaken. Empty only for purely supporting citations.
6. `## Key facts to cite` — 3-5 bullets of specifics (numbers, setups, scope limits) usable in
   Related Work without re-opening the paper.

## 4. Close the loop

- If the paper contradicts or weakens a claim currently in `paper.md`, say so in chat and mark
  the affected `paper.md` section; do not silently file the note.
- The Related Work table in `paper.md` gets a row (Paper | Relation) when the paper will be
  cited; the note holds the long form.
- Commit and push both artifacts.

Done when: the note has all six parts with a stated read depth, the .bib entry is fetched (not
recalled) with `author = {TBD}`, any threatened paper claim is surfaced in chat, and both files
are committed.
