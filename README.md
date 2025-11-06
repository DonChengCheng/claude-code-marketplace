# Claude Code 插件市场

这是一个 Claude Code 插件市场，提供工作报告生成、开发工具等实用插件。

## 📦 可用插件

### 1. Work Report（工作报告生成器）

智能工作报告生成工具，支持日报、周报、月报的自动生成与数据聚合。

**主要功能：**
- 📝 **日报生成**：支持交互式、数据导入、继续昨日、模板四种模式
- 📊 **周报生成**：自动聚合日报数据，支持任务分类与统计
- 📈 **月报生成**：智能混合周报和日报数据，自动填补覆盖缺口
- 🎯 **智能推断**：自动识别任务类型、平台、工时计算
- 🔗 **Git 集成**：支持从 Git 提交记录导入任务数据

**包含命令：**
- `/generate-daily-report` - 生成日报
- `/generate-weekly-report` - 生成周报
- `/generate-monthly-report` - 生成月报

**包含 Skills：**
- `daily-report` - 日报生成智能 Agent
- `weekly-report` - 周报生成智能 Agent
- `monthly-report` - 月报生成智能 Agent

**包含 Hooks：**
- `pre-bash` - 工作目录保护，防止意外 `cd` 命令

---

### 2. Utils（开发工具集）

开发辅助工具集合，提供 Git 提交总结、PR 摘要等实用命令。

**包含命令：**
- `/commit-summary` - Git 提交内容总结并自动提交
- `/summarize-pr` - 生成 PR 内容摘要（支持指定 base 分支）
- `/summary` - 对话内容总结与改进点分析

---

## 🚀 安装方法

### 方法 1：直接安装（推荐）

```bash
# 安装整个市场（包含所有插件）
/plugin install https://github.com/DonChengCheng/claude-code-marketplace
```

### 方法 2：添加市场后浏览安装

```bash
# 1. 添加市场到插件管理器
/plugin marketplace add DonChengCheng/claude-code-marketplace

# 2. 打开插件浏览器，选择并安装需要的插件
/plugin
```

### 方法 3：安装单个插件

```bash
# 只安装工作报告插件
/plugin install work-report@DonChengCheng/claude-code-marketplace

# 只安装工具集插件
/plugin install utils@DonChengCheng/claude-code-marketplace
```

---

## 📖 使用指南

### Work Report 插件

#### 1. 生成日报

```bash
# 交互式生成
/generate-daily-report

# 从 Git 提交导入
/generate-daily-report /path/to/project

# 继续昨日任务
/generate-daily-report continue

# 使用空模板
/generate-daily-report template
```

**配置平台映射**（可选）：

编辑 `skills/daily-report/platform-config.json` 来自定义项目路径到平台的映射：

```json
{
  "example-web-app": "网页",
  "my-mobile-app": "移动端",
  "your-project-name": "你的平台名称"
}
```

#### 2. 生成周报

```bash
# 自动聚合本周日报
/generate-weekly-report

# 指定数据源
/generate-weekly-report /path/to/reports
```

#### 3. 生成月报

```bash
# 智能混合模式（推荐）
/generate-monthly-report

# 只使用周报
/generate-monthly-report weekly-only
```

### Utils 插件

#### 提交总结

```bash
# 总结当前更改并生成 commit
/commit-summary
```

#### PR 摘要

```bash
# 相对于 upstream/master 生成 PR 摘要
/summarize-pr

# 指定 base 分支
/summarize-pr main
```

#### 对话总结

```bash
# 总结本次对话内容
/summary
```

---

## 📁 项目结构

```
claude-code-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # 市场配置
├── plugins/
│   ├── work-report/              # 工作报告插件
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/             # 斜杠命令
│   │   ├── skills/               # Agent 技能
│   │   ├── hooks/                # 钩子
│   │   └── README.md
│   └── utils/                    # 工具集插件
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── commands/
│       └── README.md
├── docs/
│   └── installation.md           # 详细安装指南
└── README.md                      # 本文件
```

---

## 🤝 贡献指南

欢迎贡献新的插件或改进现有插件！

1. Fork 本仓库
2. 创建新的插件目录 `plugins/your-plugin/`
3. 添加必要的配置文件和文档
4. 更新 `marketplace.json`
5. 提交 Pull Request

---

## 📄 许可证

MIT License

---

## 🔗 相关链接

- [Claude Code 官方文档](https://code.claude.com/docs)
- [插件开发指南](https://code.claude.com/docs/en/plugins)
- [Hooks 使用指南](https://code.claude.com/docs/en/hooks)

---

## 📝 更新日志

### v1.0.0 (2024-11-06)

- 🎉 首次发布
- ✅ 工作报告插件（日报、周报、月报）
- ✅ 开发工具集插件（commit、PR、summary）
- ✅ 完整的文档和示例
