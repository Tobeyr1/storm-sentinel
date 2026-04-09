import 'package:dio/dio.dart';

/// 统一 API 异常
/// 对应 Kotlin: sealed class ApiResult / NetworkException
sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  factory ApiException.fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        TimeoutException(e.message ?? '请求超时'),
      DioExceptionType.connectionError =>
        NetworkException(e.message ?? '网络连接失败，请检查网络'),
      DioExceptionType.badResponse => _fromStatusCode(
          e.response?.statusCode,
          e.response?.data?.toString(),
        ),
      DioExceptionType.cancel => RequestCancelledException(),
      _ => UnknownApiException(e.message ?? '未知错误'),
    };
  }

  static ApiException _fromStatusCode(int? code, String? body) {
    if (code == null) {
      return UnknownApiException(body ?? '请求失败（未知状态码）');
    }
    return switch (code) {
      401 => const UnauthorizedException('认证失败，请重新登录'),
      403 => const ForbiddenException('无权限访问'),
      404 => const NotFoundException('请求的资源不存在'),
      429 => const RateLimitException('请求过于频繁，请稍后再试'),
      >= 500 => ServerException('服务器错误 ($code)', statusCode: code),
      _ => UnknownApiException(body ?? '请求失败 ($code)', statusCode: code),
    };
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class NetworkException extends ApiException {
  const NetworkException(super.message);
}

class TimeoutException extends ApiException {
  const TimeoutException(super.message);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message, {super.statusCode = 401});
}

class ForbiddenException extends ApiException {
  const ForbiddenException(super.message, {super.statusCode = 403});
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message, {super.statusCode = 404});
}

class RateLimitException extends ApiException {
  const RateLimitException(super.message, {super.statusCode = 429});
}

class ServerException extends ApiException {
  const ServerException(super.message, {super.statusCode});
}

class RequestCancelledException extends ApiException {
  RequestCancelledException() : super('请求已取消');
}

class UnknownApiException extends ApiException {
  const UnknownApiException(super.message, {super.statusCode});
}
