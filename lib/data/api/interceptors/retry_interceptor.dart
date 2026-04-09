import 'dart:io';

import 'package:dio/dio.dart';

/// 自动重试拦截器
/// 对应 Kotlin: OkHttp RetryInterceptor / Retrofit retry adapter
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      if (retryCount < maxRetries) {
        await Future.delayed(retryDelay * (retryCount + 1));
        err.requestOptions.extra['retryCount'] = retryCount + 1;
        try {
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } on DioException catch (e) {
          handler.next(e);
          return;
        }
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.error is SocketException);
  }
}
