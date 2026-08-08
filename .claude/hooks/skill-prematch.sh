#!/usr/bin/env bash
# UserPromptSubmit hook: match the prompt against bilingual keyword lists and remind Claude
# which skill covers the task (root CLAUDE.md "Enforcement"). Ported in idea from
# claude-scholar's skill-forced-eval hook; kept minimal: only skills whose keywords hit are
# named, and no output at all when nothing matches. Keyword lists mirror each skill's
# description; update both together.

set -u
PROMPT=$(jq -r '.prompt // empty' 2>/dev/null)
[ -z "$PROMPT" ] && exit 0

matches=""
add() { matches="${matches:+$matches, }$1"; }

ci() { grep -qiE "$1" <<<"$PROMPT"; }

ci '进展|进度|什么情况|status|where are we|how is it going|progress' && add "progress-report"
ci 'weekly|周报|update\.md|weekly_update' && add "weekly-update (or weekly-slides for a live talk)"
ci 'slides|deck|beamer|讲|汇报ppt|幻灯' && add "weekly-slides"
ci '这篇|读.{0,4}(paper|论文)|arxiv\.org|看一下这个paper|related.?papers' && add "read-paper"
ci '图|figure|plot|画|visualize|matplotlib|chart' && add "scientific-figure-making"
ci '加.{0,6}(paper|论文)|add.{0,15}(paper|result)|write.{0,8}paper|paper\.md|proposal\.md|main\.tex|abstract|introduction|rebuttal|改论文|写论文|润色' && add "write-paper (style.md before drafting)"
ci '删|清理|delete|dead code|remove.*(file|script)|clean.?up|tidy' && add "cleanup"

[ -z "$matches" ] && exit 0
cat <<EOF
<skill-prematch>Keyword match suggests these skills may apply: ${matches}. Invoke the matching skill before starting, or proceed if the match is spurious (keyword hit but the task is different).</skill-prematch>
EOF
exit 0
