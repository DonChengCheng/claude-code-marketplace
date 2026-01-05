---
name: mr-summary-generator
description: 当用户需要生成MR摘要、分析分支差异、创建Merge Request描述文档时使用此技能。支持自动分析git提交历史和文件变更，生成结构化的中文MR摘要。
---

# MR 摘要生成器

## 工作流程

### 步骤 1: 询问远程仓库和基准分支

使用 AskUserQuestion 同时询问：
- **远程仓库**: origin (推荐) / upstream / 自定义
- **基准分支**: main / master / develop / 自定义

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

| 前缀 | 分类 |
|------|------|
| `feat:` / `feature:` | 新功能 |
| `fix:` / `bugfix:` | 问题修复 |
| `refactor:` | 重构 |
| `perf:` | 性能优化 |
| `docs:` | 文档 |
| `test:` | 测试 |
| `chore:` | 杂项 |
| `style:` | 样式 |
| 其他 | 未分类 |

**模块检测**: 优先从 scope 提取 `feat(auth):` → auth，其次从文件路径提取。

### 步骤 5: 生成摘要

输出 `MR_SUMMARY.md`，包含：
- MR 元信息（分支、作者、时间、远程仓库）
- 变更概述（2-3 句话）
- 按类型分类的提交列表
- 涉及的模块和变更描述
- 详细文件变更列表

完整输出模板参见: [references/output-template.md](references/output-template.md)

## 成功标准

1. 正确识别并分类所有提交
2. 生成结构化的中文摘要
3. 输出格式便于直接用于 MR 描述
