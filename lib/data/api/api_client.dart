import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// 统一 HTTP 客户端
/// 对应 Kotlin: Retrofit 实例 + OkHttpClient.Builder
///
/// 用法:
/// ```dart
/// final client = ApiClient();
/// final response = await client.get('/alerts');
/// ```
class ApiClient {
  late final Dio _dio;

  Dio get dio => _dio;

  ApiClient({String? baseUrl, List<Interceptor>? extraInterceptors}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryInterceptor(dio: _dio),
      ...?extraInterceptors,
    ]);
  }

  /// 添加 Auth Token（登录后调用）
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) =>
      _dio.get<T>(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    CancelToken? cancelToken,
  }) =>
      _dio.post<T>(path, data: data, cancelToken: cancelToken);

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    CancelToken? cancelToken,
  }) =>
      _dio.put<T>(path, data: data, cancelToken: cancelToken);

  Future<Response<T>> delete<T>(
    String path, {
    CancelToken? cancelToken,
  }) =>
      _dio.delete<T>(path, cancelToken: cancelToken);
}
