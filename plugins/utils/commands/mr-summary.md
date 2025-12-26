---
description: 生成当前分支的 MR 内容摘要，分析提交历史和文件变更
allowed-tools: [Skill]
argument-hint: [base-branch]
---

请使用 **utils:mr-summary** skill 来生成 MR 摘要。

**参数说明**：
- 如果提供了 `$1` 参数，使用指定的基准分支：`$1`
- 如果未提供参数，默认使用 `master`

请将基准分支参数传递给 skill 进行处理。
