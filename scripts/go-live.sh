#!/usr/bin/env bash
# Finishes a new project after it has been created and cloned: waits for the first build,
# switches on the live link and prints READY. Run from the project folder.
# Safe to run again after a failed run.
set -uo pipefail
say() { printf '%s\n' "$*"; }
fail() { say "STOPPED: $*"; exit 1; }

command -v gh >/dev/null || fail "the GitHub CLI is not installed"
url="$(git remote get-url origin)"
repo="$(printf %s "$url" | sed -E 's#^(https://github.com/|git@github.com:)##; s#\.git$##')"
owner="${repo%%/*}"
name="${repo#*/}"
profile="$(sed -n 's/^profile=//p' .buildkit 2>/dev/null | head -1)"

if [ "$profile" = "client" ]; then
  say "READY"
  say "folder: $(pwd)"
  say "repo:   https://github.com/$repo (private, no public link)"
  exit 0
fi

say "Waiting for the first build (about a minute)"
for i in $(seq 1 60); do
  gh api "repos/$repo/branches/gh-pages" >/dev/null 2>&1 && break
  sleep 5
done
gh api "repos/$repo/branches/gh-pages" >/dev/null 2>&1 || fail "the first build did not finish. Check https://github.com/$repo/actions"

say "Switching on the live link"
if ! gh api "repos/$repo/pages" >/dev/null 2>&1; then
  err="$(gh api -X POST "repos/$repo/pages" -f "source[branch]=gh-pages" -f "source[path]=/" 2>&1 >/dev/null)" \
    || fail "could not switch on GitHub Pages ($err). Open https://github.com/$repo/settings/pages and choose the gh-pages branch"
fi

live="https://$(printf %s "$owner" | tr '[:upper:]' '[:lower:]').github.io/$name/"
say ""
say "READY"
say "folder: $(pwd)"
say "repo:   https://github.com/$repo"
say "live:   $live (can take another minute the first time)"
say "kit:    ${live}kit/"
