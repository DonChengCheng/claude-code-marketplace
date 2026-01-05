---
description: 生成当前分支的 MR 内容摘要，分析提交历史和文件变更
allowed-tools: [Bash, AskUserQuestion, Write]
argument-hint: [base-branch]
---

# MR 摘要生成器

生成当前分支相对于基准分支的 Merge Request 摘要文档。

## 工作流程

### 步骤 1: 确定远程仓库和基准分支

使用 AskUserQuestion 同时询问：
- **远程仓库**: origin (推荐) / upstream / 自定义
- **基准分支**: 如果提供了参数 `$1` 则使用 `$1`，否则询问用户选择 main / master / develop / 自定义

### 步骤 2: 更新基准分支

```bash
git fetch ${REMOTE} ${BASE_BRANCH}
```

如果 fetch 失败，提示用户检查配置或询问是否使用本地缓存继续。

### 步骤 3: 收集 Git 信息

并行执行（使用 `${REMOTE}/${BASE_BRANCH}` 确保比较最新远程状态）:

```bash
git rev-parse --abbrev-ref HEAD
git rev-list --count HEAD ^${REMOTE}/${BASE_BRANCH}
git log ${REMOTE}/${BASE_BRANCH}..HEAD --pretty=format:"%h|%s|%an|%ar" --no-merges
git diff --stat ${REMOTE}/${BASE_BRANCH}..HEAD
git diff --name-status ${REMOTE}/${BASE_BRANCH}..HEAD
```

### 步骤 4: 分析提交

按 Conventional Commit 前缀分类：

| 前缀 | 分类 | 图标 |
|------|------|------|
| `feat:` / `feature:` | 新功能 | ✨ |
| `fix:` / `bugfix:` | 问题修复 | 🐛 |
| `refactor:` | 重构 | ♻️ |
| `perf:` | 性能优化 | ⚡ |
| `docs:` | 文档 | 📝 |
| `test:` | 测试 | ✅ |
| `chore:` | 杂项 | 🔧 |
| `style:` | 样式 | 🎨 |
| 其他 | 未分类 | 📦 |

**模块检测**: 优先从 scope 提取 `feat(auth):` → auth，其次从文件路径提取。

### 步骤 5: 生成摘要文件

使用 Write 工具输出 `MR_SUMMARY.md`，格式如下：

```markdown
# MR 摘要：[当前分支] → [远程]/[基准分支]

**生成时间：** [ISO 日期]
**作者：** [Git 用户名]
**分支：** `[当前分支]` → `[远程]/[基准分支]`
**远程仓库：** [远程名称]
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

## 注意事项

- 所有内容使用中文生成，保持专业技术文档风格
- 提交信息保留原文
- 空分类可以省略不显示
- 模块检测优先从 Conventional Commit scope 提取，其次从文件路径提取
