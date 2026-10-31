#!/bin/bash
# Stop hook: before Claude finishes, asks it to run one simplification pass
# (.claude/hooks/simplify-prompt.md) over the branch's diff against master.
#
# Skips when the branch has no changes against master, when Claude is already
# continuing because of this hook (stop_hook_active), and when the diff is the
# same one the last pass ended on, so each change is simplified once.
set -uo pipefail

cd "$CLAUDE_PROJECT_DIR" || exit 0
input=$(cat)

base=$(git merge-base HEAD origin/master 2>/dev/null) || exit 0
state_file="$(git rev-parse --git-dir)/claude-simplify-diff"
diff_hash=$( { git diff "$base"; git ls-files --others --exclude-standard; } | git hash-object --stdin)

if printf '%s' "$input" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  printf '%s\n' "$diff_hash" > "$state_file"
  exit 0
fi

if git diff --quiet "$base" && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  exit 0
fi

if [ "$(cat "$state_file" 2>/dev/null)" = "$diff_hash" ]; then
  exit 0
fi

cat "$CLAUDE_PROJECT_DIR/.claude/hooks/simplify-prompt.md" >&2
exit 2
