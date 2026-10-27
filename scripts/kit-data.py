"""Writes kit.json for the kit page: house rules, skills, checks, profile and latest results.

Usage: python3 kit-data.py <core dir> <report file> <output file>
"""
import json, os, re, subprocess, sys
from datetime import datetime, timezone

core, report_path, out = sys.argv[1:4]

def read(path):
    with open(path, encoding="utf-8") as f:
        return f.read()

def git(*args, cwd="."):
    try:
        return subprocess.check_output(["git", *args], cwd=cwd, text=True, stderr=subprocess.DEVNULL).strip()
    except Exception:
        return ""

def first_list(text):
    """The first numbered or bulleted list in a piece of markdown."""
    items, started = [], False
    for line in text.splitlines():
        m = re.match(r"^(?:\d+\.|-)\s+(.+)$", line)
        if m:
            items.append(m.group(1))
            started = True
        elif started and line.strip() and not line.startswith(" "):
            break
    return items

skills = []
skills_dir = os.path.join(core, "skills")
for name in sorted(os.listdir(skills_dir)):
    path = os.path.join(skills_dir, name, "SKILL.md")
    if not os.path.isfile(path):
        continue
    text = read(path)
    meta = dict(re.findall(r"^(\w+):\s*(.+)$", text.split("---")[1], re.M)) if text.startswith("---") else {}
    body = text.split("---", 2)[2] if text.startswith("---") else text
    steps = first_list(body)
    questions_part = body.split("## The questions", 1)
    questions = [re.sub(r"^\*\*(.+?)\*\*\s*", r"\1 ", q) for q in first_list(questions_part[1])] if len(questions_part) == 2 else []
    skills.append({"name": meta.get("name", name), "description": meta.get("description", ""), "steps": steps, "questions": questions})

profile = "prototype"
if os.path.isfile(".buildkit"):
    m = re.search(r"^profile=(\S+)", read(".buildkit"), re.M)
    profile = m.group(1) if m else profile

def check_description(check):
    lines = read(os.path.join(core, "hooks", "checks", check + ".sh")).splitlines()
    return next((l.lstrip("# ").strip() for l in lines[1:] if l.startswith("#")), "")

profiles = {}
order = ["prototype", "internal", "client"]
for f in sorted(os.listdir(os.path.join(core, "hooks", "profiles")), key=lambda f: (order.index(f[:-5]) if f[:-5] in order else 99, f)):
    rows = []
    for line in read(os.path.join(core, "hooks", "profiles", f)).splitlines():
        parts = line.split()
        if len(parts) == 2 and not line.startswith("#"):
            rows.append({"mode": parts[0], "check": parts[1]})
    profiles[f.removesuffix(".conf")] = rows

results = {}
if os.path.isfile(report_path):
    for line in read(report_path).splitlines():
        check, mode, result, message = (line.split("\t") + [""] * 4)[:4]
        results[check] = {"result": result, "message": message.strip()}

checks = [
    {**row, "description": check_description(row["check"]), **results.get(row["check"], {"result": "not run", "message": ""})}
    for row in profiles.get(profile, [])
]

data = {
    "profile": profile,
    "profiles": profiles,
    "house_rules": read(os.path.join(core, "AGENTS.md")),
    "skills": skills,
    "checks": checks,
    "core_version": git("rev-parse", "--short", "HEAD", cwd=core),
    "project_version": git("rev-parse", "--short", "HEAD"),
    "repository": os.environ.get("GITHUB_REPOSITORY", ""),
    "built_at": datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC"),
}
with open(out, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
print(f"Wrote {out}: {len(skills)} skills, {len(checks)} checks")
