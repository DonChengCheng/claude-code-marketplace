---
description: 引导式功能开发流程，自动协调架构设计、代码实现、代码审查和清理
argument-hint: Optional feature description
allowed-tools: Skill, Task, Read, Glob, Grep, Bash, Write, Edit, TodoWrite, AskUserQuestion
---

# Feature Development Command

This command triggers the complete feature development workflow skill, which orchestrates multiple specialized agents through a structured development process.

## Workflow Overview

The command activates the `feature-development-workflow` skill which guides the user through:

1. **Requirements Gathering** - Understand what needs to be built
2. **Architecture Design** - Design via `feature-architect` agent
3. **Implementation** - Code via `code-implementation-specialist` agent (TDD)
4. **Code Review** - Review via `code-review-specialist` agent
5. **Cleanup** - Clean via `code-cleanup` agent

## Usage

```
/dev-tools:develop-feature [feature description]
```

## Instructions

When this command is invoked:

1. **Load the skill**: Use the Skill tool to load `feature-development-workflow` skill
2. **Pass the context**: Include any feature description provided as argument
3. **Follow the workflow**: Let the skill guide the complete development process

## Examples

```
/dev-tools:develop-feature 实现用户认证功能
/dev-tools:develop-feature Add a notification system with email and push support
/dev-tools:develop-feature
```

If no argument provided, the skill will ask for requirements interactively.
