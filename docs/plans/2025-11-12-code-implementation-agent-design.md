# Code Implementation Specialist Agent - Design Document

**Date:** 2025-11-12
**Status:** Approved
**Author:** Collaborative design session

---

## Overview

The `code-implementation-specialist` is an autonomous code implementation agent that transforms architectural designs and implementation plans into working code using Test-Driven Development (TDD). It replaces manual coding steps in the workflow-orchestrator, creating a fully automated development pipeline: design → auto-implement → review → cleanup.

**Design Goal:** Enable full autonomous implementation of features and bug fixes while maintaining high code quality through TDD, comprehensive verification, and quality gates.

---

## Section 1: Agent Identity and Core Responsibilities

### Agent Name
`code-implementation-specialist`

### Description
Autonomous code implementation agent that transforms architectural designs and implementation plans into working code using Test-Driven Development. Handles full feature implementation from test writing to verification, with built-in error recovery and user consultation for ambiguous decisions.

### Core Responsibilities

#### 1. Plan Interpretation
Parse implementation plans from feature-architect or fix strategies from debug-specialist into granular, file-level tasks.

#### 2. Execution Planning
Create transparent execution plan showing:
- Files to create/modify
- Test files to write
- Dependencies to install
- Order of implementation
- Estimated complexity per task

#### 3. TDD Implementation
For each component:
- Write comprehensive tests first (unit, integration as needed)
- Implement minimal code to pass tests
- Refactor while keeping tests green
- Document key decisions in code comments

#### 4. Verification Management
Run automated checks:
- Test suite execution
- Linters (ESLint, Pylint, etc.)
- Type checkers (TypeScript, mypy, etc.)
- Build process
- Format checks

#### 5. Error Recovery
Auto-fix compilation errors, test failures, and linting issues using debug-specialist patterns with up to 3 retry attempts.

#### 6. User Consultation
Pause to ask clarifying questions when encountering:
- Ambiguous requirements
- Multiple valid implementation approaches
- Library/framework choices
- Naming conventions not specified in plan
- Data structure decisions

---

## Section 2: Workflow Integration

### Replacement of Manual Pause Steps

The code-implementation-specialist replaces `[MANUAL PAUSE]` stages in these workflows:

#### Feature Development Workflow (Updated)
```
1. feature-architect
   → Outputs: Design doc + implementation plan

2. code-implementation-specialist (NEW - replaces manual pause)
   → Inputs: Implementation plan, design doc
   → Creates execution plan
   → Implements via TDD
   → Runs verification
   → Outputs: Implemented code + test suite + verification report

3. code-review-specialist
   → Reviews code quality, security, best practices
   → Quality Gate: No Critical/High issues

4. [CONDITIONAL] debug-specialist
   → Only if code-review finds significant issues

5. code-cleanup
   → Removes any debug artifacts
```

#### Bug Fix Workflow (Updated)
```
1. debug-specialist
   → Outputs: Root cause analysis + fix strategy

2. code-implementation-specialist (NEW - replaces manual pause)
   → Inputs: Fix strategy, error context
   → Creates execution plan (including regression tests)
   → Implements fix via TDD
   → Runs verification
   → Outputs: Fix code + regression tests + verification report

3. code-review-specialist
   → Verifies fix correctness

4. code-cleanup
   → Clean up debugging code
```

#### Refactoring Workflow (Updated)
```
1. feature-architect (refactoring mode)
   → Outputs: Refactoring plan + migration strategy

2. code-implementation-specialist (NEW)
   → Implements refactoring incrementally
   → Ensures tests pass at each step
   → Runs verification

3. code-review-specialist
   → Validates no functionality regression

4. code-cleanup
```

### Handoff Protocol
- Previous agent (feature-architect/debug-specialist) includes implementation plan in structured format
- code-implementation-specialist confirms receipt and displays execution plan
- User can approve/modify execution plan before coding begins
- Upon completion, passes file list + verification results to next agent

---

## Section 3: Execution Process (TDD Cycle)

### Phase 1: Execution Plan Creation

When code-implementation-specialist receives a plan, it:

#### 1. Parses the plan into discrete tasks

Example Output:
```
📋 Execution Plan for: User Authentication Feature
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task 1: Create user model
  - File: models/user.js
  - Tests: tests/models/user.test.js
  - Complexity: Low

Task 2: Implement password hashing
  - File: utils/crypto.js
  - Tests: tests/utils/crypto.test.js
  - Complexity: Low

Task 3: Create authentication endpoints
  - File: routes/auth.js
  - Tests: tests/routes/auth.test.js
  - Complexity: Medium
  - Dependencies: express, bcrypt

Task 4: Add JWT token generation
  - File: utils/jwt.js
  - Tests: tests/utils/jwt.test.js
  - Complexity: Medium

Total: 4 tasks, 8 files (4 implementation + 4 test)
Estimated time: 15-20 minutes

Proceed with implementation? (yes/modify/cancel)
```

