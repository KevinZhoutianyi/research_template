#!/usr/bin/env bash
# Usage: check_language.sh <update.md>
#
# Greps a weekly update's PROSE (fenced code blocks excluded, since they may quote
# logs verbatim) for the two banned lists in the weekly-update skill:
#   1. research slang / metaphor (§3)
#   2. self-justifying framing about our own honesty (§7; style home: write-paper references/style.md)
# Any hit is a rewrite, not an allowlist entry. Exit 1 if anything matches.

set -u
FILE="${1:?usage: check_language.sh <update.md>}"

# Strip fenced code blocks, HTML comments (editor-facing notes, dropped from any paste), and
# inline code spans (literals), then grep. awk toggles on ``` lines.
PROSE=$(awk '/^```/{code=!code; next} !code' "$FILE" \
    | awk '/<!--/{c=1} c{ if (/-->/){c=0}; next } 1' \
    | sed 's/`[^`]*`//g')

METAPHORS='\bknob\b|\blever\b|\bstandout\b|a wash|cashes out|fires the falsifier|\blanded\b|\bcell\b|\barm\b|\bharness\b|\bslice\b'
SELFJUST='honest|whatever it shows|not hidden|visible not|to be fair|we do not hide|we do not soften|transparent|unflattering'

fail=0
hits=$(grep -inE "$METAPHORS" <<<"$PROSE")
if [ -n "$hits" ]; then
    echo "=== banned metaphors (rewrite literally) ==="
    echo "$hits"
    fail=1
fi
hits=$(grep -inE "$SELFJUST" <<<"$PROSE")
if [ -n "$hits" ]; then
    echo "=== self-justifying framing (lead with the finding, state the number as fact) ==="
    echo "$hits"
    fail=1
fi

[ "$fail" -eq 0 ] && echo "clean: no banned metaphors or self-justifying framing in prose"
exit "$fail"
