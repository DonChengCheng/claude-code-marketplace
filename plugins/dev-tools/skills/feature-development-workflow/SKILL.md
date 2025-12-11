---
name: feature-development-workflow
description: 当用户需要开发新功能、实现完整的开发流程、协调多个开发阶段时使用此技能。该技能定义了从需求分析到代码清理的完整开发工作流，在各阶段自动调用相应的专家Agent（feature-architect、code-implementation-specialist、code-review-specialist、code-cleanup）。
allowed-tools: Task, Read, Write, Edit, Glob, Grep, Bash, TodoWrite, AskUserQuestion
---

# Feature Development Workflow

This skill orchestrates a complete feature development lifecycle by coordinating specialized agents at each phase. Follow this workflow to ensure consistent, high-quality feature delivery.

## Workflow Phases

### Phase 1: Requirements & Context Gathering

Before invoking any agent, gather essential information:

1. **Understand the Feature Request**
   - What functionality needs to be built?
   - What problem does it solve?
   - Who are the users?

2. **Analyze Codebase Context**
   - Use Glob and Grep to understand existing patterns
   - Identify integration points
   - Check for similar existing implementations

3. **Clarify Ambiguities**
   - Use AskUserQuestion for unclear requirements
   - Confirm scope boundaries
   - Identify acceptance criteria

**Output**: Clear feature specification ready for architecture design

---

### Phase 2: Architecture Design

Invoke the `feature-architect` agent to design the solution:

```
Use Task tool with:
- subagent_type: "dev-tools:feature-architect"
- prompt: Include feature requirements, codebase context, constraints
```

**feature-architect will**:
- Analyze existing architecture
- Design component structure
- Plan data models and APIs
- Create implementation strategy
- Output: Design document with file paths and implementation order

**Quality Gate**: Review design before proceeding
- Does it fit existing patterns?
- Is the scope manageable?
- Are dependencies identified?

---

### Phase 3: Implementation (TDD)

Invoke the `code-implementation-specialist` agent:

```
Use Task tool with:
- subagent_type: "dev-tools:code-implementation-specialist"
- prompt: Include design document, file paths, implementation order
```

**code-implementation-specialist will**:
- Create execution plan (user approves)
- Write tests first (RED phase)
- Implement minimal code (GREEN phase)
- Refactor for quality (REFACTOR phase)
- Run verification suite
- Auto-fix errors (up to 3 attempts)
- Output: Implemented code with tests

**Quality Gate**: All tests must pass before proceeding

---

### Phase 4: Code Review

Invoke the `code-review-specialist` agent:

```
Use Task tool with:
- subagent_type: "dev-tools:code-review-specialist"
- prompt: Include files changed, implementation context, focus areas
```

**code-review-specialist will**:
- Analyze code quality
- Check security vulnerabilities
- Verify best practices
- Identify potential issues
- Output: Review report with severity ratings

**Quality Gate**: No Critical or High severity issues
- If issues found: Fix them, then re-review
- If blocked: Invoke `debug-specialist` for complex issues

---

### Phase 5: Code Cleanup

Invoke the `code-cleanup` agent:

```
Use Task tool with:
- subagent_type: "dev-tools:code-cleanup"
- prompt: Include files touched during development
```

**code-cleanup will**:
- Analyze git history for failed fix attempts
- Remove debug statements
- Clean unused imports
- Remove commented code
- Output: Cleanup summary

**Quality Gate**: Code is clean and ready for commit

---

### Phase 6: Completion

After all phases complete successfully:

1. **Summary Report**
   - List all files created/modified
   - Summarize key decisions made
   - Note any deferred items

2. **Suggest Next Steps**
   - Run full test suite
   - Create git commit
   - Consider PR creation

---

## Agent Invocation Patterns

### Pattern: Sequential with Gates

```
Phase 2 (feature-architect)
    ↓ [Quality Gate: Design approved]
Phase 3 (code-implementation-specialist)
    ↓ [Quality Gate: Tests pass]
Phase 4 (code-review-specialist)
    ↓ [Quality Gate: No critical issues]
Phase 5 (code-cleanup)
    ↓ [Quality Gate: Code clean]
Complete
```

