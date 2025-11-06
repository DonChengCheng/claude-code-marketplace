# Work Report Plugin

智能工作报告生成工具，支持日报、周报、月报的自动生成、数据聚合与多源整合。

## ✨ 功能特性

### 📝 日报生成（Daily Report）

**4 种生成模式：**

1. **交互式模式**：通过对话引导输入任务信息
2. **数据导入模式**：从 Git 提交记录或文件导入
3. **继续昨日模式**：自动读取昨日未完成任务
4. **空模板模式**：生成标准格式的空白模板

**智能功能：**
- 🎯 自动任务类型推断（12 字段表格）
- 🏢 平台检测（基于项目路径配置）
- ⏱️ 工时计算与跨天任务处理
- 📊 数据验证与摘要生成
- 🔗 Git 集成（使用 `git -C <path>` 模式）

### 📊 周报生成（Weekly Report）

**主要功能：**
- 📅 自动检测并聚合本周日报
- 🗂️ 任务分类（新增功能、交互优化、Bug 修复）
- 🔄 数据去重与工时合并
- 📈 统计信息（总工时、AI 辅助率、完成数量）

### 📈 月报生成（Monthly Report）

**5+ 种生成模式：**

1. **智能混合模式**（推荐）：周报 + 自动填补缺失日期的日报
2. **仅周报模式**：仅聚合周报数据
3. **仅日报模式**：纯日报数据聚合
4. **交互式模式**：对话引导输入
5. **数据导入模式**：文件/目录导入

**智能特性：**
- 📊 双源数据整合
- 📉 覆盖率计算（显示数据完整度）
- 🔍 缺口自动检测与填充
- 📋 详细数据源追踪

## 🚀 快速开始

### 安装插件

```bash
/plugin install work-report@claude-code-marketplace
```

### 基本使用

#### 生成日报

```bash
# 交互式生成（推荐新手）
/generate-daily-report

# 从 Git 提交导入
/generate-daily-report /path/to/your/project

# 继续昨日任务
/generate-daily-report continue

# 生成空模板
/generate-daily-report template
```

#### 生成周报

```bash
# 自动聚合本周日报
/generate-weekly-report

# 指定报告目录
/generate-weekly-report /path/to/reports-dir
```

#### 生成月报

```bash
# 智能混合模式（推荐）
/generate-monthly-report

# 指定模式
/generate-monthly-report weekly-only
/generate-monthly-report daily-only
```

## ⚙️ 配置

### 平台映射配置

编辑 `skills/daily-report/platform-config.json` 自定义项目路径到平台的映射：

```json
{
  "example-web-app": "网页",
  "my-mobile-app": "移动端",
  "test-project": "测试项目",
  "your-project-name": "你的平台名称"
}
```

**说明：**
- 键：项目路径中的关键字（部分匹配）
- 值：平台名称（会显示在报告中）

### Hooks 配置

插件包含工作目录保护 Hook，自动阻止可能改变工作目录的 `cd` 命令。

**功能：**
- ❌ 阻止危险的 `cd` 命令
- ✅ 允许子 shell 中的 `cd`：`(cd path && command)`
- ✅ 允许 `git -C` 模式
- 💡 提供友好的替代方案建议

## 📊 报告格式

### 日报表格（12 字段）

| 字段 | 说明 |
|------|------|
| 序号 | 任务编号 |
| 类型 | 任务类型（页面/操作/系统/模块等） |
| 任务名称 | 任务描述 |
| 接收时间 | 任务接收日期 |
| 完成时间 | 任务完成日期 |
| 预计耗时 | 预估工时（小时） |
| 进度 | 完成百分比 |
| 交付时间 | 实际交付日期 |
| 当天耗时 | 当日工时（小时） |
| 总耗时 | 累计工时（小时） |
| 异常 | 异常情况说明 |
| AI% | AI 辅助百分比 |

**任务类型推断规则：**

优先级从高到低：
1. **大系统**：关键词包含"系统"且涉及多模块
2. **大模块**：关键词包含"模块"且范围广
3. **页面**：UI/样式相关关键词
4. **操作**：逻辑/功能相关关键词
5. **小系统/小模块**：默认分类

### 周报/月报表格（9 字段）

