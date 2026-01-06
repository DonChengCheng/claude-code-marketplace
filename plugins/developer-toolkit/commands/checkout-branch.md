---
description: 基于远程分支创建新分支并推送
allowed-tools: [Bash, AskUserQuestion]
argument-hint: [base-remote/branch] [target-remote/new-branch]
---

# 基于远程分支创建新分支

基于指定的远程分支创建新的本地分支，并推送到目标远程仓库。

## 参数说明

- `$1` - 基于分支：`仓库名/分支名`（如 `upstream/master`）
- `$2` - 新建分支：`仓库名/分支名`（如 `origin/fixbug-123`）

## 工作流程

### 步骤 1: 解析参数

**如果提供了参数 `$1` 和 `$2`**：
- 解析 `$1`（基于分支）→ 以 `/` 分割，提取 `BASE_REMOTE` 和 `BASE_BRANCH`
- 解析 `$2`（新建分支）→ 以 `/` 分割，提取 `TARGET_REMOTE` 和 `NEW_BRANCH`

**如果未提供参数**：
使用 AskUserQuestion 询问用户（可以同时询问多个问题）：

1. **基于的远程仓库**：upstream / origin / 自定义
2. **基于的分支名**：master / main / develop / 自定义
3. **新分支的目标远程仓库**：origin / upstream / 自定义
4. **新分支名称**：用户输入

### 步骤 2: 刷新基于分支的远程仓库

```bash
git fetch ${BASE_REMOTE} ${BASE_BRANCH}
```

### 步骤 3: 基于远程分支创建新分支并切换

```bash
git checkout -b ${NEW_BRANCH} ${BASE_REMOTE}/${BASE_BRANCH}
```

### 步骤 4: 推送新分支到目标远程仓库

```bash
git push -u ${TARGET_REMOTE} ${NEW_BRANCH}
```

### 步骤 5: 确认完成

输出创建成功的信息，包括：
- 新分支名称
- 基于的远程分支
- 推送的目标远程仓库

## 执行

$ARGUMENTS
