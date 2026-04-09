import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// HTTP 请求日志拦截器
/// 对应 Kotlin: OkHttp HttpLoggingInterceptor
class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor({Logger? logger})
      : _logger = logger ?? Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('→ ${options.method} ${options.uri}');
    if (options.data != null) {
      _logger.d('   Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '← ${response.statusCode} ${response.requestOptions.uri} '
      '(${response.data.toString().length} bytes)',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '✕ ${err.requestOptions.method} ${err.requestOptions.uri}',
      error: err.message,
    );
    handler.next(err);
  }
}
