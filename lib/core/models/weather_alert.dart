import 'alert_severity.dart';
import 'location_info.dart';

class WeatherAlert {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final LocationInfo location;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final String source;
  final WeatherAlertType type;
  final bool isActive;

  const WeatherAlert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.location,
    required this.issuedAt,
    this.expiresAt,
    required this.source,
    required this.type,
    this.isActive = true,
  });

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  Duration? get remainingTime =>
      expiresAt != null ? expiresAt!.difference(DateTime.now()) : null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is WeatherAlert && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum WeatherAlertType {
  thunderstorm,
  tornado,
  hurricane,
  flood,
  blizzard,
  heatWave,
  coldWave,
  hail,
  fog,
  windStorm,
  other;

  String get label => switch (this) {
        thunderstorm => '雷暴',
        tornado => '龙卷风',
        hurricane => '飓风',
        flood => '洪水',
        blizzard => '暴风雪',
        heatWave => '热浪',
        coldWave => '寒潮',
        hail => '冰雹',
        fog => '大雾',
        windStorm => '大风',
        other => '其他',
      };

  String get icon => switch (this) {
        thunderstorm => '⛈️',
        tornado => '🌪️',
        hurricane => '🌀',
        flood => '🌊',
        blizzard => '❄️',
        heatWave => '🔥',
        coldWave => '🥶',
        hail => '🧊',
        fog => '🌫️',
        windStorm => '💨',
        other => '⚠️',
      };
}
