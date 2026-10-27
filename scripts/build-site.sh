#!/usr/bin/env bash
# Builds the publishable site: site/ plus the shared design files in core/.
# Run from the project root. Output goes to _site/.
set -euo pipefail
rm -rf _site
mkdir -p _site
cp -R site/. _site/
rm -rf _site/core
mkdir -p _site/core
cp .core/design/tokens.css .core/design/base.css _site/core/
touch _site/.nojekyll
echo "Built _site/ ($(find _site -type f | wc -l | tr -d ' ') files)"
