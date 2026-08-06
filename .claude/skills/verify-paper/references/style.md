# House Style: Structure and Language

The single home of the structure and language rules for all prose in this repo: `paper.md`,
`proposal.md`, the LaTeX paper, weekly updates, and chat replies. Every other file points here
instead of restating a rule. `check_prose.sh` greps the greppable subset; the rest is checked
by reading. Paragraph-scale rewrites for the AI-writing patterns live in
[ai-writing-patterns.md](ai-writing-patterns.md).

## Structure

- Introduction has no subsections. Flowing prose, ending with a numbered contributions list. Sentence-level scaffolding for the abstract and the introduction (three abstract shapes, the seven-paragraph intro plan, what a contribution bullet must contain) is in [abstract-and-intro-templates.md](abstract-and-intro-templates.md); open it before drafting or restructuring either section.
- Section titles are noun phrases naming the topic ("Depth Generalization"); subsection titles state the finding as a declarative sentence. Claim strength and number rules for titles: `doc/CLAUDE.md` §2a.
- Related Work is flowing prose, one paragraph per paper or group.
- Mechanism subsection titles state the finding ("Detection forms in the last seven layers"), not a question.
- Caveats go inline after the result they qualify. No standalone "Limitations" subsections inside experiment sections.
- Prose over bullets in the body. Bullets are for contributions lists and procedural steps only.
- Dense 2D evidence (N conditions x M outcomes) goes in a table, not prose.

## Language

- No em dashes, in either `---` or Unicode form. Use commas, colons, parentheses, or split the sentence. Grep before committing. Replacing every em dash with a colon is not a fix: a paragraph where three sentences all break at a colon has the same interrupted cadence the em dashes had. Vary the repair, and prefer the subordinate clause over the interruption.
- No contractions. First-person plural throughout.
- Short declarative sentences. "X reaches 99.7%. Y fails at 63.3%." Not "We observe that X consistently reaches...".
- Cut filler openers ("It is worth noting that"), defensive hedging, grandiose framing, and narration ("Table X shows that").
- No self-justifying sentences about our own honesty, transparency, or rigor. Banned shapes: "reported honestly", "whatever it shows", "visible, not hidden", "to be fair", "we do not hide/soften", "even when unflattering", "reported transparently". They tell the reader to trust us instead of showing the data, and announcing our own honesty plants the opposite doubt. Lead with the finding and state the number as fact instead. Grep prose (not fenced code) before committing.
- **No capitals as emphasis.** Not "the SAME model", "it HURTS here". Emphasis is carried by word order and sentence structure; a reader sees shouting, and a reviewer sees an author who could not make the sentence do the work. Rewrite: "the SAME model" becomes "holding both seats at the same model". Capitals survive only as literals inside fenced blocks (a protocol token like `STEER`, a checker's `FAILED`), which are quoted text. Grep prose for `\b[A-Z]{4,}\b` before committing; one draft had 24 such words.
- **No bold or italic for emphasis in body prose.** A sentence that needs markup to land is a sentence whose word order is wrong; put the emphasized thing in the subject position instead. `\emph{}` and `\textbf{}` survive only where they mark something rather than stress it: a term being defined at first use, a token that is itself the object of study, a criterion name quoted from a cited definition, a run-in paragraph heading (`\textbf{Extraction frames.}`), the best value in a table column, and the lead of a contributions bullet. Everything else is stress and gets rewritten: emphasizing `\emph{which}` input was used becomes "the identity of the input", and a control at `\emph{its own}` scale becomes "a control matched to that item's scale". One markup convention per object, held throughout.
- **Third person, not second.** No "Consider an agent that has just...", no "you will notice", no addressing the reader. State the fact instead. Second person is the voice of a tutorial. The exception is quoted text inside a fenced block, where a speaker really does say "you".
- **No meta-narrative.** The document does not describe its own structure or signpost its own argument: cut "this is what everything below builds on", "as we shall see", "the rest of this section". A section that needs a pointer to the next one is usually two sections in the wrong order.
- **State the result; do not grade it.** Cut "the result supports the design's premise", "this confirms our hypothesis", "this is a strong result". End on the measurement and let the reader draw the conclusion.
- Banned words, rewrite every instance: delve, crucial, pivotal, robust, leverage, utilize, showcase, comprehensive, notably, importantly, interestingly, it is worth noting, this allows us to, in summary, in conclusion.
- **The plain word, unless the technical one is doing work.** The list above is a list of instances; the rule behind it is that a longer word earns its place only by being more precise than the short one. Use "use" for leverage and utilize, "study" or "measure" for investigate and explore, "setting" or "context" for landscape and tapestry, "show" for demonstrate when nothing was proven. This does not touch terms of art: the field's precise words stay, even when they are long. The test is substitution: if the plain word can replace the fancy one with no loss of meaning, the fancy one was decoration.
- No implementation details in the body. Library names, file paths, CLI flags, experiment IDs go to `tracking.md` or a run script docstring.
- Every technical claim gets a plain-English gloss within one paragraph. If a non-specialist cannot restate the claim, the gloss is missing.

## Chat replies

Chat is the one channel with no gate (`check_prose.sh` never runs on it), so the rules above
govern replies too; a reply is not exempt because it is conversational. Three limits show up
most in chat:

- No em dash in either `---` or Unicode form.
- `rather than` plus `X, not Y` at most once per reply; stacking them makes every paragraph read as a running contrast.
- A colon-then-elaboration is one repair among several, not the default. Vary the join or state the conclusion outright.
