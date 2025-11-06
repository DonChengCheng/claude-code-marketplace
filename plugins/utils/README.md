# Utils Plugin

开发实用工具集合，提供 Git 提交总结、PR 摘要生成、对话总结等辅助命令。

## ✨ 功能特性

### 📝 Commit Summary（提交总结）

自动总结 Git 工作区的更改内容，生成规范的 commit message 并提交。

**功能：**
- 📊 分析 staged 和 unstaged 更改
- 📝 生成简洁的提交信息
- 🤖 遵循仓库的提交风格
- ✅ 自动执行 git commit

### 📄 Summarize PR（PR 摘要）

生成当前分支相对于指定 base 分支的 Pull Request 内容摘要。

**功能：**
- 🔍 分析分支差异和提交历史
- 📋 生成结构化的 PR 描述
- 💾 保存为 Markdown 文件
- 🎯 支持自定义 base 分支

### 💬 Summary（对话总结）

总结本次与 Claude 的对话内容，分析改进点并记录到本地文件。

**功能：**
- 📝 对话内容摘要
- 💡 改进建议分析
- 💾 保存到 `CLAUDE.local.md`
- 📊 持续积累项目知识

## 🚀 快速开始

### 安装插件

```bash
/plugin install utils@claude-code-marketplace
```

### 基本使用

#### Commit Summary

```bash
# 在有 Git 更改的项目中
/commit-summary

# Agent 会：
# 1. 运行 git status 查看更改
# 2. 运行 git diff 分析差异
# 3. 参考最近的 commit 风格
# 4. 生成 commit message
# 5. 执行 git add 和 git commit
```

**示例输出：**
```
✅ 已创建提交：
fix: 修复用户登录页面样式问题

- 调整登录表单布局
- 修复响应式设计在移动端的显示
- 优化按钮间距
```

#### Summarize PR

```bash
# 默认相对于 upstream/master
/summarize-pr

# 指定 base 分支
/summarize-pr main
/summarize-pr develop
```

**生成文件示例：**
```markdown
# PR Summary - feature/user-auth

## 概述
实现用户认证系统，包含登录、注册、密码重置功能。

## 主要变更
- 新增用户登录 API
- 实现 JWT token 认证
- 添加密码加密存储

## 测试计划
- [ ] 单元测试
- [ ] 集成测试
- [ ] 手动测试登录流程

## 相关 Issue
Closes #123
```

#### Summary

```bash
# 在对话结束时
/summary

# Agent 会：
# 1. 总结本次对话的主要内容
# 2. 分析可改进的地方
# 3. 保存到 CLAUDE.local.md
```

**保存文件示例：**
```markdown
## 2024-11-06 对话总结

### 完成内容
- 实现了用户认证功能
- 添加了单元测试
- 更新了 API 文档

### 改进建议
- 考虑添加 refresh token 机制
- 优化错误处理逻辑
- 补充 API 使用示例

### 遗留问题
- 密码重置邮件模板待设计
```

## 📖 使用场景

### 场景 1：规范化提交

**问题：**提交信息不规范，难以追溯变更历史

**解决方案：**
```bash
# 完成代码修改后
/commit-summary

# 自动生成规范的 commit message
# 符合项目风格，清晰描述变更内容
```

### 场景 2：快速创建 PR

**问题：**创建 PR 时需要手写大量描述

**解决方案：**
```bash
# 在 feature 分支上
/summarize-pr

# 自动生成 PR 摘要文件
# 包含变更概述、测试计划等
# 直接复制到 PR 描述即可
```

### 场景 3：积累项目知识

**问题：**对话内容容易遗忘，无法沉淀

**解决方案：**
```bash
# 每次重要对话结束后
/summary

# 自动记录到项目文件
# 持续积累开发经验和改进点
```

## ⚙️ 配置说明

### Commit Summary 配置

命令会自动：
- 分析最近 5 条 commit 的风格
- 遵循 Conventional Commits 规范
- 根据变更类型选择前缀（feat/fix/docs/style 等）

### Summarize PR 配置

默认 base 分支：`upstream/master`

可通过参数指定其他分支：
```bash
/summarize-pr main
/summarize-pr develop
/summarize-pr release/v1.0
```

