#!/usr/bin/env bash
# Flags hard-coded colours so everything visual comes from the theme in src/index.css.
# Catches hex, rgb, hsl and oklch values, and Tailwind palette classes like bg-blue-500.
pattern='#[0-9a-fA-F]{3,8}\b|rgba?\(|hsla?\(|oklch\(|\b(bg|text|border|ring|fill|stroke|from|via|to|outline|divide|shadow|accent|caret|decoration)-(slate|gray|zinc|neutral|stone|red|orange|amber|yellow|lime|green|emerald|teal|cyan|sky|blue|indigo|violet|purple|fuchsia|pink|rose|black|white)(-[0-9]{2,3})?\b'
found=0
while read -r f; do
  case "$f" in
    src/index.css|src/components/ui/*) continue ;;
    src/*.ts|src/*.tsx|src/*.css|site/*.css|site/*.html) ;;
    src/*/*.ts|src/*/*.tsx|src/*/*.css|site/*/*.css|site/*/*.html) ;;
    *) continue ;;
  esac
  if grep -n -E "$pattern" "$f" >/dev/null 2>&1; then
    grep -n -E "$pattern" "$f" | cut -d: -f1 | sed "s|^|$f:|; s|$|: hard-coded colour, use a theme colour like bg-primary or text-muted-foreground|"
    found=1
  fi
done <<< "$FILES"
exit $found
