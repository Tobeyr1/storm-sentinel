import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/repositories/weather_repository.dart';
import '../data/repositories/weather_repository_impl.dart';
import 'dio_provider.dart';

/// Repository 依赖注入
/// 对应 Kotlin Hilt:
/// ```kotlin
/// @Module @InstallIn(SingletonComponent::class)
/// abstract class RepositoryModule {
///   @Binds @Singleton
///   abstract fun bindWeatherRepo(impl: WeatherRepositoryImpl): WeatherRepository
/// }
/// ```
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return WeatherRepositoryImpl(apiClient: apiClient);
});
