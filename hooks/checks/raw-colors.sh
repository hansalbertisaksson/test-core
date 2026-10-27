#!/usr/bin/env bash
# Flags hard-coded colours in site/ so everything visual comes from the design tokens.
pattern='#[0-9a-fA-F]{3,8}\b|rgba?\(|hsla?\('
found=0
while read -r f; do
  case "$f" in site/*.css|site/*.html|site/*/*.css|site/*/*.html) ;; *) continue ;; esac
  if grep -n -E "$pattern" "$f" >/dev/null 2>&1; then
    grep -n -E "$pattern" "$f" | cut -d: -f1 | sed "s|^|$f:|; s|$|: hard-coded colour, use var(--color-*)|"
    found=1
  fi
done <<< "$FILES"
exit $found
