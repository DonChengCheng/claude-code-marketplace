# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin marketplace containing two plugins:
- **work-report**: Work report generation (daily/weekly/monthly reports)
- **developer-toolkit**: Git workflow tools (commit, MR summary, GitLab MR creation)

## Architecture

### Plugin Structure

Each plugin follows this structure:
```
plugins/<plugin-name>/
├── .claude-plugin/plugin.json   # Plugin metadata
├── commands/                     # Slash commands (*.md files)
├── skills/                       # Skills with SKILL.md definitions
├── agents/                       # Agent definitions (dev-tools only)
├── hooks/                        # Hooks configuration (hooks.json)
└── README.md
```

### Key Configuration Files

- `.claude-plugin/marketplace.json`: Root marketplace config listing all plugins
- `plugins/*/​.claude-plugin/plugin.json`: Individual plugin metadata
- `plugins/work-report/hooks/hooks.json`: PreToolUse hook for Bash command protection

### Git Workflow Commands (developer-toolkit)

The developer-toolkit plugin provides Git workflow commands:
- `/devkit:commit`: Auto-generate commit message and create Git commit
- `/devkit:mr-summary`: Generate MR summary document
- `/devkit:create-mr`: Create GitLab Merge Request

### Skill Invocation Pattern

Skills are invoked via the Task tool:
```
Task({
  subagent_type: "plugin-name:skill-name",
  description: "Task description",
  prompt: "..."
})
```

Commands delegate to skills using the Skill tool:
```yaml
---
allowed-tools: [Skill]
---
请使用 **plugin-name:skill-name** skill...
```

### Skill Progressive Disclosure

Skills use a three-level loading system:
1. **Metadata** (name + description) - Always in context
2. **SKILL.md body** - When skill triggers
3. **references/** - As needed (templates, detailed docs)

Keep SKILL.md concise; move detailed templates to `references/` subdirectory.

### Shared Resources

Work-report skills share common documentation in `plugins/work-report/skills/shared/`:
- `task-type-rules.md`: Task classification rules
- `table-fields.md`: Report table field specifications
- `date-calculation.md`: Date handling logic
- `git-import-guide.md`: Git commit import procedures

## Development Guidelines

### Adding a New Plugin

1. Create `plugins/<name>/.claude-plugin/plugin.json`
2. Add plugin entry to `.claude-plugin/marketplace.json`
3. Create commands in `plugins/<name>/commands/` as markdown files
4. Create skills in `plugins/<name>/skills/<skill-name>/SKILL.md`

### Command File Format

```yaml
---
description: Command description
allowed-tools: [Tool1, Tool2]
argument-hint: [optional-args]
---

Command prompt content...
```

### Skill File Format (SKILL.md)

```yaml
---
name: skill-name
description: When to use this skill
allowed-tools: Read, Write, Edit, Bash, etc.
---

# Skill Title

Detailed instructions for the skill...
```

### Agent File Format

```yaml
---
name: agent-name
color: purple
description: Agent description with usage examples...
---

# Agent behavior and capabilities...
```

## Hooks

The work-report plugin includes a PreToolUse hook that prevents `cd` commands in Bash to protect the working directory during multi-project workflows. The hook script is at `plugins/work-report/hooks/scripts/pre-bash.sh`.
