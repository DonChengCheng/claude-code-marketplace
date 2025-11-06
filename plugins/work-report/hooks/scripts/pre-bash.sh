#!/bin/bash

# Bash PreToolUse Hook: 检查并阻止改变工作目录的命令
# 符合 Claude Code 官方 Hooks 规范
#
# 输入：从 stdin 接收 JSON 格式的 hook 数据
# 输出：退出码 0（允许）或 2（阻止并显示 stderr 给 Claude）

# 从 stdin 读取 JSON 输入
input=$(cat)

# 提取 Bash 命令
# 使用 Python 解析 JSON（更可靠，macOS 自带 Python）
command=$(echo "$input" | python3 -c "
import sys
import json
try:
    data = json.load(sys.stdin)
    tool_input = data.get('tool_input', {})
    print(tool_input.get('command', ''))
except:
    print('')
")

# 如果无法提取命令，允许执行（降级处理）
if [ -z "$command" ]; then
    exit 0
fi

# 检查命令中是否包含 cd（排除合法场景）
if echo "$command" | grep -E '(^|;|&&|\|\|)\s*cd\s+' > /dev/null; then
    # 排除特殊情况1：子shell 中的 cd（用括号包裹）
    if echo "$command" | grep -E '^\s*\(' > /dev/null; then
        exit 0  # 允许子shell中的cd
    fi

    # 排除特殊情况2：git -C 命令（这是正确的用法）
    # 这个检查是多余的，因为 git -C 不包含 cd，但保留以示明确

    # 阻止命令执行并给出友好提示
    cat >&2 <<'EOF'
❌ 错误：检测到可能改变工作目录的 'cd' 命令！

💡 建议使用以下替代方案：
  • git 命令：使用 'git -C <path>' 替代 'cd <path> && git'
  • 其他命令：使用绝对路径参数
  • 如需临时切换：使用子shell '(cd <path> && command)'

EOF
    echo "📝 原命令：$command" >&2
    echo "" >&2

    # 返回退出码 2 阻止执行
    # 根据官方文档，PreToolUse 中退出码 2 会阻止工具调用
    exit 2
fi

# 允许执行
exit 0
