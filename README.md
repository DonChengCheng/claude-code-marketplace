# Claude Code 插件市场

这是一个 Claude Code 插件市场，提供工作报告生成、开发工具、文章生成等实用插件。

## 📦 可用插件

### 1. Work Report（工作报告生成器）

智能工作报告生成工具，支持日报、周报、月报的自动生成与数据聚合。

**版本**: v1.1.7

**主要功能：**
- 📝 **日报生成**：支持交互式、Git导入、文件导入、继续昨日四种模式
- 📊 **周报生成**：自动聚合日报数据，支持任务分类与统计
- 📈 **月报生成**：智能混合周报和日报数据，自动填补覆盖缺口
- 🎯 **智能推断**：自动识别任务类型、平台、工时计算
- 🔗 **Git 集成**：支持从 Git 提交记录导入任务数据

**包含命令：**
- `/work-report:generate-daily-report` - 生成日报
- `/work-report:generate-weekly-report` - 生成周报
- `/work-report:generate-monthly-report` - 生成月报
- `/work-report:config-platform` - 配置平台映射

**包含 Skills：**
- `daily-report` - 日报生成智能 Agent
- `weekly-report` - 周报生成智能 Agent
- `monthly-report` - 月报生成智能 Agent

**包含 Hooks：**
- `pre-bash` - 工作目录保护，防止意外 `cd` 命令

---

### 2. Developer Toolkit（开发工具集）

Git 工作流工具集，提供自动化的提交、MR 摘要生成和 GitLab MR 创建功能。

**版本**: v2.0.0

**主要功能：**
- 🔄 **自动提交**：分析变更并生成规范的提交信息
- 📋 **MR 摘要**：按 Conventional Commit 类型分类，生成结构化摘要
- 🚀 **GitLab MR**：一键创建 Merge Request

**包含命令：**
- `/devkit:commit` - 自动生成提交信息并创建 Git 提交
- `/devkit:mr-summary` - 生成 MR 摘要文档 (MR_SUMMARY.md)
- `/devkit:create-mr` - 创建 GitLab Merge Request

---

### 3. Article Generator（文章生成器）

智能文章生成工具，支持多种文章类型、快速生成与引导式创作、Web搜索集成。

**版本**: v1.0.0

**主要功能：**
- ✍️ **双模式生成**：快速生成 / 引导式定制
- 📚 **多种文章类型**：说明文、议论文、教程、列表文、评论、叙事文、操作指南
- 🔍 **Web搜索集成**：自动搜索最新资料，智能信息整合
- 🎨 **写作风格定制**：专业正式 / 通俗易懂 / 轻松幽默 / 简洁精炼

**包含命令：**
- `/article-generator:generate-article` - 生成文章

**使用示例：**
```bash
# 快速生成
/article-generator:generate-article 如何学习编程

# 指定类型
/article-generator:generate-article 如何学习Python --type=tutorial

# 启用Web搜索
/article-generator:generate-article 2024年AI发展趋势 --search

# 引导式生成
/article-generator:generate-article --guided
```

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

# 只安装开发工具集插件
/plugin install developer-toolkit@DonChengCheng/claude-code-marketplace

# 只安装文章生成器插件
/plugin install article-generator@DonChengCheng/claude-code-marketplace
```

---

## 📖 使用指南

### Work Report 插件

#### 1. 生成日报

```bash
# 交互式生成
/work-report:generate-daily-report

# 从 Git 提交导入（推荐）
/work-report:generate-daily-report

# 继续昨日任务
/work-report:generate-daily-report continue
```

**配置平台映射**（推荐）：

创建 `.work-report/platform-config.json` 或 `~/.claude/work-report/platform-config.json`：

```json
{
  "projectPlatformMapping": {
    "my-web-app": {
      "platform": "网页端",
      "path": "/Users/xxx/projects/my-web-app"
    },
    "my-mobile-app": {
      "platform": "移动端",
      "path": "/Users/xxx/projects/my-mobile-app"
    }
  }
}
```

或使用命令快速配置：
```bash
/work-report:config-platform
```

#### 2. 生成周报

```bash
# 自动聚合本周日报
/work-report:generate-weekly-report

# 指定数据源
/work-report:generate-weekly-report /path/to/reports
```

#### 3. 生成月报

```bash
# 智能混合模式（推荐）
/work-report:generate-monthly-report

# 只使用周报
/work-report:generate-monthly-report weekly-only
```

### Developer Toolkit 插件

#### 提交代码

```bash
# 自动生成提交信息并提交
/devkit:commit
```

#### MR 摘要生成

```bash
# 生成 MR 摘要文档
/devkit:mr-summary

# 指定基准分支
/devkit:mr-summary origin/main
```

#### 创建 GitLab MR

```bash
# 创建 MR 到目标分支
/devkit:create-mr upstream/master
```

### Article Generator 插件

#### 快速生成文章

```bash
# 自动推断类型
/article-generator:generate-article 如何学习编程

# 指定文章类型
/article-generator:generate-article 10个最佳VS Code插件 --type=listicle

# 启用Web搜索获取最新资料
/article-generator:generate-article "ChatGPT vs Claude对比评测" --type=review --search
```

#### 引导式生成

```bash
# 进入引导式流程，逐步定制文章细节
/article-generator:generate-article --guided
```

---

## 📁 项目结构

```
claude-code-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # 市场配置
├── plugins/
│   ├── work-report/              # 工作报告插件 (v1.1.7)
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/             # 4 个斜杠命令
│   │   ├── skills/               # 3 个 Skills + 共享资源
│   │   │   ├── daily-report/
│   │   │   ├── weekly-report/
│   │   │   ├── monthly-report/
│   │   │   └── shared/
│   │   ├── hooks/                # 工作目录保护 Hook
│   │   └── README.md
│   ├── developer-toolkit/        # 开发工具集插件 (v2.0.0)
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/             # 3 个斜杠命令
│   │   │   ├── commit.md
│   │   │   ├── mr-summary.md
│   │   │   └── create-mr.md
│   │   └── README.md
│   └── article-generator/        # 文章生成器插件 (v1.0.0)
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── commands/             # 1 个斜杠命令
│       │   └── generate-article.md
│       ├── skills/               # 1 个 Skill
│       │   └── article-writer/
│       └── README.md
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
