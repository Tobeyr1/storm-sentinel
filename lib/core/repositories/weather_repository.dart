import '../models/weather_alert.dart';
import '../models/alert_severity.dart';

abstract class WeatherRepository {
  Future<List<WeatherAlert>> getActiveAlerts();

  Future<List<WeatherAlert>> getAlertsByLocation(
    double latitude,
    double longitude, {
    double radiusKm = 50,
  });

  Future<WeatherAlert?> getAlertById(String id);

  Future<List<WeatherAlert>> getAlertsBySeverity(AlertSeverity minSeverity);

  Stream<List<WeatherAlert>> watchActiveAlerts();
}
