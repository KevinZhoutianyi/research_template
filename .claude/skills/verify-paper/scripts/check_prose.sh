#!/usr/bin/env bash
# Usage: check_prose.sh <file.md|file.tex> [more files...]
#
# Greps doc prose for the banned lists in doc/CLAUDE.md §1 Language:
#   1. em dashes, in --- or Unicode form
#   2. the banned-word list
#   3. self-justifying framing about our own honesty
#   4. capitals as emphasis (\b[A-Z]{4,}\b)
#   5. the greppable AI writing patterns, per
#      .claude/skills/verify-paper/references/ai-writing-patterns.md §1, §2, §3, §8 and filler
# Fenced code blocks are excluded (they may quote logs and protocol tokens verbatim).
# Any hit is a rewrite, not an allowlist entry. Exit 1 if anything matches.
#
# The patterns needing a count rather than a match (rule of three, synonym cycling, false ranges,
# aphorism formulas, staccato runs) cannot be grepped; read for those against the reference file.

set -u
[ $# -ge 1 ] || { echo "usage: check_prose.sh <file> [...]"; exit 2; }

BANNED='\bdelve\b|\bcrucial\b|\bpivotal\b|\brobust\b|\bleverage\b|\butilize\b|\bshowcase\b|\bcomprehensive\b|\bnotably\b|\bimportantly\b|\binterestingly\b|it is worth noting|this allows us to|in summary|in conclusion'
SELFJUST='reported honestly|whatever it shows|not hidden|visible not|to be fair|we do not hide|we do not soften|reported transparently|even when unflattering'
# §1 inflated significance, §8 authority tropes, and filler: content-free by construction.
INFLATED='plays a (key|vital|significant|central) role|underscor(es|ing) the (importance|significance)|is a testament|marks a (shift|turning point)|represents a (shift|turning point)|reflects (a )?broader|sets the stage for|evolving landscape|indelible mark|deeply rooted|the real question is|at its core|what really matters|the deeper issue|the heart of the matter|\bfundamentally,|in order to\b|due to the fact that|at this point in time|has the ability to|in the event that'
# §2 -ing clause tacked onto a finished sentence: comma plus a depth-signalling participle.
INGCLAUSE=', (highlighting|underscoring|emphasizing|showcasing|reflecting|symbolizing|demonstrating|contributing to|illustrating|exemplifying|cultivating|fostering|encompassing)\b'
# §3 copula avoidance: an elaborate verb standing in for "is" or "has".
COPULA='\b(serves|stands|functions) as\b|\bboasts\b'

fail=0
for FILE in "$@"; do
    PROSE=$(awk '/^```/{code=!code; next} !code' "$FILE")

    hits=$(grep -n $'—' <<<"$PROSE"; grep -n -- '---' <<<"$PROSE" | grep -v '^\s*[0-9]*:---\s*$')
    if [ -n "$hits" ]; then
        echo "=== $FILE: em dashes (use commas, colons, parentheses, or split) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -inE "$BANNED" <<<"$PROSE")
    if [ -n "$hits" ]; then
        echo "=== $FILE: banned words (rewrite each) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -inE "$SELFJUST" <<<"$PROSE")
    if [ -n "$hits" ]; then
        echo "=== $FILE: self-justifying framing (show the data instead) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -nE '\b[A-Z]{4,}\b' <<<"$PROSE" | grep -v '^\s*[0-9]*:\s*#')
    if [ -n "$hits" ]; then
        echo "=== $FILE: capitals as emphasis (rewrite so the sentence carries it) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -inE "$INFLATED" <<<"$PROSE")
    if [ -n "$hits" ]; then
        echo "=== $FILE: inflated significance / authority trope / filler (ai-writing-patterns.md 1, 8) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -inE "$INGCLAUSE" <<<"$PROSE")
    if [ -n "$hits" ]; then
        echo "=== $FILE: -ing clause adding depth without a measurement (ai-writing-patterns.md 2) ==="
        echo "$hits"
        fail=1
    fi
    hits=$(grep -inE "$COPULA" <<<"$PROSE")
    if [ -n "$hits" ]; then
        echo "=== $FILE: copula avoidance, use is/has (ai-writing-patterns.md 3) ==="
        echo "$hits"
        fail=1
    fi
done

[ "$fail" -eq 0 ] && echo "clean: no em dashes, banned words, self-justifying framing, shouting caps, or greppable AI writing patterns"
exit "$fail"
