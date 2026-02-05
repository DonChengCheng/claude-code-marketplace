---
name: daily-report
description: 生成工作日报，支持任务跟踪。当用户需要创建日报、记录今日任务、从Git提交导入、继续昨日任务时触发。支持交互式填写、文件导入、Git导入三种模式。
allowed-tools: Read, Write, Edit, Bash(date:*), Bash(git log:*), Bash(git config:*), Bash(git status:*), Bash(git branch:*), Bash(ls:*), Bash(cat:*), AskUserQuestion, TodoWrite
---

# 工作日报生成

## 关键约束

| 约束 | 规则 |
|------|------|
| Git命令 | **必须**使用 `git -C <路径>`，**禁止**使用 `cd` |
| 配置读取 | **必须**使用 `$(pwd)/.work-report/` 读取本地配置，不可使用相对路径 |
| 配置优先级 | 本地 `$(pwd)/.work-report/` > 全局 `~/.claude/work-report/` |
| Git导入(有配置) | 直接使用配置路径，**禁止询问用户** |
| Git导入(无配置) | 询问用户输入路径或建议 `/config-platform` |

## 快速开始

Git提交导入（最常用）:

1. 读取平台配置（优先当前工作目录）
   ```bash
   cat "$(pwd)/.work-report/platform-config.json" 2>/dev/null || cat ~/.claude/work-report/platform-config.json
   ```

2. 从配置文件的 `projects` 数组获取项目路径列表

3. 对每个项目执行 `git -C <项目路径> log --all` 获取今日提交记录

## 工作流程

### 第1步：初始化
- 使用 `$(pwd)` 获取当前工作目录绝对路径
- **优先**读取 `$(pwd)/.work-report/platform-config.json`
- 若不存在再读取 `~/.claude/work-report/platform-config.json`
- 获取日期、检查已有日报

### 第2步：选择并执行模式
询问用户选择模式后 → **读取 `references/detailed-workflow.md`**

按文档中对应模式的流程执行：
- 交互式填写 / 文件导入 / Git导入 / 继续昨日

### 第3步：处理任务数据
解析每个任务时 → **读取 `../shared/task-type-rules.md`**

- 从任务描述推断类型（[页面]/[操作]等）
- 从 commit scope 提取功能模块标识（如 `shopping` → 【商城】）
- **识别多issue提交并拆分为独立任务**
- **根据commit类型规范化任务描述**（fix→"修复"，feat→"实现"）

### 第4步：生成日报
生成表格前 → **读取 `../shared/table-fields.md`**

输出：12字段表格 + 分类总结 + 总工时 → `日报_YYYY-MM-DD.md`

## 错误处理

| 场景 | 处理 |
|------|------|
| 模板不存在 | 报错并终止 |
| 日报已存在 | 询问覆盖或编辑 |
| Git无提交 | 建议其他模式 |
| 无配置文件 | 询问手动输入或创建配置 |

## 成功标准

生成的日报必须包含:
- 完整的12字段任务表格，任务名称包含功能模块标识如 `【商城】`
- 按分类分组的工作总结（标题格式：`## YYYY年MM月DD日工作内容总结`），任务分类包括新增功能、交互优化、Bug修复，任务名称前加平台标签如 `[网页端]` 和功能模块标识
- 总计工作时长
