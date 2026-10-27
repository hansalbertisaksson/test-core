# Claude Code adapter

Three hooks, wired up in each project's `.claude/settings.json`:

| Hook | Script | What it does |
| --- | --- | --- |
| `SessionStart` | project `scripts/session-start.sh`, then `session-start.sh` | Fetches the core, starts the preview at localhost:8000. New project: tells Claude to run the kickoff questions. Existing project: hands Claude the brief. |
| `PreToolUse` on Write/Edit | `before-edit.sh` | Locks `site/` until the brief exists. Keeps `.core/` read-only. |
| `PostToolUse` on Write/Edit | `after-edit.sh` | Rebuilds the preview and runs the checks after every edit. A blocking failure goes back to Claude to fix. |

```json
{
  "hooks": {
    "SessionStart": [
      { "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/scripts/session-start.sh" }] }
    ],
    "PreToolUse": [
      { "matcher": "Write|Edit|MultiEdit", "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.core/hooks/adapters/claude/before-edit.sh" }] }
    ],
    "PostToolUse": [
      { "matcher": "Write|Edit|MultiEdit", "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.core/hooks/adapters/claude/after-edit.sh" }] }
    ]
  }
}
```

GitHub Copilot has no hooks like these yet. It reads `AGENTS.md`, whose first rule asks for the brief before building, and CI runs the same checks on every push.
