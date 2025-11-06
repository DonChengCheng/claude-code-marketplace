# Summarize PR Skill

智能 PR 摘要生成工具，自动分析 Git 分支变更并生成专业的 Pull Request 描述。

## 功能特性

- 📊 **自动分析提交**：分析从分支起点到当前的所有提交
- 🏷️ **智能分类**：自动将提交分为新功能、优化、修复等类别
- 📈 **变更统计**：统计修改的文件数、代码行数等信息
- 💎 **提取亮点**：识别技术亮点和架构改进
- 💾 **自动保存**：生成的摘要自动保存为 Markdown 文件

## 使用方法

### 基本用法

```bash
# 使用默认基准分支（upstream/master）
/summarize-pr
```

### 指定基准分支

```bash
# 相对于 main 分支生成摘要
/summarize-pr main

# 相对于 develop 分支生成摘要
/summarize-pr develop

# 相对于其他远程分支
/summarize-pr origin/release-1.0
```

## 输出内容

### PR 标题

- 格式：`<type>: <简短描述>`
- 自动识别主要变更类型（feat/fix/refactor/improve）
- 简洁准确地概括核心变更

### PR 描述

包含以下部分：

#### ✨ 新增功能
列出所有新增的功能特性

#### 🔧 优化改进
列出所有优化和重构内容

#### 🐛 问题修复
列出所有修复的bug和问题

#### 📊 变更统计
- 修改/新增/删除的文件数
- 代码行数变化
- 主要影响的模块

#### 🎯 技术亮点
提炼关键的技术改进和架构优化

## 输出文件

生成的摘要会保存到：
```
PR-summary-<分支名>.md
```

例如：
- 分支 `feat/user-auth` → `PR-summary-feat-user-auth.md`
- 分支 `fix/login-bug` → `PR-summary-fix-login-bug.md`

## 使用场景

### 场景 1：功能开发完成

```bash
# 在 feature 分支上
git checkout feat/new-dashboard
# ... 完成开发和提交 ...

# 生成 PR 摘要
/summarize-pr main

# 使用生成的摘要创建 PR
```

### 场景 2：Bug 修复

```bash
# 在 fix 分支上
git checkout fix/memory-leak
# ... 修复问题并提交 ...

# 生成 PR 摘要
/summarize-pr

# 复制摘要内容到 PR 描述
```

### 场景 3：代码重构

```bash
# 在 refactor 分支上
git checkout refactor/api-client
# ... 重构代码 ...

# 生成 PR 摘要
/summarize-pr develop

# 摘要会突出重构的技术价值
```

## 提交信息规范

为了获得最佳的分类效果，建议使用规范的提交信息格式：

```
feat: 新增用户认证功能
fix: 修复登录页面样式问题
refactor: 重构 API 客户端代码
improve: 优化图片加载性能
perf: 提升列表渲染速度
docs: 更新 API 文档
test: 添加单元测试
chore: 更新依赖包版本
```

## 示例输出

### 输入

```bash
# 当前分支：feat/chat-improvements
# 基准分支：main
# 提交历史：
# - feat: 新增群组禁言管理功能
# - improve: 优化图片消息处理逻辑
# - fix: 修复消息发送时序问题
```

### 输出

```markdown
## PR 标题
feat: 聊天功能禁言管理和消息优化

## PR 描述

### ✨ 新增功能
- 新增群组禁言管理功能，管理员可管理群成员禁言状态

### 🔧 优化改进
- 优化图片消息处理逻辑，提升消息加载性能

### 🐛 问题修复
- 修复消息发送时序问题，确保消息顺序正确

### 📊 变更统计
- **修改文件数**：15 个文件
- **新增文件**：3 个文件
- **代码行数**：+320 -85
- **主要模块**：聊天模块 (src/chat)

### 🎯 技术亮点
- 实现多层级权限判断机制
- 优化消息处理性能，减少不必要的渲染
```

## 常见问题

### Q: 如何处理没有 upstream 的仓库？

A: 使用 `origin/master` 或其他远程分支作为基准：
```bash
/summarize-pr origin/master
```

### Q: 生成的摘要太长怎么办？

A: Skill 会自动简化描述，但如果提交太多，建议：
1. 将大的功能分成多个小 PR
2. 手动编辑生成的文件，保留重点内容

### Q: 提交信息不规范会影响分类吗？

A: 会有一定影响，但 Skill 会智能识别关键词：
- "新增"、"添加" → 新功能
- "优化"、"改进" → 优化改进
- "修复"、"解决" → 问题修复

### Q: 如何修改生成的摘要？

A: 直接编辑生成的 Markdown 文件：
```bash
# 文件位于项目根目录
vim PR-summary-<branch-name>.md
```

## 技术实现

### 使用的 Git 命令

```bash
# 获取分支起点
git merge-base <base-branch> HEAD

# 获取提交历史
git log --no-merges --format="%s" <merge-base>..HEAD

# 统计变更
git diff --shortstat <merge-base>..HEAD
git diff --name-status <merge-base>..HEAD
```

### 分类逻辑

- 使用正则匹配提交信息前缀
- 识别关键词（新增、优化、修复等）
- 分析文件路径判断影响模块

## 最佳实践

1. **定期生成**：每次准备创建 PR 前生成摘要
2. **及时修改**：生成后及时review并补充细节
3. **规范提交**：使用规范的提交信息格式
4. **小步提交**：频繁提交便于生成清晰的摘要
5. **补充说明**：在技术亮点部分补充重要的技术决策

## 配合使用

### 与 /commit-summary 配合

```bash
# 1. 规范地提交代码
/commit-summary

# 2. 准备PR时生成摘要
/summarize-pr
```

### 与 PR 工作流配合

```bash
# 1. 完成开发
git checkout -b feat/new-feature
# ... 开发和提交 ...

# 2. 生成摘要
/summarize-pr main

# 3. 创建 PR
gh pr create --title "..." --body-file PR-summary-feat-new-feature.md
```

## 许可证

MIT License
