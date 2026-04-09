import '../models/weather_alert.dart';
import '../models/alert_severity.dart';

class AnomalyDetectionResult {
  final bool isAnomaly;
  final double confidenceScore;
  final String reason;

  const AnomalyDetectionResult({
    required this.isAnomaly,
    required this.confidenceScore,
    required this.reason,
  });
}

class AnomalyDetectionService {
  static const _rapidEscalationThresholdMinutes = 30;
  static const _clusterThresholdKm = 100;
  static const _clusterMinAlerts = 3;

  AnomalyDetectionResult analyzeRapidEscalation(
    List<WeatherAlert> recentAlerts,
  ) {
    if (recentAlerts.length < 2) {
      return const AnomalyDetectionResult(
        isAnomaly: false,
        confidenceScore: 0,
        reason: '数据不足',
      );
    }

    final sorted = [...recentAlerts]
      ..sort((a, b) => a.issuedAt.compareTo(b.issuedAt));

    for (int i = 1; i < sorted.length; i++) {
      final prev = sorted[i - 1];
      final curr = sorted[i];
      final timeDiff = curr.issuedAt.difference(prev.issuedAt).inMinutes;
      final severityJump = curr.severity.priority - prev.severity.priority;

      if (timeDiff <= _rapidEscalationThresholdMinutes && severityJump >= 2) {
        return AnomalyDetectionResult(
          isAnomaly: true,
          confidenceScore: 0.85 + (severityJump * 0.05),
          reason: '在${timeDiff}分钟内严重等级跳升了$severityJump级',
        );
      }
    }

    return const AnomalyDetectionResult(
      isAnomaly: false,
      confidenceScore: 0.1,
      reason: '未检测到快速升级模式',
    );
  }

  AnomalyDetectionResult analyzeGeographicCluster(
    List<WeatherAlert> alerts,
  ) {
    if (alerts.length < _clusterMinAlerts) {
      return const AnomalyDetectionResult(
        isAnomaly: false,
        confidenceScore: 0,
        reason: '数据不足以判断地理聚集',
      );
    }

    final highSeverity = alerts
        .where((a) => a.severity.priority >= AlertSeverity.warning.priority)
        .toList();

    if (highSeverity.length >= _clusterMinAlerts) {
      final avgLat = highSeverity.fold<double>(
              0, (sum, a) => sum + a.location.latitude) /
          highSeverity.length;
      final avgLon = highSeverity.fold<double>(
              0, (sum, a) => sum + a.location.longitude) /
          highSeverity.length;

      final allWithinRadius = highSeverity.every((a) {
        final dist = _estimateDistanceKm(
          avgLat,
          avgLon,
          a.location.latitude,
          a.location.longitude,
        );
        return dist <= _clusterThresholdKm;
      });

      if (allWithinRadius) {
        return AnomalyDetectionResult(
          isAnomaly: true,
          confidenceScore: 0.75 + (highSeverity.length * 0.05),
          reason: '${highSeverity.length}个高级别预警在${_clusterThresholdKm}km范围内聚集',
        );
      }
    }

    return const AnomalyDetectionResult(
      isAnomaly: false,
      confidenceScore: 0.2,
      reason: '未检测到地理聚集模式',
    );
  }

  double _estimateDistanceKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const kmPerDegree = 111.0;
    final dLat = (lat2 - lat1) * kmPerDegree;
    final dLon = (lon2 - lon1) * kmPerDegree * 0.85;
    return (dLat * dLat + dLon * dLon).abs();
  }
}