#### 2. Awaits user approval
User can modify order, remove tasks, or request clarification

### Phase 2: TDD Implementation Loop

For each task in the execution plan:

#### Step 1: Write Tests First
- Create test file
- Write test cases covering:
  * Happy path scenarios
  * Edge cases
  * Error conditions
  * Boundary values
- Run tests → Expect failures (RED phase)

#### Step 2: Implement Code
- Create/modify implementation file
- Write minimal code to pass tests
- Run tests → Verify they pass (GREEN phase)
- If tests fail:
  * Attempt auto-fix (up to 3 tries)
  * Use debug-specialist logic to diagnose
  * If still failing → Ask user for guidance

#### Step 3: Refactor
- Improve code quality while keeping tests green
- Remove duplication
- Improve naming
- Add documentation
- Run tests again → Ensure still passing

#### Step 4: Task Completion
- Show progress: `[Task 1/4] ✓ User model implemented`
- Continue to next task

### Phase 3: Verification

After all tasks complete:

#### 1. Run comprehensive verification
```
🔍 Running Verification Suite
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Tests: 24 passed, 0 failed
✓ Linter: No issues
✓ Type check: Passed
✓ Build: Successful
✓ Format: All files formatted
```

#### 2. If verification fails
- Show all errors grouped by type
- Attempt auto-fix for each error category
- Re-run verification
- If still failing after 3 attempts → Escalate to user

#### 3. If verification passes
- Generate summary report
- Proceed to code-review-specialist

---

## Section 4: Error Recovery and User Interaction

### Auto-Fix Strategy (3-Attempt Limit)

When errors occur, the agent follows this protocol:

#### Attempt 1: Pattern-Based Fixes
Common error patterns with automatic fixes:
- Syntax errors → Check matching braces, quotes, semicolons
- Import errors → Add missing imports, fix paths
- Type errors → Add type annotations, fix mismatches
- Undefined variables → Check scope, add declarations
- Test failures → Analyze assertion mismatch, fix logic

#### Attempt 2: Debug-Specialist Logic
If pattern-based fixes fail:
- Analyze stack trace / error message
- Identify root cause using debug-specialist techniques
- Apply targeted fix
- Add test case to prevent regression

#### Attempt 3: Broader Context Analysis
If still failing:
- Review entire file/module context
- Check for architectural misunderstanding
- Verify plan interpretation was correct
- Attempt alternative implementation approach

#### Escalation to User (After 3 Failed Attempts)
```
⚠️ Implementation Issue - Need Guidance
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task: Implement JWT token generation
Error: TypeError: Cannot read property 'sign' of undefined

Attempts made:
  1. Added missing jwt import ✗
  2. Fixed jwt.sign() parameters ✗
  3. Checked jwt library installation ✗

Root cause analysis:
  JWT library not installed in package.json

Options:
  A) Install jsonwebtoken library and retry
  B) Use alternative library (jose, jwt-simple)
  C) Show me the code to review manually
  D) Skip this task for now

Your choice:
```

### User Consultation Scenarios

The agent pauses and asks when encountering:

#### 1. Ambiguous Requirements
```
❓ Clarification Needed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task: Password validation

The plan says "validate password strength" but doesn't specify:
- Minimum length requirement?
- Required character types (uppercase, numbers, symbols)?
- Maximum length limit?

Please specify password rules, or should I use common defaults:
(min 8 chars, 1 uppercase, 1 number, 1 symbol)?
```

#### 2. Library/Framework Choices
```
❓ Implementation Decision
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task: Email sending

Multiple libraries available:
A) nodemailer (most popular, 20k stars)
B) sendgrid (managed service, easier setup)
C) aws-ses (if using AWS already)

Which should I use?
```

#### 3. File/Naming Conventions
```
❓ Naming Convention
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Creating authentication utilities.

Should I use:
A) utils/auth.js (matches existing utils/ pattern)
B) lib/authentication.js (more explicit)
C) services/authService.js (service pattern)

Existing project uses: utils/ for helpers, services/ for business logic

Recommendation: utils/auth.js (matches pattern)
Proceed? (yes/choose different)
```

---

## Section 5: Outputs and Integration Points

### Success Output (Verification Passed)

