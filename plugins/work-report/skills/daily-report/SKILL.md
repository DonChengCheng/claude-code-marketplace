---
name: daily-report
description: 生成工作日报，支持任务跟踪。当用户需要创建日报、记录今日任务、从Git提交导入、继续昨日任务时触发。支持交互式填写、文件导入、Git导入三种模式。
allowed-tools: Read, Write, Edit, Bash(date:*), Bash(git log:*), Bash(git config:*), Bash(git status:*), Bash(git branch:*), Bash(ls:*), Bash(cat:*), AskUserQuestion, TodoWrite
---

# 工作日报生成

## 快速开始

Git提交导入（最常用）:

```bash
# 1. 读取平台配置
cat .work-report/platform-config.json 2>/dev/null || cat ~/.claude/work-report/platform-config.json

# 2. 获取今日提交记录
git -C /path/to/project log --all --since="$(date +%Y-%m-%d) 00:00:00" --until="$(date +%Y-%m-%d) 23:59:59" --author="用户名" --pretty=format:"%H|%s"
```

## 参考文档

| 文档 | 用途 |
|------|------|
| `references/detailed-workflow.md` | 各模式详细工作流程 |
| `../shared/task-type-rules.md` | 任务类型推断规则 |
| `../shared/table-fields.md` | 12字段表格规范 |

## 关键约束

| 约束 | 规则 |
|------|------|
| Git命令 | **必须**使用 `git -C <路径>`，**禁止**使用 `cd` |
| 配置优先级 | 本地 `.work-report/` > 全局 `~/.claude/work-report/` |
| Git导入(有配置) | 直接使用配置路径，**禁止询问用户** |
| Git导入(无配置) | 询问用户输入路径或建议 `/config-platform` |

## 工作流程

1. **初始化**: 获取日期、检查已有日报、读取模板和配置
2. **选择模式**: 交互式 / 文件导入 / Git导入 / 继续昨日
3. **执行**: 按 `references/detailed-workflow.md` 执行对应模式
4. **生成**: 12字段表格 + 分类总结 + 总工时 → `日报_YYYY-MM-DD.md`

## 错误处理

| 场景 | 处理 |
|------|------|
| 模板不存在 | 报错并终止 |
| 日报已存在 | 询问覆盖或编辑 |
| Git无提交 | 建议其他模式 |
| 无配置文件 | 询问手动输入或创建配置 |

## 成功标准

生成的日报必须包含:
- 完整的12字段任务表格
- 按分类分组的工作总结（标题需包含当天日期，格式如 `## YYYY年MM月DD日工作内容总结`），任务分类包括新增功能、交互优化、Bug修复，任务名称前加平台标签如 `[网页]`
- 总计工作时长
