#!/usr/bin/env bash
# Builds the publishable site: site/ plus the shared design files in core/ and the kit page in kit/.
# Run from the project root. Output goes to _site/.
set -euo pipefail
rm -rf _site
mkdir -p _site
cp -R site/. _site/
rm -rf _site/core _site/kit
mkdir -p _site/core _site/kit
cp .core/design/tokens.css .core/design/base.css _site/core/

# The kit page shows how this prototype was built: house rules, skills and the latest check results.
report="$(mktemp)"
BUILDKIT_REPORT="$report" .core/hooks/checks/run.sh >/dev/null 2>&1 || true
cp .core/kit/index.html .core/kit/kit.css .core/kit/kit.js _site/kit/
python3 .core/scripts/kit-data.py .core "$report" _site/kit/kit.json
rm -f "$report"

touch _site/.nojekyll
echo "Built _site/ ($(find _site -type f | wc -l | tr -d ' ') files)"
