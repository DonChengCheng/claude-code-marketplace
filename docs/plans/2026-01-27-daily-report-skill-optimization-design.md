# SKILL.md 结构优化设计

日期：2026-01-27

## 优化目标

提升 `plugins/work-report/skills/daily-report/SKILL.md` 的结构和可读性，让 Agent 更清晰地理解执行流程和何时读取参考文档。

## 核心问题

Agent 不确定何时读取哪个参考文档，导致执行流程混乱。

## 优化决策

| 优化项 | 决策 |
|--------|------|
| 整体结构 | 关键约束 → 快速开始 → 工作流程 → 错误处理 → 成功标准 |
| 关键约束 | 提到最前面（原在第29行） |
| 快速开始 | 改为说明性文字，移除占位符命令 `/path/to/project` |
| 参考文档表格 | 删除（已内联到工作流程中） |
| 工作流程 | 改为 4 步结构，每步明确标注文档触发点 |
| 功能模块标识 | 整节移到 `../shared/task-type-rules.md` |

## 改进后的结构

### 1. 关键约束（最前）

```markdown
## 关键约束

| 约束 | 规则 |
|------|------|
| Git命令 | **必须**使用 `git -C <路径>`，**禁止**使用 `cd` |
| 配置读取 | **必须**使用 `$(pwd)/.work-report/` 读取本地配置，不可使用相对路径 |
| 配置优先级 | 本地 `$(pwd)/.work-report/` > 全局 `~/.claude/work-report/` |
| Git导入(有配置) | 直接使用配置路径，**禁止询问用户** |
| Git导入(无配置) | 询问用户输入路径或建议 `/config-platform` |
```

### 2. 快速开始（说明性文字）

```markdown
## 快速开始

Git提交导入（最常用）:

1. 读取平台配置（优先当前工作目录）
   ```bash
   cat "$(pwd)/.work-report/platform-config.json" 2>/dev/null || cat ~/.claude/work-report/platform-config.json
   ```

2. 从配置文件的 `projects` 数组获取项目路径列表

3. 对每个项目执行 `git -C <项目路径> log --all` 获取今日提交记录
```

### 3. 工作流程（含文档触发点）

```markdown
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

### 第4步：生成日报
生成表格前 → **读取 `../shared/table-fields.md`**

输出：12字段表格 + 分类总结 + 总工时 → `日报_YYYY-MM-DD.md`
```

### 4. 错误处理 + 成功标准

保持原有内容不变。

## 涉及修改的文件

1. `plugins/work-report/skills/daily-report/SKILL.md` - 主要重构
2. `plugins/work-report/skills/shared/task-type-rules.md` - 添加 scope 映射表

## 实施步骤

1. 修改 `task-type-rules.md`，添加功能模块标识映射表
2. 重构 `SKILL.md`，按新结构重新组织内容
3. 更新 `CHANGELOG.md` 记录此次优化
