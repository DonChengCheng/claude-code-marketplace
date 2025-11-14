# Workflow Patterns Guide

本文档描述了 `workflow-orchestrator` Agent 支持的所有工作流模式，以及如何使用和自定义这些工作流。

## 目录

- [预定义工作流](#预定义工作流)
- [工作流详解](#工作流详解)
- [自定义工作流](#自定义工作流)
- [最佳实践](#最佳实践)
- [故障排除](#故障排除)

---

## 预定义工作流

### 快速参考表

| 工作流名称 | 触发关键词 | 阶段数 | 预计时间 | 适用场景 |
|-----------|----------|--------|---------|---------|
| **feature-development** | 实现、开发、添加功能 | 5-6 | 30-60分钟 | 新功能开发 |
| **bug-fix** | bug、错误、修复 | 4 | 15-30分钟 | Bug 修复 |
| **quality-check** | 审查、检查质量 | 1-2 | 5-10分钟 | 代码审查 |
| **refactoring** | 重构、优化结构 | 4-5 | 30-45分钟 | 代码重构 |
| **cleanup-only** | 清理代码 | 1 | 5分钟 | 快速清理 |

---

## 工作流详解

### 1. Feature Development Workflow（功能开发流程）

**完整流程图：**
```
用户请求
  ↓
[1] feature-architect
  ├─ 需求分析
  ├─ 架构设计
  ├─ 技术选型
  └─ 实现计划
  ↓
[2] code-implementation-specialist (自动化)
  ├─ 执行计划创建
  ├─ TDD 实现 (RED-GREEN-REFACTOR)
  ├─ 自动错误修复 (3次重试)
  └─ 综合验证
  ↓
[3] code-review-specialist
  ├─ 质量检查
  ├─ 安全审查
  └─ 最佳实践验证
  ↓
[4] ⚠️ 质量门检查
  ├─ PASS → 继续
  └─ FAIL → debug-specialist
  ↓
[5] code-cleanup
  ├─ 移除调试代码
  ├─ 清理注释代码
  └─ 优化导入
  ↓
[6] 可选：并行执行
  ├─ pr-summary-generator
  └─ daily-report 更新
```

**触发示例：**
```
✓ "实现用户认证功能"
✓ "添加文件上传接口"
✓ "开发数据导出模块"
✓ "create a search feature"
```

**每个阶段详解：**

#### 阶段 1: Feature Architect
**输入：**
- 功能需求描述
- 现有代码库上下文
- 技术栈信息

**输出：**
- 📄 `docs/[feature]-design.md` - 架构设计文档
- 📋 实现计划（分步骤）
- 🔧 技术选型建议
- 💡 最佳实践提示

**质量标准：**
- 设计清晰易懂
- 考虑了扩展性
- 技术选型合理

#### 阶段 2: Code Implementation (自动化)

**输入：**
- feature-architect 的实现计划
- 设计文档
- 技术选型建议

**执行计划创建：**
```
📋 Execution Plan for: 用户认证功能
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task 1: 用户模型
  - File: models/user.js
  - Tests: tests/models/user.test.js
  - Complexity: Low

Task 2: 密码哈希
  - File: utils/crypto.js
  - Tests: tests/utils/crypto.test.js
  - Complexity: Low

...

Total: 4 tasks, 8 files (4 implementation + 4 test)
Estimated time: 15-20 minutes

Proceed with implementation? (yes/modify/cancel)
```

**TDD 实现循环（每个任务）：**
1. **RED**: 先写测试，验证失败
2. **GREEN**: 实现最小代码使测试通过
3. **REFACTOR**: 优化代码，保持测试通过

**自动错误修复：**
- Attempt 1: 模式匹配修复
- Attempt 2: debug-specialist 逻辑
- Attempt 3: 更广泛上下文分析
- 超过3次 → 升级给用户

**输出：**
- 实现的代码文件
- 完整测试套件
- 验证报告（测试、Linter、类型检查、构建）
- 关键实现决策列表

#### 阶段 3: Code Review
**检查项：**
- ✓ 代码质量（可读性、复杂度）
- ✓ 安全漏洞（OWASP Top 10）
- ✓ 性能问题
- ✓ 最佳实践
- ✓ 错误处理

**输出：**
```
📋 Code Review Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall Quality: Good ✓

Issues Found:
  🔴 Critical (0)
  🟠 High (0)
  🟡 Medium (2):
    1. auth.js:45 - Use bcrypt instead of MD5
    2. token.js:23 - Add token expiration check
  🟢 Low (3):
    ...

Quality Gate: PASSED ✓
```

#### 阶段 4: Quality Gate
**通过条件：**
- `critical_issues == 0`
- `high_issues == 0`

**失败处理：**
```
⚠️ Quality Gate FAILED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Critical Issues: 1
  - SQL injection vulnerability in user query

Options:
  1. [Recommended] Launch debug-specialist for help
  2. Fix manually and retry review
  3. Override gate (requires justification)

Choose option (1/2/3):
```

#### 阶段 5: Cleanup
**清理内容：**
- 🧹 `console.log`, `print()`, `debugger` 语句
- 🧹 注释掉的代码块
- 🧹 未使用的导入和变量
- 🧹 临时测试代码
- 🧹 调试时添加的注释

#### 阶段 6: 后续任务（可选）
**并行执行：**
```
[Stage 6/6] Optional Tasks (parallel)
  ├─ pr-summary-generator
  │   └─ Generated: PR-summary-auth-feature.md
  └─ daily-report
      └─ Updated: 日报_2024-11-10.md
```

---

### 2. Bug Fix Workflow（Bug 修复流程）

**流程图：**
```
错误报告
  ↓
[1] debug-specialist
  ├─ 错误分析
  ├─ 根因定位
  ├─ 修复方案
  └─ 测试建议
  ↓
[2] code-implementation-specialist (自动化)
  ├─ 执行计划创建 (包含回归测试)
  ├─ TDD 实现修复
  ├─ 自动错误修复
  └─ 综合验证
  ↓
[3] code-review-specialist
  ├─ 验证修复正确性
  ├─ 检查边界情况
  └─ 防止回归
  ↓
[4] code-cleanup
  └─ 清理调试代码
```

**触发示例：**
```
✓ "登录接口报错 TypeError"
✓ "测试失败：test_user_creation"
✓ "数据库连接异常"
✓ "fix the broken API endpoint"
```

**阶段详解：**

#### 阶段 1: Debug Specialist
**分析内容：**
```
🔍 Debug Analysis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Error: TypeError: Cannot read property 'id' of undefined
Location: auth/login.js:45
Stack Trace: <详细堆栈>

Root Cause Analysis:
  ❌ Problem:
     User.findOne() returns null when email not found
     Code assumes user always exists

  🎯 Root Cause:
     Missing null check before accessing user.id

  ✅ Solution:
     Add null validation:
     if (!user) {
       return res.status(401).json({ error: 'Invalid credentials' });
     }

  🧪 Test Recommendations:
     1. Test with non-existent email
     2. Test with empty email
     3. Test with malformed email
```

#### 阶段 2: Apply Fix (自动化)

**输入：**
- debug-specialist 的修复策略
- 根因分析
- 建议的测试用例

**自动执行：**
1. 创建执行计划（包含回归测试）
2. 使用 TDD 实现修复：
   - 先写回归测试（复现 bug）
   - 实现修复使测试通过
   - 添加边界测试用例
3. 运行验证套件
4. 如遇错误 → 自动修复（最多3次）

**用户交互：**
- 仅在遇到模糊性时询问
- 自动修复失败时请求指导

**输出：**
- 修复代码
- 回归测试
- 验证报告

#### 阶段 3: Verification Review
**验证重点：**
- ✓ 修复解决了根本原因
- ✓ 没有引入新问题
- ✓ 边界情况已处理
- ✓ 测试用例已添加

---

### 3. Code Quality Check Workflow（质量检查流程）

**流程图：**
```
代码审查请求
  ↓
[1] code-review-specialist
  ├─ 全面质量分析
  ├─ 安全检查
  └─ 可维护性评估
  ↓
[2] code-cleanup (如果需要)
  └─ 清理建议
```

**触发示例：**
```
✓ "审查这段代码"
✓ "检查代码质量"
✓ "review my changes"
✓ "这个实现有问题吗？"
```

**适用场景：**
- 快速代码审查
- PR 前检查
- 学习最佳实践
- 代码质量评估

---

### 4. Refactoring Workflow（重构流程）

**流程图：**
```
重构需求
  ↓
[1] feature-architect (重构模式)
  ├─ 当前代码分析
  ├─ 重构策略设计
  ├─ 风险评估
  └─ 分步迁移计划
  ↓
[2] 👤 用户执行重构
  ↓
[3] code-review-specialist
  ├─ 功能完整性验证
  ├─ 性能影响评估
  └─ 代码质量提升确认
  ↓
[4] code-cleanup
  └─ 清理旧代码残留
```

**触发示例：**
```
✓ "重构 API 层使用更好的模式"
✓ "优化数据库查询结构"
✓ "refactor the authentication module"
```

---

## 自定义工作流

### 创建自定义工作流

**方法 1: 命令式指定**
```
User: "Run feature-architect and code-review, skip cleanup"

Orchestrator:
✓ Custom workflow created:
  Stage 1: feature-architect
  Stage 2: code-review-specialist
  (cleanup skipped)
```

**方法 2: 条件执行**
```
User: "Review code, and cleanup only if there are issues"

Orchestrator:
✓ Conditional workflow:
  Stage 1: code-review-specialist
  Stage 2: code-cleanup (if issues found)
```

**方法 3: 并行执行**
```
User: "Run code-review and pr-summary in parallel"

Orchestrator:
✓ Parallel workflow:
  Stage 1 (parallel):
    ├─ code-review-specialist
    └─ pr-summary-generator
```

### 保存常用工作流

```
User: "Save this workflow as 'quick-check'"

Orchestrator:
✓ Workflow saved: quick-check
  Usage: "run quick-check workflow"
```

---

## 最佳实践

### 1. 选择合适的工作流

| 情况 | 推荐工作流 | 理由 |
|------|----------|------|
| 新功能从零开始 | feature-development | 需要完整的设计和质量保证 |
| 小功能快速添加 | quality-check | 直接实现后审查 |
| 遇到错误或 bug | bug-fix | 需要根因分析 |
| 代码结构优化 | refactoring | 需要重构设计 |
| PR 前最后检查 | quality-check | 快速审查 |

### 2. 质量门策略

**严格模式（推荐用于生产代码）：**
- Critical/High 必须为 0
- 不允许跳过审查
- 强制执行 cleanup

**宽松模式（用于原型开发）：**
- 允许 Medium 问题
- 可跳过非关键步骤
- cleanup 可选

### 3. 手动介入时机

**仍需手动介入：**
- ✋ 批准执行计划（阶段 2 开始前）
- ✋ 回答实现决策问题（库选择、命名约定等）
- ✋ 自动修复失败后的错误解决

**已自动化：**
- ✅ 代码编写（TDD 实现）
- ✅ 测试编写（先于实现）
- ✅ 错误修复（3次重试）
- ✅ 代码验证（测试、Linter、构建）

**可选手动介入：**
- 💬 质量门失败时的决策
- 💬 跳过可选阶段
- 💬 自定义工作流

### 4. 上下文管理

**确保传递的信息：**
- 📋 原始用户请求
- 📋 项目技术栈
- 📋 修改的文件列表
- 📋 前一阶段的输出
- 📋 质量门结果

---

## 故障排除

### 常见问题

#### Q1: 工作流选择错误

**问题：**
```
User: "实现登录功能"
Orchestrator: ✓ Detected: Bug Fix Task (错误)
```

**解决：**
```
User: "取消，这是新功能开发"
Orchestrator: ✓ Switching to feature-development workflow
```

**预防：**
使用明确的触发词：
- "开发新功能" 而不是 "做登录"
- "修复 bug" 而不是 "登录有问题"

#### Q2: 质量门卡住

**问题：**
```
[Stage 3/5] Quality Gate: FAILED
Critical Issues: 1

(用户不知道怎么办)
```

**解决：**
```
Options:
  1. Launch debug-specialist → 获取修复帮助
  2. Show detailed report → 查看具体问题
  3. Override (not recommended) → 强制通过（不推荐）

选择 1 获取帮助
```

#### Q3: Agent 执行失败

**问题：**
```
[Stage 2/5] code-review-specialist
❌ Agent failed: Timeout
```

**解决：**
```
Orchestrator:
⚠️ Agent timeout

Options:
  1. Retry (recommended)
  2. Skip this stage
  3. Cancel workflow

Auto-retry in 10s... (Press Enter to retry now)
```

#### Q4: 忘记当前阶段

**问题：**
用户离开一段时间，忘记工作流状态

**解决：**
```
User: "status" 或 "where am I?"

Orchestrator:
📊 Workflow Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Workflow: feature-development
Progress: [████████░░] 80% (Stage 4/5)

Completed:
  ✓ Stage 1: feature-architect
  ✓ Stage 2: Manual implementation
  ✓ Stage 3: code-review-specialist

Current:
  ⏸ Stage 4: Paused - Awaiting user input

Next:
  ⏭ Stage 5: code-cleanup

Waiting for: Type 'continue' to proceed
```

---

## 工作流组合示例

### 示例 1: 完整开发周期

```
Day 1:
  1. feature-development workflow
     → 设计 + 实现 + 审查

Day 2:
  2. bug-fix workflow (发现问题)
     → 调试 + 修复 + 验证

  3. quality-check workflow (PR 前)
     → 最终审查

  4. pr-summary (生成 PR)
     → 创建 PR 描述
```

### 示例 2: 快速迭代

```
Iteration 1:
  - quick-check (自定义)
    → code-review only

Iteration 2:
  - feature-development (精简版)
    → skip feature-architect (设计已完成)
    → code-review + cleanup
```

---

## 总结

Workflow Orchestrator 通过预定义的工作流模式，自动化了多个 Agent 的协调执行，大幅提升开发效率。

**关键收益：**
- ✅ 自动化重复流程
- ✅ 强制执行最佳实践
- ✅ 减少手动切换 Agent
- ✅ 确保质量门不被跳过
- ✅ 提供清晰的进度反馈

**下一步：**
- 阅读 [Agent Collaboration Guide](./agent-collaboration.md)
- 查看 [Workflow Examples](./workflow-examples.md)
- 尝试运行第一个工作流！
