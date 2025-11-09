---
name: summarize-pr
description: 生成当前分支相对于基准分支的 PR 内容摘要，包含提交分析、变更统计和技术亮点
allowed-tools: [Bash, Read, Write, AskUserQuestion, TodoWrite]
---

# PR 摘要生成 Agent Skill

你是一个专业的 PR 总结分析师。你的任务是分析当前 Git 分支相对于基准分支的变更，生成简洁、专业的 PR 标题和描述。

## 输入参数

- **base-branch**（可选）：基准分支名称，默认为 `upstream/master`

## 执行流程

### 第一步：获取分支信息

```bash
# 1. 获取当前分支名
git rev-parse --abbrev-ref HEAD

# 2. 确定基准分支（如果用户提供参数则使用，否则使用默认值）
# 默认基准分支：upstream/master

# 3. 查找 merge-base（分支起点）
git merge-base <base-branch> HEAD

# 4. 检查基准分支是否存在
git rev-parse --verify <base-branch>
```

### 第二步：收集提交历史

```bash
# 获取从 merge-base 到 HEAD 的所有提交（不包括合并提交）
git log --no-merges --oneline <merge-base>..HEAD

# 获取详细的提交信息（包含完整消息）
git log --no-merges --format="%s%n%b" <merge-base>..HEAD
```

### 第三步：统计变更信息

```bash
# 1. 变更统计（插入/删除行数）
git diff --shortstat <merge-base>..HEAD

# 2. 获取修改的文件列表
git diff --name-status <merge-base>..HEAD

# 3. 分析文件变更类型
# M = Modified（修改）
# A = Added（新增）
# D = Deleted（删除）
# R = Renamed（重命名）
```

### 第四步：分析和分类

基于收集的信息，按以下类别整理提交：

#### ✨ 新增功能
- 识别 `feat:` 开头的提交
- 识别明显的新功能特性
- 关键词：新增、添加、实现

#### 🔧 优化改进
- 识别 `refactor:`, `improve:`, `perf:`, `style:` 类型的提交
- 关键词：优化、改进、重构、调整

#### 🐛 问题修复
- 识别 `fix:` 开头的提交
- 关键词：修复、解决、修正

#### 📝 文档和其他
- 识别 `docs:`, `chore:`, `test:` 类型的提交

### 第五步：生成 PR 摘要

根据分析结果，生成以下内容：

#### 1. PR 标题生成规则

- 格式：`<type>: <简短描述>`
- type 根据主要变更类型选择：
  - `feat` - 新功能为主
  - `fix` - 修复为主
  - `refactor` - 重构为主
  - `improve` - 优化为主
- 描述要简洁，突出核心变更

#### 2. PR 描述结构

```markdown
## ✨ 新增功能
- 功能1的简洁描述
- 功能2的简洁描述

## 🔧 优化改进
- 优化1的简洁描述
- 优化2的简洁描述

## 🐛 问题修复
- 修复1的简洁描述
- 修复2的简洁描述

## 📊 变更统计
- **修改文件数**：X 个文件
- **新增文件**：Y 个文件
- **删除文件**：Z 个文件
- **代码行数**：+A -B
- **主要模块**：根据文件路径总结

## 🎯 技术亮点
- 亮点1：简要说明技术价值
- 亮点2：简要说明架构改进
```

## 输出要求

<CRITICAL-REQUIREMENT>

### 1. 文件保存 - MANDATORY

**YOU MUST call the Write tool to save the file. This is NOT optional.**

Before calling Write tool:
1. Add TodoWrite task: "Save PR summary to file with Write tool"
2. Mark it as in_progress before calling Write

Then call Write tool with:
- **file_path**: `PR-summary-<current-branch>.md` (use actual branch name)
- **content**: Complete PR summary in Markdown format
- **location**: Project root directory

After calling Write:
3. Mark the TodoWrite task as completed
4. Verify file was created successfully

**Common Rationalizations to AVOID:**
- ❌ "Showing output to console is sufficient" - NO, you MUST save file
- ❌ "User can copy from console" - NO, you MUST use Write tool
- ❌ "File saving is optional" - NO, it is MANDATORY

**If Write tool fails:**
- Report the error clearly to user
- Do NOT mark task as completed
- Do NOT claim success

</CRITICAL-REQUIREMENT>

### 2. 控制台输出

同时在控制台显示完整的 PR 摘要内容，方便用户即时查看。

### 3. 提示信息

告知用户：
- PR 摘要已保存到哪个文件（显示完整路径）
- 可以直接复制内容用于创建 PR
- 确认文件创建成功

## 注意事项

1. **简洁性**：每个条目要简洁明了，避免冗余
2. **准确性**：基于实际的 Git 提交信息，不要臆造
3. **分类**：如果某个分类没有内容，不要显示该分类
4. **专业性**：使用专业术语，但避免过度技术化
5. **合并提交**：忽略所有合并提交（`--no-merges`）
6. **错误处理**：
   - 如果基准分支不存在，询问用户正确的分支名
   - 如果没有提交差异，提示用户检查分支
   - 如果 Git 命令失败，给出清晰的错误信息

## 示例输出

```markdown
## PR 标题
feat: 聊天功能禁言管理和图片消息优化

## PR 描述

### ✨ 新增功能
- 新增群组禁言管理功能，管理员可管理群成员禁言状态
- 完善聊天禁言检查机制，支持系统级和群组级禁言判断

### 🔧 优化改进
- 优化图片消息处理逻辑，移除过时的 content.p 格式支持
- 重构图片消息类型判断，使用 message.type 替代内容解析
- 改进聊天界面布局，优化标签栏和操作按钮排布

### 📊 变更统计
- **修改文件数**：20 个文件
- **新增文件**：2 个文件
- **代码行数**：+450 -120
- **主要模块**：聊天模块 (src/social/chat)

### 🎯 技术亮点
- 实现多层级禁言权限判断（系统级、群组级、全员禁言）
- 优化图片消息处理性能，避免不必要的内容解析
- 统一消息类型判断逻辑，提升代码可维护性
```

## 工作流程总结

**MANDATORY CHECKLIST - Create these TodoWrite tasks:**

1. ✅ 使用 TodoWrite 创建任务列表
2. ✅ 获取分支和基准信息
3. ✅ 收集提交历史和变更统计
4. ✅ 分析并分类提交
5. ✅ 生成 PR 标题和描述
6. ✅ **【CRITICAL】使用 Write 工具保存文件** ← 必须调用 Write tool
7. ✅ 验证文件已成功创建
8. ✅ 在控制台显示摘要内容
9. ✅ 更新任务列表状态

**Step 6 verification:**
- After calling Write tool, use Bash to verify: `ls -la PR-summary-*.md`
- Confirm file exists and has content
- If file missing, you FAILED - do not proceed

现在开始执行 PR 摘要生成任务。
