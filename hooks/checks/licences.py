"""Reads package folders from `npm ls --parseable` and prints any whose licence is not allowed."""
import json, os, sys

ALLOWED = {"MIT", "ISC", "Apache-2.0", "BSD-2-Clause", "BSD-3-Clause", "0BSD", "CC0-1.0", "Unlicense",
           "BlueOak-1.0.0", "MPL-2.0", "Python-2.0", "CC-BY-4.0"}

bad = 0
root = os.getcwd()
for path in sorted(set(sys.stdin.read().split())):
    if os.path.abspath(path) == root:
        continue
    try:
        with open(os.path.join(path, "package.json"), encoding="utf-8") as f:
            pkg = json.load(f)
    except Exception:
        continue
    lic = pkg.get("license") or (pkg.get("licenses") or [{}])[0].get("type", "")
    if isinstance(lic, dict):
        lic = lic.get("type", "")
    parts = {p.strip("() ") for p in str(lic).replace(" AND ", " OR ").split(" OR ")}
    if not lic or not parts & ALLOWED:
        print(f"{pkg.get('name')}@{pkg.get('version')}: licence {lic or 'unknown'} is not on the allowed list")
        bad = 1
sys.exit(bad)
