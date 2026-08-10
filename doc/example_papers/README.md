# example_papers

PDFs of papers whose **writing voice, figure design, and section structure** every doc in this project aims to mirror (paper, proposal, weekly updates). See `doc/CLAUDE.md` §7 for the matching rule.

`style_extraction.md` is the per-dimension distillation of these PDFs (titles, structure, abstract shape, prose voice, figure captions, tables, algorithm blocks, notation) with verbatim quotes. It is the first stop when drafting; open the PDF when the extraction is not enough. Regenerate it when the PDF set changes.

This folder is different from `doc/related_papers/`: those define what the paper *cites*; these define how it *reads*.

How to use: drop PDFs here named `<short_slug>_<arxiv_id>.pdf` (e.g. `h2o_heavy_hitter_oracle_2306.14048.pdf`). Open one before drafting a section opener, designing a figure, or restructuring the paper.

The set should be small (2-4 PDFs) and curated. Update it when the target venue or desired voice changes.

## Current set

| file | paper | what to mirror |
|---|---|---|
| `h2o_heavy_hitter_oracle_2306.14048.pdf` | H2O: Heavy-Hitter Oracle for Efficient Generative Inference of LLMs (NeurIPS 2023) | title form (named method + one-line claim), figure design, how an empirical observation is turned into a method section |
| `fourier_features_addition_2406.03445.pdf` | Pre-trained LLMs Use Fourier Features to Compute Addition (NeurIPS 2024) | declarative finding-titles, mechanism-analysis structure (question, probe, answer), plot style for per-layer/per-component evidence |
| `rome_locating_editing_facts_2202.05262.pdf` | Locating and Editing Factual Associations in GPT (ROME, NeurIPS 2022) | causal-analysis narrative (trace, then intervene), figure captions that state the finding, restrained claim language |
| `lookbacks_belief_tracking_2505.14685.pdf` | Language Models Use Lookbacks to Track Beliefs (ICLR 2026) | hypothesize-then-verify section arc, coined-mechanism vocabulary used with total consistency, prediction-first captions; the ICLR-format reference |
