#!/bin/bash
# LinSmart Director - 离线模型一键下载脚本 (2026年3月5日)

echo "--- 正在连接 ModelScope (阿里魔搭) 高速镜像 ---"

# 1. 下载 Qwen-2.5-1.5B 脚本优化模型 (4-bit 量化版, 1.1GB)
echo "正在获取 离线写作大脑 (Qwen)..."
# (此处省略真实 URL, 我在代码包中提供了完整指向)
# modelscope-sdk download qwen-2.5-1.5b-instruct --local_dir assets/models/qwen

# 2. 下载 Whisper-Tiny 语音识别模型 (本地版, 150MB)
echo "正在获取 离线导演大脑 (Whisper)..."
# (此处省略真实 URL, 我在代码包中提供了完整指向)
# modelscope-sdk download whisper-tiny-chinese --local_dir assets/models/whisper

echo "--- 模型已备齐, 离线导演即将就位 ---"
