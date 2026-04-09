import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/weather_alert.dart';
import '../../providers/repository_providers.dart';
import '../../providers/service_providers.dart';

/// 预警详情 ViewModel
/// 对应 Kotlin:
/// ```kotlin
/// @HiltViewModel
/// class AlertDetailViewModel @Inject constructor(
///   savedStateHandle: SavedStateHandle,
///   private val repository: WeatherRepository,
///   private val anomalyService: AnomalyDetectionService
/// ) : ViewModel()
/// ```
class AlertDetailViewModel
    extends AutoDisposeFamilyAsyncNotifier<AlertDetailState, String> {
  @override
  Future<AlertDetailState> build(String arg) async {
    final alertId = arg;
    final alert =
        await ref.read(weatherRepositoryProvider).getAlertById(alertId);

    if (alert == null) {
      throw Exception('预警 $alertId 不存在');
    }

    final anomalyService = ref.read(anomalyDetectionServiceProvider);
    final relatedAlerts =
        await ref.read(weatherRepositoryProvider).getAlertsByLocation(
              alert.location.latitude,
              alert.location.longitude,
              radiusKm: 100,
            );

    final anomalyResult =
        anomalyService.analyzeGeographicCluster(relatedAlerts);

    return AlertDetailState(
      alert: alert,
      relatedAlerts:
          relatedAlerts.where((a) => a.id != alertId).toList(),
      isAnomalyDetected: anomalyResult.isAnomaly,
      anomalyConfidence: anomalyResult.confidenceScore,
    );
  }
}

class AlertDetailState {
  final WeatherAlert alert;
  final List<WeatherAlert> relatedAlerts;
  final bool isAnomalyDetected;
  final double anomalyConfidence;

  const AlertDetailState({
    required this.alert,
    required this.relatedAlerts,
    required this.isAnomalyDetected,
    required this.anomalyConfidence,
  });
}

/// Provider 声明 — family 参数是 alertId (String)
/// 对应 Kotlin: hiltViewModel() + SavedStateHandle 获取 alertId
///
/// 用法:
/// ```dart
/// final detailAsync = ref.watch(alertDetailViewModelProvider('alert-001'));
/// ```
final alertDetailViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<AlertDetailViewModel, AlertDetailState, String>(
  AlertDetailViewModel.new,
);
