# Article Generator Plugin

智能文章生成工具,支持多种文章类型、快速生成与引导式创作、Web搜索集成。

## 功能特性

### 双模式生成

1. **快速生成模式**: 只需提供主题,自动推断类型并生成完整文章
2. **引导式模式**: 通过对话逐步确定文章细节,定制化生成

### 多种文章类型

- 说明文 (Expository) - 客观解释概念或现象
- 议论文 (Argumentative) - 阐述观点并论证
- 教程 (Tutorial) - 步骤式教学指导
- 列表文 (Listicle) - 清单式内容组织
- 评论 (Review) - 分析评价特定对象
- 叙事文 (Narrative) - 故事性内容
- 操作指南 (How-to) - 实用操作步骤

### Web搜索集成

- 自动搜索最新资料
- 智能信息筛选与整合
- 来源标注与引用

### 写作风格定制

- 专业正式 - 学术/商业文档
- 通俗易懂 - 科普/大众传播
- 轻松幽默 - 博客/自媒体
- 简洁精炼 - 快速阅读

## 快速开始

### 基本使用

#### 快速生成

```bash
# 提供主题,自动生成
/generate-article 如何学习编程

# 带引号的长主题
/generate-article "人工智能在医疗领域的应用前景"
```

#### 引导式生成

```bash
# 进入引导式流程
/generate-article --guided

# 带主题的引导式
/generate-article 区块链技术入门 --guided
```

#### 指定文章类型

```bash
/generate-article 如何学习Python --type=tutorial
/generate-article 10个提升效率的工具 --type=listicle
/generate-article MacBook Pro评测 --type=review
```

#### 启用Web搜索

```bash
/generate-article 2024年AI发展趋势 --search
/generate-article "最新前端框架对比" --search --type=review
```

## 使用场景

### 场景 1: 技术博客写作

```bash
/generate-article React Hooks使用指南 --type=tutorial
```

生成包含:学习目标、前置条件、分步教程、代码示例、常见问题

### 场景 2: 资源推荐

```bash
/generate-article "10个最佳VS Code插件" --type=listicle
```

生成包含:每个插件介绍、功能特点、适用场景、对比表格

### 场景 3: 产品评测

```bash
/generate-article "ChatGPT vs Claude对比评测" --type=review --search
```

生成包含:产品概述、功能对比、优缺点分析、评分与建议

### 场景 4: 观点文章

```bash
/generate-article "为什么每个开发者都应该学习AI" --type=argumentative
```

生成包含:核心观点、论据支持、反对意见回应、结论呼吁

## 参数说明

| 参数 | 说明 | 示例 |
|-----|------|------|
| `[主题]` | 文章主题(可选) | `如何学习编程` |
| `--guided` | 启用引导式模式 | `--guided` |
| `--type=` | 指定文章类型 | `--type=tutorial` |
| `--search` | 启用Web搜索 | `--search` |

### 可用文章类型

| 类型值 | 中文名 | 描述 |
|-------|-------|------|
| `expository` | 说明文 | 客观解释概念 |
| `argumentative` | 议论文 | 阐述观点论证 |
| `tutorial` | 教程 | 步骤式教学 |
| `listicle` | 列表文 | 清单式组织 |
| `review` | 评论 | 分析评价 |
| `narrative` | 叙事文 | 故事性内容 |
| `how-to` | 操作指南 | 问题解决 |

## 输出说明

### 文件命名

```
格式: article_[主题]_[日期].md
示例: article_how-to-learn-python_2024-11-06.md
```

### 文件结构

```markdown
---
title: 文章标题
date: 2024-11-06
type: tutorial
topic: 如何学习Python
---

# 文章标题

## 第一章节
...

## 参考来源 (如启用搜索)
- [来源1](URL)
- [来源2](URL)
```

## 高级功能

### 智能类型推断

当不指定 `--type` 时,系统会根据主题关键词自动推断:

- "如何"、"怎么" → 教程
- "X个"、"Top N" → 列表文
- "评测"、"对比" → 评论
- "为什么"、"应该" → 议论文

### Web搜索优化

- 自动添加时间限定词
- 多角度搜索策略
- 信息可靠性筛选

## 注意事项

1. **Web搜索**: 需要网络连接,搜索结果受时效性影响
2. **文章长度**: 默认中等长度(1000-2000字),可在引导式中调整
3. **文件覆盖**: 同名文件会添加序号后缀,不会覆盖
4. **版权提示**: 搜索内容会标注来源,请注意引用规范

## 故障排查

### 问题: Web搜索无结果

**解决方案**:
- 检查网络连接
- 尝试更具体的主题关键词
- 使用 `--guided` 模式手动确认

### 问题: 文章类型推断不准确

**解决方案**:
- 使用 `--type=` 明确指定类型
- 使用 `--guided` 模式手动选择

### 问题: 生成内容不符合预期

**解决方案**:
- 使用 `--guided` 模式详细定制
- 生成后可要求修改特定章节

## 许可证

MIT License
