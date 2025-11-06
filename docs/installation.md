# 安装指南

本文档详细介绍如何安装和配置 Claude Code 插件市场中的插件。

## 📋 前提条件

在开始之前，请确保：

1. ✅ 已安装 [Claude Code](https://claude.com/claude-code)
2. ✅ Claude Code 版本 >= 1.0.0
3. ✅ 熟悉基本的命令行操作

## 🚀 快速安装

### 方法 1：安装整个市场

安装市场后，所有插件都会可用：

```bash
# 在 Claude Code 中执行
/plugin install https://github.com/your-username/claude-code-marketplace
```

### 方法 2：安装单个插件

如果只需要特定插件：

```bash
# 安装工作报告插件
/plugin install work-report@claude-code-marketplace

# 安装工具集插件
/plugin install utils@claude-code-marketplace
```

## 📦 安装步骤详解

### 步骤 1：获取市场 URL

1. 访问 GitHub 仓库：`https://github.com/your-username/claude-code-marketplace`
2. 复制仓库 URL

### 步骤 2：在 Claude Code 中安装

```bash
# 打开 Claude Code
# 输入命令
/plugin install <marketplace-url>
```

### 步骤 3：验证安装

```bash
# 查看已安装的插件
/plugin list

# 查看可用命令
/help
```

你应该能看到新增的命令：
- `/generate-daily-report`
- `/generate-weekly-report`
- `/generate-monthly-report`
- `/commit-summary`
- `/summarize-pr`
- `/summary`

## ⚙️ 配置

### Work Report 插件配置

#### 1. 配置平台映射（可选但推荐）

编辑配置文件以自定义项目到平台的映射：

```bash
# 找到插件目录
cd ~/.claude/plugins/work-report/skills/daily-report/

# 编辑配置
vim platform-config.json
```

配置示例：

```json
{
  "example-web-app": "网页",
  "test-web-project": "网页",
  "my-mobile-app": "微信小程序",
  "your-project-name": "你的平台名称"
}
```

#### 2. 自定义报告模板（高级）

```bash
# 模板文件位置
~/.claude/plugins/work-report/skills/daily-report/template.md
~/.claude/plugins/work-report/skills/weekly-report/template.md
~/.claude/plugins/work-report/skills/monthly-report/template.md

# 根据需要修改模板
```

### Utils 插件配置

Utils 插件通常无需额外配置，开箱即用。

如需自定义 Summary 输出位置：

```bash
# 编辑命令文件
vim ~/.claude/plugins/utils/commands/summary.md

# 修改输出路径（默认为 CLAUDE.local.md）
```

## 🔍 验证安装

### 测试 Work Report

```bash
# 测试日报生成
/generate-daily-report template

# 应该生成一个空白日报模板
```

### 测试 Utils

```bash
# 在一个 Git 仓库中
/commit-summary

# 应该能分析 Git 状态
```

## 🛠️ 高级安装

### 从源码安装

如果你想从本地源码安装（用于开发或测试）：

```bash
# 克隆仓库
git clone https://github.com/your-username/claude-code-marketplace.git

# 安装本地版本
/plugin install file:///path/to/claude-code-marketplace
```

### 指定版本安装

```bash
# 安装特定版本
/plugin install work-report@claude-code-marketplace#v1.0.0

# 安装最新开发版
/plugin install work-report@claude-code-marketplace#main
```

## 📝 .gitignore 配置

为了避免提交个人配置和生成的报告，建议在项目中添加：

```gitignore
# 工作报告
日报_*.md
周报_*.md
*工作月报.md

# Claude 对话总结
CLAUDE.local.md

# PR 摘要
PR-*.md
```

## 🔄 更新插件

### 检查更新

```bash
# 查看插件状态
/plugin list

# 查看是否有更新
/plugin check-updates
```

### 更新到最新版本

```bash
# 更新所有插件
/plugin update

# 更新特定插件
/plugin update work-report
/plugin update utils
```

## 🗑️ 卸载插件

```bash
# 卸载特定插件
/plugin uninstall work-report
/plugin uninstall utils

# 卸载整个市场
/plugin uninstall claude-code-marketplace
```

## ⚠️ 常见问题

### Q1: 安装失败，提示 "Plugin not found"

**原因：**URL 错误或网络问题

**解决：**
```bash
# 检查 URL 是否正确
# 检查网络连接
# 尝试使用 HTTPS clone URL
```

### Q2: 命令不显示

**原因：**安装后未刷新或命令冲突

**解决：**
```bash
# 重启 Claude Code
# 或执行
/reload

# 检查命令
/help
```

### Q3: Hooks 不生效

**原因：**Hooks 配置问题或权限问题

**解决：**
```bash
# 检查 hooks 文件权限
chmod +x ~/.claude/plugins/work-report/hooks/scripts/pre-bash.sh

# 查看 hooks 配置
cat ~/.claude/plugins/work-report/hooks/hooks.json
```

### Q4: 平台识别错误

**原因：**`platform-config.json` 配置不正确

**解决：**
```bash
# 检查配置
cat ~/.claude/plugins/work-report/skills/daily-report/platform-config.json

# 确保项目路径关键字正确
# 更新配置后重新生成报告
```

### Q5: Git 导入失败

**原因：**路径错误或不是 Git 仓库

**解决：**
```bash
# 使用绝对路径
/generate-daily-report /absolute/path/to/project

# 检查是否是 Git 仓库
cd /path/to/project && git status
```

## 🔐 权限说明

插件会请求以下权限：

### Work Report 插件
- ✅ 读取文件（读取已有报告）
- ✅ 写入文件（生成新报告）
- ✅ 执行 Git 命令（导入提交数据）
- ✅ Bash 命令（运行 hooks）

### Utils 插件
- ✅ 读取文件（分析代码变更）
- ✅ 写入文件（保存摘要）
- ✅ 执行 Git 命令（分析提交历史）

**安全提示：**
- 所有命令都在本地执行
- 不会上传任何数据到远程服务器
- 生成的文件仅保存在本地

## 📚 后续步骤

安装完成后，建议：

1. 📖 阅读 [Work Report 使用指南](../plugins/work-report/README.md)
2. 📖 阅读 [Utils 使用指南](../plugins/utils/README.md)
3. 🎯 尝试生成第一份日报
4. ⭐ Star 本项目，支持开发

## 💬 获取帮助

如遇到问题：

1. 📖 查看 [主 README](../README.md)
2. 🐛 提交 [Issue](https://github.com/your-username/claude-code-marketplace/issues)
3. 💬 参与 [Discussions](https://github.com/your-username/claude-code-marketplace/discussions)

## 🔗 相关资源

- [Claude Code 官方文档](https://code.claude.com/docs)
- [插件开发指南](https://code.claude.com/docs/en/plugins)
- [Hooks 使用指南](https://code.claude.com/docs/en/hooks)
- [本项目 GitHub](https://github.com/your-username/claude-code-marketplace)