### Pattern: Error Recovery

If implementation fails:
```
code-implementation-specialist (3 attempts)
    ↓ [Still failing]
debug-specialist (diagnose)
    ↓ [Fix strategy]
code-implementation-specialist (retry)
```

If review finds issues:
```
code-review-specialist (issues found)
    ↓ [Critical/High issues]
Fix issues manually or with debug-specialist
    ↓
code-review-specialist (re-review)
```

---

## Task Tool Invocation Examples

### Invoking feature-architect

```javascript
Task({
  subagent_type: "dev-tools:feature-architect",
  description: "Design authentication feature",
  prompt: `
    Feature: User authentication with social login

    Requirements:
    - Support Google and GitHub OAuth
    - JWT token management
    - Session handling

    Codebase Context:
    - Express.js backend at /src/server
    - React frontend at /src/client
    - PostgreSQL database

    Please design the architecture and create an implementation plan.
  `
})
```

### Invoking code-implementation-specialist

```javascript
Task({
  subagent_type: "dev-tools:code-implementation-specialist",
  description: "Implement auth feature",
  prompt: `
    Implement the authentication feature based on this design:

    [Insert design document from feature-architect]

    Implementation Order:
    1. Database models (src/models/user.js)
    2. Auth service (src/services/auth.js)
    3. API routes (src/routes/auth.js)
    4. Frontend components (src/client/components/Auth/)

    Use TDD approach. Write tests first.
  `
})
```

### Invoking code-review-specialist

```javascript
Task({
  subagent_type: "dev-tools:code-review-specialist",
  description: "Review auth implementation",
  prompt: `
    Review the authentication implementation:

    Files Changed:
    - src/models/user.js
    - src/services/auth.js
    - src/routes/auth.js
    - src/client/components/Auth/*

    Focus Areas:
    - Security: Password hashing, token handling
    - Error handling: Auth failures, edge cases
    - Performance: Database queries, token validation
  `
})
```

### Invoking code-cleanup

```javascript
Task({
  subagent_type: "dev-tools:code-cleanup",
  description: "Clean auth implementation",
  prompt: `
    Clean up the authentication implementation:

    Files to check:
    - src/models/user.js
    - src/services/auth.js
    - src/routes/auth.js
    - src/client/components/Auth/*

    Look for:
    - Debug console.log statements
    - Commented test code
    - Unused imports
    - Failed fix attempts in git history
  `
})
```

---

## Progress Tracking

Use TodoWrite throughout the workflow:

```javascript
TodoWrite({
  todos: [
    { content: "Gather requirements", status: "completed", activeForm: "Gathering requirements" },
    { content: "Design architecture (feature-architect)", status: "in_progress", activeForm: "Designing architecture" },
    { content: "Implement with TDD (code-implementation-specialist)", status: "pending", activeForm: "Implementing code" },
    { content: "Code review (code-review-specialist)", status: "pending", activeForm: "Reviewing code" },
    { content: "Cleanup (code-cleanup)", status: "pending", activeForm: "Cleaning up code" },
    { content: "Final summary and commit", status: "pending", activeForm: "Finalizing" }
  ]
})
```

---

## Best Practices

1. **Always gather context first** - Don't rush to invoke agents without understanding the codebase
2. **Respect quality gates** - Don't skip reviews even if implementation seems correct
3. **Pass complete context** - Agents work better with full information
4. **Track progress visibly** - Use TodoWrite so user sees workflow state
5. **Handle errors gracefully** - Use debug-specialist when stuck
6. **Commit incrementally** - Consider commits after each major phase

---

## Troubleshooting

### Agent returns incomplete results
- Provide more context in the prompt
- Break down into smaller tasks
- Check if codebase exploration is needed first

### Quality gate keeps failing
- Review the specific failures
- Consider if requirements need adjustment
- Use debug-specialist for persistent issues

### Workflow takes too long
- Consider parallel execution where possible
- Focus on MVP scope first
- Defer non-critical improvements
