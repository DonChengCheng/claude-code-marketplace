---
name: pr-summary-generator
description: Use when you need to generate a comprehensive PR summary by analyzing commits and changes - creates detailed markdown documentation of branch changes for pull request descriptions
---

# PR Summary Generator

## Overview

This skill generates a comprehensive Pull Request summary by analyzing git commits, file changes, and code modifications. It produces a markdown file (PR_SUMMARY.md) that can be directly used as a PR description.

## When to Use

Use this skill when:
- You need to document changes for a pull request
- You want to review what changed in a feature branch
- You need a structured summary of commits and modifications
- You're preparing PR documentation

## Workflow

When invoked, follow these steps in order:

### Step 1: Setup and Information Gathering

Create a TodoWrite checklist for tracking:
```
1. Gather git branch information
2. Analyze commit history
3. Generate file statistics
4. Create markdown summary
5. Verify output file
```

### Step 2: Ask for Base Branch

Ask the user which branch to compare against:
```
"Which branch should I compare against for this PR summary?"
Options: main, master, develop, or custom branch name
```

Store the user's response as `BASE_BRANCH`.

### Step 3: Gather Git Information

Run these commands in parallel:

```bash
# Get current branch
git rev-parse --abbrev-ref HEAD

# Get commit count
git rev-list --count HEAD ^${BASE_BRANCH}

# Get commit history with format
git log ${BASE_BRANCH}..HEAD --pretty=format:"%h|%s|%an|%ar" --no-merges

# Get file statistics
git diff --stat ${BASE_BRANCH}..HEAD

# Get changed files list
git diff --name-status ${BASE_BRANCH}..HEAD
```

### Step 4: Analyze Commits

Parse commit messages and categorize them:

**Conventional Commit Types:**
- `feat:` / `feature:` → Features
- `fix:` / `bugfix:` → Bug Fixes
- `refactor:` → Refactoring
- `perf:` / `performance:` → Performance
- `docs:` / `doc:` → Documentation
- `test:` → Tests
- `chore:` → Chores
- `style:` → Styling
- Other → Uncategorized

**Module Detection:**
Extract module/area from:
- Conventional commit scope: `feat(auth): ...` → auth module
- File paths: Changes in `src/components/auth/` → auth module
- Common patterns in commit messages

### Step 5: Generate Markdown Summary

**IMPORTANT: Generate all content in Chinese (中文)**
- All section titles, descriptions, and analysis must be written in Chinese
- Use professional technical documentation style (专业技术文档风格)
- Keep commit messages in their original language (preserve the actual git commit text)
- Maintain the markdown structure and emoji icons as shown in the template below

Create `PR_SUMMARY.md` with this structure:

```markdown
# PR 摘要：[Current Branch] → [Base Branch]

**生成时间：** [ISO Date]
**作者：** [Git User Name]
**分支：** `[current-branch]` → `[base-branch]`
**提交数：** [count] 次提交
**文件变更：** [count] 个文件 (+[additions] -[deletions])

---

## 概述

[基于提交分析自动生成的 2-3 句话摘要，使用中文描述主要变更内容]

---

## 变更分类

### ✨ 新功能 ([count])
- [commit message]
- ...

### 🐛 问题修复 ([count])
- [commit message]
- ...

### ♻️ 重构 ([count])
- [commit message]
- ...

### ⚡ 性能优化 ([count])
- [commit message]
- ...

### 📝 文档 ([count])
- [commit message]
- ...

### ✅ 测试 ([count])
- [commit message]
- ...

### 🎨 样式 ([count])
- [commit message]
- ...

### 🔧 杂项 ([count])
- [commit message]
- ...

### 📦 其他 ([count])
- [commit message]
- ...

---

## 涉及模块

- **[模块名称]**: [count] 处变更
  - [此模块变更的简要中文描述]
- ...

---

## 详细变更

<details>
<summary>点击展开完整文件列表</summary>

**修改的文件：**
- `path/to/file.ts`
- ...

**新增的文件：**
- `path/to/new-file.ts`
- ...

**删除的文件：**
- `path/to/removed-file.ts`
- ...

</details>
```