import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/weather_alert.dart';
import '../../providers/repository_providers.dart';

/// 预警列表 ViewModel
/// 对应 Kotlin:
/// ```kotlin
/// @HiltViewModel
/// class AlertListViewModel @Inject constructor(
///   private val repository: WeatherRepository
/// ) : ViewModel() {
///   private val _uiState = MutableStateFlow<AlertListUiState>(Loading)
///   val uiState: StateFlow<AlertListUiState> = _uiState.asStateFlow()
/// }
/// ```
///
/// Flutter 中 AsyncNotifier 的 state 类型是 AsyncValue<T>，自动包含:
///   - AsyncLoading  → 对应 Kotlin UiState.Loading
///   - AsyncData     → 对应 Kotlin UiState.Success
///   - AsyncError    → 对应 Kotlin UiState.Error
class AlertListViewModel extends AsyncNotifier<List<WeatherAlert>> {
  @override
  Future<List<WeatherAlert>> build() {
    return ref.read(weatherRepositoryProvider).getActiveAlerts();
  }

  /// 刷新数据 — 对应 Kotlin: viewModel.refresh()
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(weatherRepositoryProvider).getActiveAlerts(),
    );
  }

  /// 按严重等级过滤
  List<WeatherAlert> filterBySeverityPriority(int minPriority) {
    return state.valueOrNull
            ?.where((a) => a.severity.priority >= minPriority)
            .toList() ??
        [];
  }
}

/// Provider 声明
/// 对应 Kotlin Hilt 的自动注入:
/// ```kotlin
/// val viewModel: AlertListViewModel = hiltViewModel()
/// ```
///
/// Flutter 用法:
/// ```dart
/// // 在 ConsumerWidget 中:
/// final alertsAsync = ref.watch(alertListViewModelProvider);
/// // 调用方法:
/// ref.read(alertListViewModelProvider.notifier).refresh();
/// ```
final alertListViewModelProvider =
    AsyncNotifierProvider<AlertListViewModel, List<WeatherAlert>>(
  AlertListViewModel.new,
);
