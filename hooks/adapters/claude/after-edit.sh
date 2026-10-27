#!/usr/bin/env bash
# Claude Code adapter. Runs after Claude writes or edits a file (PostToolUse hook).
# Rebuilds the local preview, then runs the checks.
# Exit code 2 sends the output back to Claude so it fixes the cause.
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 0
[ -x .core/hooks/checks/run.sh ] || exit 0
.core/scripts/build-site.sh >/dev/null 2>&1
output="$(.core/hooks/checks/run.sh 2>&1)" && exit 0
printf '%s\n' "$output" >&2
exit 2
