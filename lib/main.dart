import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

void main() {
  /// ProviderScope 是 Riverpod 的根容器
  /// 对应 Kotlin Hilt: @HiltAndroidApp class App : Application()
  runApp(
    const ProviderScope(
      child: StormSentinelApp(),
    ),
  );
}

/// App 根 Widget
/// 对应 Kotlin:
/// ```kotlin
/// @AndroidEntryPoint
/// class MainActivity : ComponentActivity() {
///   override fun onCreate(...) {
///     setContent { AppTheme { AppNavHost() } }
///   }
/// }
/// ```
///
/// 此 main.dart 是 UI-agnostic 骨架。
/// spike 分支合并时会替换 MaterialApp 为 themed 版本。
class StormSentinelApp extends StatelessWidget {
  const StormSentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter();

    return MaterialApp.router(
      title: 'Storm Sentinel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
