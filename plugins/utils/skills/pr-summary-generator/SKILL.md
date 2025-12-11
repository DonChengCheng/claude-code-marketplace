---
name: pr-summary-generator
description: 当用户需要生成PR摘要、分析分支差异、创建Pull Request描述文档时使用此技能。支持自动分析git提交历史和文件变更，生成结构化的中文PR摘要。
---

# PR 摘要生成器

## 概述

此技能用于生成全面的 Pull Request 摘要，通过分析 git 提交记录和文件变更，生成可直接用于 PR 描述的 Markdown 文件 (PR_SUMMARY.md)。

## 适用场景

- 需要为 Pull Request 编写描述文档
- 需要了解 feature 分支的变更内容
- 需要生成结构化的提交和修改摘要
- 准备 PR 文档以供代码审查

## 工作流程

### 步骤 1: 创建任务跟踪

使用 TodoWrite 创建检查清单:
1. 收集 git 分支信息
2. 分析提交历史
3. 生成文件统计
4. 创建 markdown 摘要
5. 验证输出文件

### 步骤 2: 询问基准分支

使用 AskUserQuestion 询问用户:
```
"您想要与哪个分支进行比较生成 PR 摘要？"
选项: main, master, develop, 或自定义分支名称
```

### 步骤 3: 收集 Git 信息

并行执行以下命令:

```bash
# 获取当前分支
git rev-parse --abbrev-ref HEAD

# 获取提交数量
git rev-list --count HEAD ^${BASE_BRANCH}

# 获取提交历史
git log ${BASE_BRANCH}..HEAD --pretty=format:"%h|%s|%an|%ar" --no-merges

# 获取文件统计
git diff --stat ${BASE_BRANCH}..HEAD

# 获取变更文件列表
git diff --name-status ${BASE_BRANCH}..HEAD
```

### 步骤 4: 分析提交

解析提交信息并按类型分类:

| 前缀 | 分类 |
|------|------|
| `feat:` / `feature:` | 新功能 |
| `fix:` / `bugfix:` | 问题修复 |
| `refactor:` | 重构 |
| `perf:` / `performance:` | 性能优化 |
| `docs:` / `doc:` | 文档 |
| `test:` | 测试 |
| `chore:` | 杂项 |
| `style:` | 样式 |
| 其他 | 未分类 |

**模块检测**:
- 从 Conventional Commit scope 提取: `feat(auth): ...` → auth 模块
- 从文件路径提取: `src/components/auth/` → auth 模块

### 步骤 5: 生成 Markdown 摘要

**重要**: 所有内容使用中文生成，保持专业技术文档风格。提交信息保留原文。

```markdown
# PR 摘要：[当前分支] → [基准分支]

**生成时间：** [ISO 日期]
**作者：** [Git 用户名]
**分支：** `[当前分支]` → `[基准分支]`
**提交数：** [数量] 次提交
**文件变更：** [数量] 个文件 (+[新增] -[删除])

---

## 概述

[基于提交分析自动生成的 2-3 句话摘要]

---

## 变更分类

### ✨ 新功能 ([数量])
- [提交信息]

### 🐛 问题修复 ([数量])
- [提交信息]

### ♻️ 重构 ([数量])
- [提交信息]

### ⚡ 性能优化 ([数量])
- [提交信息]

### 📝 文档 ([数量])
- [提交信息]

### ✅ 测试 ([数量])
- [提交信息]

### 🎨 样式 ([数量])
- [提交信息]

### 🔧 杂项 ([数量])
- [提交信息]

### 📦 其他 ([数量])
- [提交信息]

---

## 涉及模块

- **[模块名称]**: [数量] 处变更
  - [此模块变更的简要中文描述]

---

## 详细变更

<details>
<summary>点击展开完整文件列表</summary>

**修改的文件：**
- `path/to/file.ts`

**新增的文件：**
- `path/to/new-file.ts`

**删除的文件：**
- `path/to/removed-file.ts`

</details>
```

## 输出

生成 `PR_SUMMARY.md` 文件，包含:
- PR 基本信息（分支、作者、时间）
- 变更概述
- 按类型分类的提交列表
- 涉及的模块和变更描述
- 完整的文件变更列表

## 成功标准

1. 正确识别所有提交并分类
2. 生成结构化的中文摘要
3. 包含完整的文件变更信息
4. 输出格式便于直接用于 PR 描述
