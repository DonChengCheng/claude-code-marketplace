---
description: 创建 GitLab Merge Request，自动生成标题和描述
allowed-tools: [Bash, Grep, Read, AskUserQuestion]
argument-hint: [remote/branch]
---

请帮我创建一个 GitLab Merge Request。

**步骤**:

1. **解析目标分支参数**
   - 参数格式：`$1` = `远程仓库名/分支名`（如 `upstream/master`）
   - 如果未指定参数，询问用户：
     - 远程仓库名（origin / upstream / 自定义）
     - 目标分支名（main / master / develop / 自定义）

2. **获取远程目标分支最新状态**
   ```bash
   git fetch ${REMOTE} ${BRANCH}
   ```
   - 确保本地有目标分支的最新引用
   - **如果 fetch 失败**：询问用户是否使用本地缓存继续（可能不准确）

3. **获取提交历史**（必须使用远程分支引用）
   ```bash
   # 当前分支相对于远程目标分支的提交
   git log ${REMOTE}/${BRANCH}..HEAD --pretty=format:"%h %s" --no-merges
   ```

4. **分析变更内容**
   - 基于提交历史生成简洁的 MR 标题
   - 生成 MR 描述（包含变更摘要）

5. **创建 MR**
   ```bash
   glab mr create --title "标题" --description "描述" --target-branch "${BRANCH}"
   ```

**参数说明**:
- `$1` = `远程仓库/分支`（如 `upstream/master`、`origin/main`）
- 如果未提供，将询问用户选择

**重要**：必须使用 `${REMOTE}/${BRANCH}` 而非本地分支引用进行比较，确保只包含当前分支的新增提交。