### Summary 配置

输出文件：`CLAUDE.local.md`（通常已在 .gitignore 中）

## 📝 命令详解

### /commit-summary

**完整语法：**
```bash
/commit-summary [data-source]
```

**参数：**
- `data-source`（可选）：指定分析的路径或文件

**工作流程：**
1. 检查 Git 状态
2. 分析 staged 和 unstaged 更改
3. 读取最近的 commit 历史
4. 生成符合规范的 commit message
5. 添加文件到暂存区
6. 执行 commit

**注意事项：**
- 确保在 Git 仓库中执行
- 建议提交前先测试通过
- 大量更改建议分批提交

### /summarize-pr

**完整语法：**
```bash
/summarize-pr [base-branch]
```

**参数：**
- `base-branch`（可选）：PR 的目标分支，默认 `upstream/master`

**生成内容：**
- PR 标题和概述
- 主要变更列表
- 提交历史
- 测试计划
- 相关 Issue 引用

**输出文件：**
保存为 Markdown 文件，建议命名格式：
- `PR-<branch-name>.md`
- `PR-summary-<date>.md`

### /summary

**完整语法：**
```bash
/summary
```

**生成内容：**
- 对话日期和主题
- 完成的主要内容
- 改进建议
- 遗留问题

**输出位置：**
追加到 `CLAUDE.local.md`（如不存在则创建）

## 🔧 最佳实践

### Commit 最佳实践

1. **频繁提交**：完成一个小功能就提交
2. **原子提交**：每次提交只做一件事
3. **清晰描述**：让 6 个月后的自己能看懂

```bash
# 好的做法
/commit-summary  # 完成登录功能
/commit-summary  # 完成注册功能

# 避免
/commit-summary  # 一次性提交所有功能
```

### PR 最佳实践

1. **及时生成**：功能完成立即生成 PR 摘要
2. **补充细节**：在生成的基础上补充具体细节
3. **更新文档**：重大变更记得更新相关文档

```bash
# 推荐流程
git checkout -b feature/new-feature
# ... 开发 ...
/commit-summary  # 多次提交
/summarize-pr main  # 生成 PR 摘要
# 基于摘要创建 PR
```

### Summary 最佳实践

1. **定期总结**：每次重要对话后总结
2. **分类记录**：按日期或主题组织
3. **及时回顾**：定期回顾改进建议

```bash
# 对话结束时
/summary

# 下次开始前可以查看 CLAUDE.local.md
# 了解上次的遗留问题和改进建议
```

## ⚠️ 注意事项

### Commit Summary

- ❗ 执行前确保代码已测试通过
- ❗ 敏感文件（如 `.env`）会被警告
- ❗ 大量更改建议先 review 再提交
- ❗ 不会自动 push，需手动执行

### Summarize PR

- ❗ 确保当前分支已 push 到 remote
- ❗ 检查 base 分支是否正确
- ❗ 生成的摘要需要人工审核
- ❗ 复杂 PR 建议补充更多细节

### Summary

- ❗ `CLAUDE.local.md` 建议加入 `.gitignore`
- ❗ 包含个人笔记，不建议提交到仓库
- ❗ 定期备份以防丢失

## 🐛 故障排查

### 问题：commit-summary 失败

**可能原因：**
- 不在 Git 仓库中
- 没有需要提交的更改
- Git 配置问题

**解决方案：**
```bash
git status  # 检查状态
git config --list  # 检查配置
```

### 问题：summarize-pr 找不到分支

**可能原因：**
- base 分支名称错误
- remote 未配置

**解决方案：**
```bash
git branch -a  # 查看所有分支
git remote -v  # 查看 remote 配置
```

### 问题：summary 保存失败

**可能原因：**
- 文件权限问题
- 路径不存在

**解决方案：**
```bash
ls -la CLAUDE.local.md  # 检查文件
chmod 644 CLAUDE.local.md  # 修改权限
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这些工具！

可能的改进方向：
- 更多 commit message 模板
- PR 摘要模板自定义
- 支持更多 VCS 系统（SVN、Mercurial 等）

## 📄 许可证

MIT License
