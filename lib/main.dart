import 'package:flutter/material.dart';
import 'data/repositories/weather_repository_impl.dart';

final weatherRepository = WeatherRepositoryImpl();

void main() {
  runApp(const StormSentinelApp());
}

/// develop 分支占位 App —— 各 spike 分支会替换此文件
class StormSentinelApp extends StatelessWidget {
  const StormSentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storm Sentinel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const _PlaceholderHome(),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storm Sentinel — develop')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64),
            SizedBox(height: 16),
            Text(
              '共享架构层已就绪',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('请切换到 spike/* 分支查看 UI 原型'),
          ],
        ),
      ),
    );
  }
}
