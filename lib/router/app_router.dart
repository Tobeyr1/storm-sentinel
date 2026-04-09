import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 路由路径常量
/// 对应 Kotlin Navigation Compose 的 sealed class Screen
abstract final class AppRoutes {
  static const alertList = '/';
  static const alertDetail = '/alert/:id';
  static const map = '/map';
  static const settings = '/settings';

  static String alertDetailPath(String id) => '/alert/$id';
}

/// 全局路由配置
/// 对应 Kotlin:
/// ```kotlin
/// @Composable
/// fun AppNavHost(navController: NavHostController) {
///   NavHost(navController, startDestination = Screen.AlertList.route) {
///     composable(Screen.AlertList.route) { AlertListScreen() }
///     composable(Screen.AlertDetail.route) { AlertDetailScreen(alertId) }
///   }
/// }
/// ```
///
/// 注意: 此路由配置是 UI-agnostic 的骨架。
/// 各 spike 分支会在 page builder 中填入实际的页面 Widget。
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.alertList,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) => _AppShellPlaceholder(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.alertList,
            name: 'alertList',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _RoutePlaceholder(name: '预警列表'),
            ),
          ),
          GoRoute(
            path: AppRoutes.map,
            name: 'map',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _RoutePlaceholder(name: '地图'),
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: 'settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: _RoutePlaceholder(name: '设置'),
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.alertDetail,
        name: 'alertDetail',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return _RoutePlaceholder(name: '预警详情: $id');
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('页面未找到: ${state.uri}'),
      ),
    ),
  );
}

/// 占位 Shell — spike 分支会替换为带底部导航的 Scaffold
class _AppShellPlaceholder extends StatelessWidget {
  final Widget child;
  const _AppShellPlaceholder({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storm Sentinel — framework')),
      body: child,
    );
  }
}

/// 占位页面
class _RoutePlaceholder extends StatelessWidget {
  final String name;
  const _RoutePlaceholder({required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.construction, size: 48),
          const SizedBox(height: 16),
          Text(name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('框架层已就绪，等待 UI spike 分支集成'),
        ],
      ),
    );
  }
}
