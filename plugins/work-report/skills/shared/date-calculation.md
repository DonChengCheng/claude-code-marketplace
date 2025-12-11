# 日期计算逻辑

## 平台差异

macOS 和 Linux 的 `date` 命令语法不同，需要分别处理。

---

## 周报日期计算

### 本周周报 (周一到周日)

**macOS**:
```bash
# 获取今天是星期几（1-7，1是周一，7是周日）
weekday=$(date +%u)

# 计算本周一的日期
monday=$(date -v-$((weekday-1))d +%Y-%m-%d)

# 计算本周日的日期
sunday=$(date -v+$((7-weekday))d +%Y-%m-%d)
```

**Linux**:
```bash
weekday=$(date +%u)
monday=$(date -d "$((weekday-1)) days ago" +%Y-%m-%d)
sunday=$(date -d "$((7-weekday)) days" +%Y-%m-%d)
```

### 上周周报

**macOS**:
```bash
weekday=$(date +%u)

# 上周一 = 今天 - (weekday + 6) 天
last_monday=$(date -v-$((weekday+6))d +%Y-%m-%d)

# 上周日 = 今天 - weekday 天
last_sunday=$(date -v-${weekday}d +%Y-%m-%d)
```

**Linux**:
```bash
weekday=$(date +%u)
last_monday=$(date -d "$((weekday+6)) days ago" +%Y-%m-%d)
last_sunday=$(date -d "${weekday} days ago" +%Y-%m-%d)
```

### 日期计算验证示例

| 今天 | 星期几 | 上周一 | 上周日 | 本周一 | 本周日 |
|------|--------|--------|--------|--------|--------|
| 11-03 | 周一(1) | 10-27 | 11-02 | 11-03 | 11-09 |
| 11-04 | 周二(2) | 10-28 | 11-03 | 11-03 | 11-09 |
| 11-07 | 周五(5) | 10-28 | 11-03 | 11-03 | 11-09 |
| 11-09 | 周日(7) | 10-28 | 11-03 | 11-03 | 11-09 |

---

## 月报日期计算

### 本月月报

**macOS**:
```bash
# 本月第一天
first_day=$(date -v1d +%Y-%m-%d)

# 本月最后一天
last_day=$(date -v1d -v+1m -v-1d +%Y-%m-%d)
```

**Linux**:
```bash
first_day=$(date -d "$(date +%Y-%m-01)" +%Y-%m-%d)
last_day=$(date -d "$(date +%Y-%m-01) +1 month -1 day" +%Y-%m-%d)
```

### 上月月报

**macOS**:
```bash
# 上月第一天
last_month_first=$(date -v1d -v-1m +%Y-%m-%d)

# 上月最后一天
last_month_last=$(date -v1d -v-1d +%Y-%m-%d)
```

**Linux**:
```bash
last_month_first=$(date -d "$(date +%Y-%m-01) -1 month" +%Y-%m-%d)
last_month_last=$(date -d "$(date +%Y-%m-01) -1 day" +%Y-%m-%d)
```

### 月报日期计算示例

| 今天 | 本月范围 | 上月范围 | 文件名 |
|------|----------|----------|--------|
| 11-03 | 11-01 到 11-30 | 10-01 到 10-31 | 2025年10月工作月报 |
| 11-15 | 11-01 到 11-30 | 10-01 到 10-31 | 2025年10月工作月报 |
| 12-05 | 12-01 到 12-31 | 11-01 到 11-30 | 2025年11月工作月报 |

---

## 文件名格式

### 日报
```
日报_YYYY-MM-DD.md
示例: 日报_2025-11-06.md
```

### 周报
```
周报_YYYY年MM月DD日-MM月DD日.md
示例: 周报_2025年10月27日-11月02日.md
```

### 月报
```
YYYY年MM月工作月报.md
示例: 2025年10月工作月报.md
```

---

## 文件识别逻辑

### 周报文件识别
```bash
# 文件名格式: 周报_2025年10月21日-10月27日.md
# 提取周报起始日期（第一个日期），判断是否在范围内
```

### 日报文件识别
```bash
# 文件名格式: 日报_2025-10-27.md
# 提取日期，判断是否在范围内
```

---

## 重要提醒

1. **必须先确认日期范围**: 在查找文件前，先向用户确认计算出的日期范围
2. **使用 Glob 查找文件**: 使用 `日报_*.md` 或 `周报_*.md` 模式查找
3. **按日期筛选**: 根据文件名中的日期判断是否在目标范围内
4. **验证是否遗漏**: 检查是否有某天/某周的报告缺失
