#!/usr/bin/env bash
# Builds the publishable site into _site/: the project's app plus the kit page in kit/.
# A shadcn project (package.json) is built with Vite. An older static project copies site/.
# Run from the project root.
set -euo pipefail
if [ -f package.json ]; then
  [ -d node_modules ] || npm ci --no-audit --no-fund --loglevel=error
  npx --no-install vite build --outDir _site --emptyOutDir --logLevel warn
else
  rm -rf _site
  mkdir -p _site
  cp -R site/. _site/
fi

# The kit page shows how this prototype was built: house rules, skills and the latest check results.
rm -rf _site/kit
mkdir -p _site/kit
report="$(mktemp)"
BUILDKIT_REPORT="$report" .core/hooks/checks/run.sh >/dev/null 2>&1 || true
cp .core/kit/index.html .core/kit/kit.css .core/kit/kit.js _site/kit/
python3 .core/scripts/kit-data.py .core "$report" _site/kit/kit.json
rm -f "$report"

touch _site/.nojekyll
echo "Built _site/ ($(find _site -type f | wc -l | tr -d ' ') files)"
