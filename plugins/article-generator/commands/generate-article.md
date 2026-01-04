---
description: 智能文章生成器,支持快速生成和引导式创作,可使用Web搜索获取最新信息
allowed-tools: [Skill, WebSearch, WebFetch, Write, Read, Bash, AskUserQuestion]
argument-hint: [主题] [--guided] [--type=类型] [--search]
---

# 文章生成命令

此命令调用智能文章生成 Skill,根据用户指定主题生成高质量文章。

## 使用说明

### 快速生成模式

直接提供主题,自动生成文章:

```
/generate-article 如何学习编程
/generate-article "人工智能的未来发展趋势"
```

### 引导式模式

通过对话逐步确定文章细节:

```
/generate-article --guided
/generate-article 如何学习编程 --guided
```

### 指定文章类型

```
/generate-article 如何学习编程 --type=tutorial
/generate-article 10个提升效率的工具 --type=listicle
```

可用类型: expository(说明文), argumentative(议论文), tutorial(教程),
         listicle(列表文), review(评论), narrative(叙事), how-to(操作指南)

### 启用Web搜索

获取最新信息以丰富文章内容:

```
/generate-article 2024年AI发展趋势 --search
/generate-article "最新前端技术" --guided --search
```

## 执行

请使用 **article-generator:article-generation** skill 帮我生成文章。

$ARGUMENTS
