import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/anomaly_detection_service.dart';

/// Service 依赖注入
/// 对应 Kotlin Hilt:
/// ```kotlin
/// @Module @InstallIn(SingletonComponent::class)
/// object ServiceModule {
///   @Provides @Singleton
///   fun provideAnomalyService(): AnomalyDetectionService = ...
/// }
/// ```
final anomalyDetectionServiceProvider =
    Provider<AnomalyDetectionService>((ref) {
  return AnomalyDetectionService();
});