| 字段 | 说明 |
|------|------|
| 序号 | 任务编号 |
| 类型 | 任务分类 |
| 名称 | 任务名称 |
| 接收时间 | 接收日期 |
| 规定交付时间 | 要求交付日期 |
| 实际交付时间 | 实际交付日期 |
| 耗时 | 总工时（小时） |
| 状态 | 完成/进行中 |
| 备注 | 额外说明 |

**任务分类：**
- 新增功能开发（含规模标签）
- 交互调整或优化
- Bug 修复（含详细子类）

## 🎯 使用场景

### 场景 1：每日工作记录

```bash
# 每天下班前
/generate-daily-report

# Agent 会引导你输入：
# - 完成了哪些任务
# - 每个任务的工时
# - 是否使用了 AI 辅助
# - 任务进度等信息
```

### 场景 2：从 Git 提交导入

```bash
# 如果你的项目有规范的 Git 提交
/generate-daily-report /path/to/your/project

# Agent 会：
# 1. 读取今天的 Git 提交记录
# 2. 自动推断任务类型
# 3. 让你补充工时等信息
```

### 场景 3：多天任务追踪

```bash
# 第一天：开始任务
/generate-daily-report
# 输入：任务 A，进度 30%，耗时 3h

# 第二天：继续任务
/generate-daily-report continue
# Agent 会自动读取昨日未完成任务
# 你只需更新进度和今日耗时
```

### 场景 4：周报汇总

```bash
# 每周五
/generate-weekly-report

# Agent 会：
# 1. 自动找到本周所有日报
# 2. 聚合任务数据
# 3. 生成分类表格
# 4. 计算统计信息
```

### 场景 5：月报生成

```bash
# 每月底
/generate-monthly-report

# Agent 会：
# 1. 找到本月所有周报
# 2. 检测未覆盖的日期
# 3. 自动补充对应的日报数据
# 4. 显示覆盖率统计
```

## 🛠️ 高级功能

### 自定义模板

插件提供的模板文件：
- `skills/daily-report/template.md` - 日报模板
- `skills/weekly-report/template.md` - 周报模板
- `skills/monthly-report/template.md` - 月报模板

可以根据需要自定义这些模板。

### 数据验证

所有 Skills 都包含数据验证逻辑：
- ✅ 日期格式检查
- ✅ 工时数值验证
- ✅ 必填字段检查
- ✅ 数据一致性验证

### 统计信息

报告自动生成统计：
- 📊 总工时
- 🤖 AI 辅助率
- ✅ 任务完成数
- 📈 数据覆盖率（月报）

## 📝 文件输出

### 日报

文件名：`日报_YYYY-MM-DD.md`

示例：`日报_2024-11-06.md`

### 周报

文件名：`周报_YYYY年MM月DD日-MM月DD日.md`

示例：`周报_2024年11月04日-11月10日.md`

### 月报

文件名：`YYYY年MM月工作月报.md`

示例：`2024年11月工作月报.md`

## ⚠️ 注意事项

1. **平台配置**：首次使用前建议配置 `platform-config.json`
2. **Git 路径**：导入 Git 数据时使用绝对路径
3. **日期格式**：统一使用 `YYYY-MM-DD` 格式
4. **工时单位**：统一使用小时（支持小数）
5. **Hook 影响**：安装后会阻止 `cd` 命令，使用 `git -C` 替代

## 🐛 故障排查

### 问题：无法找到日报/周报

**解决方案：**
- 检查报告文件是否在当前目录
- 使用绝对路径指定报告目录
- 确认文件名格式正确

### 问题：平台识别错误

**解决方案：**
- 检查 `platform-config.json` 配置
- 确保项目路径关键字正确
- 更新配置后重新生成

### 问题：Git 导入失败

**解决方案：**
- 确认使用绝对路径
- 检查是否是有效的 Git 仓库
- 验证今天是否有提交记录

## 📚 相关文档

- [Daily Report Skill](skills/daily-report/README.md)
- [Weekly Report Skill](skills/weekly-report/README.md)
- [Monthly Report Skill](skills/monthly-report/README.md)
- [CHANGELOG](skills/daily-report/CHANGELOG.md)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
