# Developer Toolkit

Git 工作流工具集，提供自动化的提交、MR 摘要生成和 GitLab MR 创建功能。

## 命令

| 命令 | 描述 |
|------|------|
| `/devkit:commit` | 自动生成提交信息并创建 Git 提交 |
| `/devkit:mr-summary` | 生成 MR 摘要文档 (MR_SUMMARY.md) |
| `/devkit:create-mr` | 创建 GitLab Merge Request |

## 快速使用

```bash
# 创建提交
/devkit:commit

# 生成 MR 摘要
/devkit:mr-summary

# 创建 GitLab MR
/devkit:create-mr upstream/master
```

## 功能详情

### /devkit:commit
- 自动分析 staged 和 unstaged 变更
- 查看最近提交历史
- 生成符合规范的提交信息
- 执行 git add 和 git commit

### /devkit:mr-summary
- 分析当前分支相对于基准分支的提交
- 按 Conventional Commit 类型分类
- 检测涉及的模块
- 生成结构化的中文 MR 摘要文档

### /devkit:create-mr
- 获取远程目标分支最新状态
- 分析提交历史
- 自动生成 MR 标题和描述
- 创建 GitLab Merge Request

## 版本信息

- **版本**: 2.0.0
- **许可证**: MIT
