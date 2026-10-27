#!/usr/bin/env bash
# Creates a new prototype from the template, switches GitHub Pages on, clones it and sets it up.
# Usage: new-prototype.sh <repo-name> [folder to clone into, default ~/GitHub]
# Needs the GitHub CLI (gh), logged in once with: gh auth login
set -uo pipefail

TEMPLATE="hansalbertisaksson/template-prototype"
name="${1:-}"
parent="${2:-$HOME/GitHub}"

say() { printf '%s\n' "$*"; }
fail() { say "STOPPED: $*"; exit 1; }

[ -n "$name" ] || fail "no name given. Usage: new-prototype.sh <repo-name>"
[[ "$name" =~ ^[a-z0-9][a-z0-9-]{1,60}$ ]] || fail "the name must be lowercase letters, digits and dashes, like coffee-club-prototype"
command -v gh >/dev/null || fail "the GitHub CLI is not installed. On a Mac: brew install gh, then gh auth login"
gh auth status >/dev/null 2>&1 || fail "not logged in to GitHub. Run: gh auth login (choose GitHub.com, HTTPS, log in with a browser)"

owner="$(gh api user --jq .login)" || fail "could not read your GitHub user"
repo="$owner/$name"
folder="$parent/$name"
[ -e "$folder" ] && fail "$folder already exists. Pick another name."
gh repo view "$repo" >/dev/null 2>&1 && fail "$repo already exists on GitHub. Pick another name."

say "1/4 Creating $repo from the template"
gh repo create "$repo" --template "$TEMPLATE" --public --description "Prototype built with the Build Kit" >/dev/null || fail "could not create the repo"

say "2/4 Copying it to $folder"
mkdir -p "$parent"
for i in 1 2 3 4 5 6; do
  gh repo clone "$repo" "$folder" -- -q 2>/dev/null && break
  sleep 3
done
[ -d "$folder/.git" ] || fail "could not clone $repo"
(cd "$folder" && ./scripts/setup.sh) || fail "could not fetch the shared core"

say "3/4 Waiting for the first build (about a minute)"
for i in $(seq 1 60); do
  gh api "repos/$repo/branches/gh-pages" >/dev/null 2>&1 && break
  sleep 5
done
gh api "repos/$repo/branches/gh-pages" >/dev/null 2>&1 || fail "the first build did not finish. Check https://github.com/$repo/actions"

say "4/4 Switching on the live link"
if ! gh api "repos/$repo/pages" >/dev/null 2>&1; then
  gh api -X POST "repos/$repo/pages" -f "source[branch]=gh-pages" -f "source[path]=/" >/dev/null 2>&1 \
    || fail "could not switch on GitHub Pages. Open https://github.com/$repo/settings/pages and choose the gh-pages branch"
fi

url="https://$(printf %s "$owner" | tr "[:upper:]" "[:lower:]").github.io/$name/"
say ""
say "READY"
say "folder: $folder"
say "repo:   https://github.com/$repo"
say "live:   $url (can take another minute the first time)"
say "kit:    ${url}kit/"
