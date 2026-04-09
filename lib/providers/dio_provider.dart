import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/api/api_client.dart';

/// ApiClient 单例 Provider
/// 对应 Kotlin Hilt:
/// ```kotlin
/// @Module @InstallIn(SingletonComponent::class)
/// object NetworkModule {
///   @Provides @Singleton
///   fun provideRetrofit(): Retrofit = ...
/// }
/// ```
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
