# LinSmart Director (小林智拍 · 离线导演版)

## 项目目标
针对自媒体创业者“小林”量身定制的 Android 端 AI 视频助理，通过离线 LLM 和实时语音识别，解决脚本创作难和拍摄表现力差的痛点。

## 技术规格 (2026版)
- **底层引擎**: ExecuTorch / MediaPipe LLM Inference API
- **离线模型**: Qwen-2.5-1.5B (4-bit quantization, optimized for Huawei Kirin NPU)
- **语音引擎**: Faster-Whisper-Mobile (Tiny model)
- **UI 框架**: Flutter (Cross-platform support ready)

## 核心功能清单
1. **[智能灵感库]**: 基于本地 LLM，一键生成抖音/小红书爆款脚本。
2. **[导演级提词器]**: 实时监听台词，反馈语速和情感波动，提示关键停顿。
3. **[分镜构图助手]**: 摄像头 AR 叠层，提示不同景深（远/中/近）下的最佳构图。
4. **[隐私沙盒]**: 所有脚本和音视频素材均不上传云端，完全离线运行。

## 开发计划
- [ ] 系统架构搭建
- [ ] 离线模型量化与 NPU 适配
- [ ] UI 原型设计 (Dark Mode for pro creation)
- [ ] 录音监听与台词实时对齐功能测试
