---
allowed-tools: Bash, Read, Write, AskUserQuestion
description: 配置项目与平台的映射关系，用于日报自动识别任务所属平台
---

# 配置平台映射

此命令帮助你创建和管理项目与平台的映射配置文件。配置后，日报生成时可以自动识别任务所属的平台（如网页端、移动端等）。

## 工作流程

### 步骤 1：选择配置文件位置

使用 `AskUserQuestion` 询问用户配置文件存放位置：

**选项**：
1. **全局配置** - `~/.claude/work-report/platform-config.json`
   - 适用于所有项目
   - 配置一次，全局生效
2. **项目配置** - `.work-report/platform-config.json`（当前工作目录下）
   - 仅适用于当前项目
   - 可提交到版本控制，团队共享

### 步骤 2：检查现有配置

根据用户选择的位置，检查是否已存在配置文件：
- 如果存在，读取并显示当前配置
- 询问用户是要追加新项目还是重新配置

### 步骤 3：扫描 Git 项目

使用以下命令扫描当前目录下的 git 项目，并获取绝对路径：

```bash
# 查找所有包含 .git 目录的项目，输出绝对路径
find "$(pwd)" -maxdepth 2 -name ".git" -type d 2>/dev/null | xargs -I {} dirname {}
```

提取每个项目的目录名作为项目标识，同时保存完整的绝对路径。

### 步骤 4：引导配置平台

对于扫描到的每个项目，使用 `AskUserQuestion` 询问用户该项目对应的平台名称：

**示例选项**：
- 网页端
- 移动端
- 后端服务
- 微信小程序
- 管理后台
- 其他（让用户输入）

用户也可以选择跳过某个项目。

### 步骤 5：生成配置文件

将收集到的映射关系写入配置文件，每个项目包含平台名称和完整路径：

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
    },
    "my-backend": {
      "platform": "后端服务",
      "path": "/Users/xxx/projects/my-backend"
    }
  }
}
```

如果选择全局配置，需要先创建 `~/.claude/work-report/` 目录：

```bash
mkdir -p ~/.claude/work-report
```

### 步骤 6：显示结果

完成后显示：
- 配置文件保存位置
- 已配置的项目数量
- 配置内容预览
- 提示用户在生成日报时会自动使用此配置

## 配置文件格式说明

```json
{
  "projectPlatformMapping": {
    "<项目目录名>": {
      "platform": "<平台显示名称>",
      "path": "<项目绝对路径>"
    },
    "example-web": {
      "platform": "网页端",
      "path": "/Users/xxx/projects/example-web"
    },
    "example-app": {
      "platform": "移动端",
      "path": "/Users/xxx/projects/example-app"
    }
  }
}
```

- **键**：项目的目录名（支持部分匹配）
- **值**：包含以下字段的对象
  - `platform`：在日报中显示的平台名称
  - `path`：项目的绝对路径，用于读取 git 提交记录

## 注意事项

- 如果同时存在全局配置和项目配置，日报生成时优先使用项目配置
- 项目目录名匹配采用包含匹配，如 `my-app` 可以匹配 `my-app-v2`
- 如果没有配置文件或项目未匹配到平台，日报总结中将省略平台标签
