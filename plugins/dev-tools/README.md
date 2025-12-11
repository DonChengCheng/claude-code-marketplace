# Dev Tools Plugin

专业开发工具集插件，包含 6 个专家级 Agent、1 个开发流程 Skill 和 1 个自定义命令，支持完整功能开发工作流。

## 🎯 快速开始

使用自定义命令启动完整功能开发流程：

```
/dev-tools:develop-feature 实现用户认证功能
```

该命令会触发 `feature-development-workflow` Skill，自动协调各个 Agent 完成：
1. **需求分析** → 收集和澄清需求
2. **架构设计** → `feature-architect` 设计方案
3. **代码实现** → `code-implementation-specialist` TDD 实现
4. **代码审查** → `code-review-specialist` 质量检查
5. **代码清理** → `code-cleanup` 清理调试代码

---

## 📁 插件结构

```
dev-tools/
├── agents/                    # 6 个专家级 Agent
│   ├── code-review-specialist.md
│   ├── debug-specialist.md
│   ├── feature-architect.md
│   ├── code-implementation-specialist.md
│   ├── code-cleanup.md
│   └── workflow-orchestrator.md
├── skills/                    # 开发流程 Skill
│   └── feature-development-workflow/
│       └── SKILL.md
├── commands/                  # 自定义命令
│   └── develop-feature.md
└── docs/
    └── workflow-patterns.md
```

---

## 📦 包含的 Agents

### 1. Code Review Specialist（代码审查专家）🟢

**专长**：全面的代码质量、安全性和可维护性审查

**核心能力：**
- 代码质量分析：评估清晰度、效率和最佳实践
- 安全漏洞识别：检测 OWASP Top 10 漏洞
- 可维护性评估：审查结构、命名、文档完整性
- 改进建议：提供具体、可操作的方案和代码示例

**适用场景：**
- 提交代码前的自我审查
- Pull Request 审查
- 重要功能的安全检查

---

### 2. Debug Specialist（调试专家）🔴

**专长**：错误诊断、根因分析和系统故障排除

**核心能力：**
- 即时评估：快速识别错误类型和严重程度
- 系统调查：逐行分析错误消息和堆栈追踪
- 根因分析：区分症状和根本原因
- 解决方案：提供具体的修复方案和代码更正

**适用场景：**
- 遇到运行时错误
- 测试失败
- 代码行为异常

---

### 3. Feature Architect（功能架构师）🔵

**专长**：全栈功能开发和架构设计

**核心能力：**
- 架构设计：系统架构分析和集成方案
- 功能分解：复杂需求拆分为可管理组件
- 实施策略：模块化开发和渐进式实现
- 未来规划：可扩展和可维护的设计

**工作流程：**
1. 深度需求分析
2. 架构调研
3. 系统设计
4. 实施策略
5. 智能实现
6. 质量与文档

---

### 4. Code Cleanup（代码清理专家）🟠

**专长**：识别和清理冗余、未使用和失败的代码修复尝试

**核心能力：**
- Git 历史深度分析：分析多个提交识别失败的修复尝试
- 失败修复检测：识别调试过程中添加但最终未使用的代码
- 提交信息分析：查找"试试"、"临时"、"测试"等关键词
- 死代码路径分析：检测从未执行或已过时的代码路径

**清理目标：**
- 调试语句（console.log, print, debugger）
- 未使用的导入
- 注释掉的代码块
- 临时变量和实验性代码

---

### 5. Workflow Orchestrator（工作流编排器）🟣

**专长**：智能工作流编排，自动协调多个 Agent 完成开发任务

**核心能力：**
- 意图识别：分析用户请求，确定合适的工作流
- 工作流模式：支持功能开发、Bug修复、代码审查、重构等
- Agent 协调：按最优顺序调用专业 Agent
- 质量门禁：确保每个阶段满足质量标准

**工作流模式：**
- **功能开发**: feature-architect → code-implementation → code-review → cleanup
- **Bug修复**: debug-specialist → code-implementation → code-review → cleanup
- **代码审查**: code-review-specialist (+ optional cleanup)
- **重构**: feature-architect → code-implementation → code-review → cleanup

---

### 6. Code Implementation Specialist（代码实现专家）🔶

**专长**：自动化代码实现，使用测试驱动开发（TDD）

**核心能力：**
- 计划解析：将架构设计转化为可执行任务
- 执行计划：创建透明的、用户可审批的执行计划
- TDD 实现：RED-GREEN-REFACTOR 循环
- 自动修复：错误自动修复（最多3次尝试）
- 验证管理：测试、Lint、类型检查、构建

**工作流程：**
1. 创建执行计划并获取用户批准
2. 对每个任务执行 TDD 循环
3. 运行综合验证
4. 输出结果供代码审查

---

## 🚀 使用方式

### 方式一：使用自定义命令（推荐）

```bash
# 启动完整功能开发流程
/dev-tools:develop-feature 实现用户通知系统

# 不带参数时会交互式询问需求
/dev-tools:develop-feature
```

### 方式二：直接调用 Agent

这些 Agent 通过 Claude Code 的 Task 工具自动调用，系统会根据任务类型智能选择合适的 Agent。

| Agent | 触发场景 |
|-------|---------|
| Code Review | 编写或修改代码后 |
| Debug Specialist | 遇到错误或测试失败 |
| Feature Architect | 开发新功能或重构 |
| Code Cleanup | 功能完成后或代码审查时 |
| Workflow Orchestrator | 执行完整开发流程 |
| Code Implementation | 架构设计完成后的自动实现 |

### 方式三：手动指定 Agent

```
"请用 code-review-specialist 审查这段代码"
"用 debug-specialist 帮我分析这个错误"
"用 feature-architect 设计用户认证功能"
"用 workflow-orchestrator 实现一个新功能"
```

---

## 🔄 工作流示例

### 使用命令启动完整流程

```bash
/dev-tools:develop-feature 实现用户通知系统

# Skill 自动协调执行:
# Phase 1: 需求分析和代码库探索
# Phase 2: feature-architect (架构设计)
# Phase 3: code-implementation-specialist (TDD实现)
# Phase 4: code-review-specialist (代码审查)
# Phase 5: code-cleanup (代码清理)
# Phase 6: 完成总结
```

### 手动逐步执行

```bash
# 1. 设计阶段
"用 feature-architect 设计通知系统"
# ... 审核设计 ...

# 2. 实现阶段
"用 code-implementation-specialist 实现设计"
# ... 审核代码 ...

# 3. 审查阶段
"用 code-review-specialist 审查代码"
```

## 📖 最佳实践

### Code Review
- 提交前自我审查
- 重视安全问题
- 及时修复 Critical/High 问题

### Debugging
- 先理解错误再修复
- 修复根本原因，不只是症状
- 添加测试防止回归

### Feature Development
- 充分规划再实施
- 遵循既定架构模式
- 考虑未来扩展性

### Code Cleanup
- 定期清理，不要累积
- 清理前确保代码已提交
- 逐步清理，每次测试

## ⚙️ 配置

这些 Agent 无需额外配置，安装插件后自动可用。

## 🤝 贡献

欢迎改进这些 Agent！如果你有好的想法：

1. Fork 项目
2. 修改 agent 文件
3. 提交 Pull Request

## 📄 许可证

MIT License

## 🔗 相关资源

- [Claude Code Agents 文档](https://code.claude.com/docs/en/agents)
- [Task Tool 使用指南](https://code.claude.com/docs/en/task-tool)
- [主项目 GitHub](https://github.com/DonChengCheng/claude-code-marketplace)
