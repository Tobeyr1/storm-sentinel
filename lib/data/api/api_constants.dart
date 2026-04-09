/// API 配置常量
/// 对应 Kotlin 项目中的 BuildConfig / NetworkModule 的 BASE_URL
abstract final class ApiConstants {
  static const baseUrl = 'https://api.example.com/v1';

  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);

  // 天气预警相关端点
  static const alertsEndpoint = '/alerts';
  static const alertDetailEndpoint = '/alerts/{id}';
  static const locationsEndpoint = '/locations';
}
