import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/models/alert_severity.dart';
import '../../core/models/weather_alert.dart';
import '../../core/repositories/weather_repository.dart';
import '../api/api_client.dart';
import '../api/api_constants.dart';
import '../api/api_exception.dart';
import '../mock/mock_weather_data.dart';

/// WeatherRepository 实现
/// 对应 Kotlin: class WeatherRepositoryImpl @Inject constructor(
///   private val api: WeatherApi,
///   private val dao: WeatherDao
/// ) : WeatherRepository
///
/// 当前使用 Mock 数据，后续替换为真实 API 调用
class WeatherRepositoryImpl implements WeatherRepository {
  final ApiClient apiClient;
  final bool _useMock;

  List<WeatherAlert>? _cachedAlerts;
  final _alertsController = StreamController<List<WeatherAlert>>.broadcast();

  WeatherRepositoryImpl({
    required this.apiClient,
    bool useMock = true,
  }) : _useMock = useMock;

  @override
  Future<List<WeatherAlert>> getActiveAlerts() async {
    if (_useMock) return _getActiveAlertsMock();
    return _getActiveAlertsRemote();
  }

  Future<List<WeatherAlert>> _getActiveAlertsMock() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _cachedAlerts = MockWeatherData.alerts.where((a) => a.isActive).toList()
      ..sort((a, b) => b.severity.priority.compareTo(a.severity.priority));
    return _cachedAlerts!;
  }

  Future<List<WeatherAlert>> _getActiveAlertsRemote() async {
    try {
      await apiClient.get(ApiConstants.alertsEndpoint);
      // TODO: 真实 API 接入时，在此解析 response.data → List<WeatherAlert>
      throw UnimplementedError('远程 API 尚未接入');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<WeatherAlert>> getAlertsByLocation(
    double latitude,
    double longitude, {
    double radiusKm = 50,
  }) async {
    final alerts = await getActiveAlerts();
    return alerts.where((a) {
      final dLat = (a.location.latitude - latitude).abs();
      final dLon = (a.location.longitude - longitude).abs();
      final approxKm = (dLat + dLon) * 111;
      return approxKm <= radiusKm;
    }).toList();
  }

  @override
  Future<WeatherAlert?> getAlertById(String id) async {
    final alerts = _cachedAlerts ?? await getActiveAlerts();
    return alerts.where((a) => a.id == id).firstOrNull;
  }

  @override
  Future<List<WeatherAlert>> getAlertsBySeverity(
    AlertSeverity minSeverity,
  ) async {
    final alerts = await getActiveAlerts();
    return alerts
        .where((a) => a.severity.priority >= minSeverity.priority)
        .toList();
  }

  @override
  Stream<List<WeatherAlert>> watchActiveAlerts() {
    _startPeriodicRefresh();
    return _alertsController.stream;
  }

  Timer? _refreshTimer;

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final alerts = await getActiveAlerts();
      _alertsController.add(alerts);
    });
    getActiveAlerts().then(_alertsController.add);
  }

  void dispose() {
    _refreshTimer?.cancel();
    _alertsController.close();
  }
}
