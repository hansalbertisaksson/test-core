# Claude Code adapter

Projects wire this up in `.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.core/hooks/adapters/claude/after-edit.sh" }]
      }
    ]
  }
}
```

GitHub Copilot reads `AGENTS.md` and the skills, and CI runs the same checks on every push, so it needs no adapter of its own for now.
