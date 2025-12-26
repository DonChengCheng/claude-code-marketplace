---
description: 创建 GitLab Merge Request，自动生成标题和描述
allowed-tools: [Bash, Grep, Read]
argument-hint: [target-branch]
---

请帮我创建一个 GitLab Merge Request。

**步骤**:
1. 检查当前分支和远程状态
2. 获取提交历史，分析变更内容
3. 生成 MR 标题（简洁描述主要变更）
4. 生成 MR 描述（包含变更摘要）
5. 使用 `glab mr create` 创建 MR

**目标分支**: $1（默认为项目的默认分支）

**glab 命令格式**:
```bash
glab mr create --title "标题" --description "描述" --target-branch "目标分支"
```
