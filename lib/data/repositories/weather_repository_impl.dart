import 'dart:async';

import '../../core/models/alert_severity.dart';
import '../../core/models/weather_alert.dart';
import '../../core/repositories/weather_repository.dart';
import '../mock/mock_weather_data.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  List<WeatherAlert>? _cachedAlerts;
  final _alertsController = StreamController<List<WeatherAlert>>.broadcast();

  @override
  Future<List<WeatherAlert>> getActiveAlerts() async {
    await _simulateNetworkDelay();
    _cachedAlerts = MockWeatherData.alerts.where((a) => a.isActive).toList()
      ..sort((a, b) => b.severity.priority.compareTo(a.severity.priority));
    return _cachedAlerts!;
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

  Future<void> _simulateNetworkDelay() =>
      Future.delayed(const Duration(milliseconds: 300));
}
