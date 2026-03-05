import 'package:flutter/material.dart';
import 'package:linsmart_ai_engine/linsmart_ai_engine.dart'; // 我们自定义的离线AI引擎

class LinSmartDirectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0xFF121212), // 适合创作的深色模式
      ),
      home: DirectorMainPage(),
    );
  }
}

class DirectorMainPage extends StatefulWidget {
  @override
  _DirectorMainPageState createState() => _DirectorMainPageState();
}

enum ShootingMode { person, product }

class _DirectorMainPageState extends State<DirectorMainPage> {
  ShootingMode _currentMode = ShootingMode.person; // 默认真人模式
  String _currentScript = "欢迎来到小林智拍！请输入你的视频选题...";
  bool _isRecording = false;
  double _energyLevel = 0.8; 
  String _arGuidance = "请对准镜头";

  // 核心功能：智能场景自动识别
  void _onSceneDetected(ShootingMode mode) {
    setState(() {
      _currentMode = mode;
      _arGuidance = (mode == ShootingMode.person) ? "保持眼神看镜头" : "请将产品置于中心";
    });
  }

  // 核心功能：拍物模式下的实时口令检测
  void _onVoiceTrigger(String text) {
    if (_currentMode == ShootingMode.product && text.contains("细节")) {
      setState(() => _arGuidance = "检测到关键词：请移近摄像头展示细节！");
    }
  }

  // 核心功能：离线生成脚本
  void _generateScript(String topic) async {
    // 调用本地量化的 Qwen-2.5-1.5B 模型
    final script = await OfflineLLM.generate(
      systemPrompt: "你是一个千万粉丝博主导演...",
      userInput: "帮我写一个关于 $topic 的爆款短视频脚本",
    );
    setState(() {
      _currentScript = script;
    });
  }

  // 核心功能：智能提词器监听
  void _startSmartTeleprompter() {
    setState(() => _isRecording = true);
    // 调用本地 Whisper-Tiny 进行实时转写
    OfflineWhisper.startListening((text, speed, energy) {
      // 实时计算：如果语速过快或能量太低，UI给出视觉反馈
      setState(() {
        _energyLevel = energy; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("小林智拍 · 离线导演版")),
      body: Column(
        children: [
          // 智能提词器展示区 (具备能量反馈颜色)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              color: _energyLevel < 0.5 ? Colors.red.withOpacity(0.2) : Colors.transparent,
              child: SingleChildScrollView(
                child: Text(
                  _currentScript,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // 控制面板
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => _generateScript("2026年数码新品"), child: Text("生成脚本")),
                FloatingActionButton(
                  onPressed: _startSmartTeleprompter,
                  backgroundColor: _isRecording ? Colors.red : Colors.blue,
                  child: Icon(_isRecording ? Icons.stop : Icons.videocam),
                ),
                ElevatedButton(onPressed: () {}, child: Text("分镜引导")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
