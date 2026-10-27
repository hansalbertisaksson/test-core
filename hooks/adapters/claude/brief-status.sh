#!/usr/bin/env bash
# Prints "missing" if docs/brief.md is not filled in yet, otherwise "ready".
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}" || exit 0
if [ ! -f docs/brief.md ] || grep -q "Not filled in yet" docs/brief.md; then
  echo missing
else
  echo ready
fi
