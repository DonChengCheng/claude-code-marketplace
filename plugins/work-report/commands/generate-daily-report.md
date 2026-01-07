---
allowed-tools: Skill
argument-hint: [数据源文件路径(可选)]
description: 智能生成工作日报,支持交互式填写和数据源导入
---

# 工作日报生成命令

此命令调用智能日报生成 Agent Skill,提供更强大的日报生成功能。

## 使用说明

### 基本用法

```
/generate-daily-report
```

这将启动日报生成 Agent,提供以下选项:

1. **交互式填写** - 通过对话逐项录入今天的工作任务
2. **从现有文件导入** - 从现有文件（如任务列表、会议记录等）导入
3. **从Git提交导入** - 自动扫描项目的Git提交记录生成日报 (推荐)
4. **继续昨日任务** - 检查昨日未完成任务并继续填写

> 💡 **提示**: 使用 `/config-platform` 命令可创建或更新配置文件。

### 带参数用法

如果提供了数据源文件路径,将自动使用"从数据源导入"模式:

```
/generate-daily-report tasks.md
```

## 执行

请使用 daily-report skill 帮我生成今天的工作日报。

$ARGUMENTS