```
✅ Implementation Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Feature: User Authentication

Files Created (4):
  ✓ models/user.js (85 lines)
  ✓ utils/crypto.js (42 lines)
  ✓ routes/auth.js (120 lines)
  ✓ utils/jwt.js (38 lines)

Test Files Created (4):
  ✓ tests/models/user.test.js (15 tests)
  ✓ tests/utils/crypto.test.js (8 tests)
  ✓ tests/routes/auth.test.js (22 tests)
  ✓ tests/utils/jwt.test.js (12 tests)

Files Modified (2):
  ✓ package.json (added dependencies: bcrypt, jsonwebtoken)
  ✓ routes/index.js (registered auth routes)

Verification Results:
  ✓ Tests: 57 passed, 0 failed
  ✓ Coverage: 94% (target: 80%)
  ✓ Linter: 0 issues
  ✓ Type check: Passed
  ✓ Build: Successful

Key Implementation Decisions:
  - Used bcrypt for password hashing (industry standard)
  - JWT tokens expire in 24h (configurable via env)
  - Added rate limiting on login endpoint (5 attempts/15min)

Next: Proceeding to code-review-specialist...
```

### Partial Success Output (Verification Failed)

```
⚠️ Implementation Complete with Issues
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Feature: User Authentication

Files Implemented: 8 total (see above)

Verification Results:
  ⚠️ Tests: 55 passed, 2 failed
  ✓ Linter: 0 issues
  ✓ Type check: Passed
  ⚠️ Build: Failed (1 error)

Failed Tests:
  1. auth.test.js:45 - Should reject invalid tokens
     Expected: 401 status
     Received: 500 status

  2. user.test.js:23 - Should hash password on save
     Error: bcrypt.hash is not a function

Build Error:
  routes/auth.js:67 - Missing export for verifyToken

Auto-fix attempts: 3/3 (all failed)

Options:
  A) Let debug-specialist analyze and fix issues
  B) Show me the code to fix manually
  C) Proceed to code-review anyway (not recommended)

Your choice:
```

### Integration with Workflow-Orchestrator

The workflow-orchestrator receives structured output:

```yaml
agent: code-implementation-specialist
status: success | partial | failed
verification:
  tests_passed: 57
  tests_failed: 0
  linter_issues: 0
  type_check: passed
  build: success
  coverage: 94
files_changed:
  - models/user.js
  - utils/crypto.js
  - routes/auth.js
  - utils/jwt.js
  - tests/...
dependencies_added:
  - bcrypt@5.1.0
  - jsonwebtoken@9.0.0
decisions_made:
  - "Used bcrypt for password hashing"
  - "JWT tokens expire in 24h"
  - "Added rate limiting on login"
next_stage: code-review-specialist
quality_gate: passed | failed
```

### Context Passed to code-review-specialist

```
Review Context from Implementation:
- Implementation approach: TDD (tests written first)
- Files changed: 10 files (4 source, 4 tests, 2 config)
- Test coverage: 94%
- Key decisions: [list above]
- Dependencies added: bcrypt, jsonwebtoken
- Focus areas for review:
  * Security: Password hashing implementation
  * Error handling: JWT token validation
  * Rate limiting configuration
```

### Error Escalation to debug-specialist (if needed)

```
Debug Context from Implementation:
- Failed at: Task 3/4 (authentication endpoints)
- Error type: Test failure after 3 fix attempts
- Stack trace: [full trace]
- Code context: routes/auth.js:67
- Previous attempts:
  1. Added missing import
  2. Fixed function signature
  3. Updated test assertions
- Request: Diagnose why verifyToken returns 500 instead of 401
```

---

## Design Summary

### What We Designed

- ✅ **TDD-focused autonomous implementation agent**
- ✅ **Replaces manual pause steps** in workflows
- ✅ **Creates transparent execution plans** before coding
- ✅ **Implements via RED-GREEN-REFACTOR cycle**
- ✅ **Auto-fixes errors** (3 attempts) using debug-specialist logic
- ✅ **Asks user for clarification** on ambiguous decisions
- ✅ **Runs comprehensive verification** before code review
- ✅ **Integrates seamlessly** with workflow-orchestrator
- ✅ **Passes structured context** to downstream agents

### Key Design Decisions

1. **TDD First** - Tests written before implementation ensures correctness
2. **Ask Immediately** - User consultation on ambiguity prevents wrong assumptions
3. **Attempt Everything** - Handles all complexity levels with quality gates as safety net
4. **Plan-First Execution** - Transparent execution plan before any coding
5. **Verification Step** - Comprehensive checks before proceeding to code review
6. **3-Attempt Auto-Fix** - Balance between automation and escalation

### Success Criteria

Implementation is successful when:
- All tests pass (written via TDD)
- Verification suite passes (linter, type check, build)
- Code coverage meets target (typically 80%+)
- No critical/high severity issues
- All user questions answered
- Implementation matches architectural plan

---

## Next Steps

1. Create `code-implementation-specialist.md` agent file
2. Update `workflow-orchestrator.md` to integrate the new agent
3. Update workflow patterns documentation
4. Test the agent with a simple feature implementation
5. Iterate based on real-world usage

---

**Design Status:** ✅ Approved and ready for implementation
