import '../../core/models/alert_severity.dart';
import '../../core/models/location_info.dart';
import '../../core/models/weather_alert.dart';

class MockWeatherData {
  static final now = DateTime.now();

  static List<WeatherAlert> get alerts => [
        WeatherAlert(
          id: 'alert-001',
          title: '强雷暴预警',
          description: '预计未来2小时内将出现强雷暴天气，伴有短时强降水、雷电和7-9级大风。请注意防范。',
          severity: AlertSeverity.warning,
          location: const LocationInfo(
            name: '北京市朝阳区',
            latitude: 39.9042,
            longitude: 116.4074,
          ),
          issuedAt: now.subtract(const Duration(minutes: 30)),
          expiresAt: now.add(const Duration(hours: 2)),
          source: '中国气象局',
          type: WeatherAlertType.thunderstorm,
        ),
        WeatherAlert(
          id: 'alert-002',
          title: '龙卷风紧急预警',
          description: '雷达监测到旋转性强回波，龙卷风可能在30分钟内影响该区域。立即寻找坚固建筑避险！',
          severity: AlertSeverity.emergency,
          location: const LocationInfo(
            name: '天津市武清区',
            latitude: 39.3842,
            longitude: 117.0444,
          ),
          issuedAt: now.subtract(const Duration(minutes: 10)),
          expiresAt: now.add(const Duration(hours: 1)),
          source: '国家气象中心',
          type: WeatherAlertType.tornado,
        ),
        WeatherAlert(
          id: 'alert-003',
          title: '暴雨蓝色预警',
          description: '预计未来24小时内将出现大到暴雨，部分地区可能出现积水。请合理安排出行。',
          severity: AlertSeverity.advisory,
          location: const LocationInfo(
            name: '上海市浦东新区',
            latitude: 31.2304,
            longitude: 121.4737,
          ),
          issuedAt: now.subtract(const Duration(hours: 2)),
          expiresAt: now.add(const Duration(hours: 12)),
          source: '上海市气象局',
          type: WeatherAlertType.flood,
        ),
        WeatherAlert(
          id: 'alert-004',
          title: '大雾黄色预警',
          description: '预计今晨至上午将出现能见度不足500米的浓雾，局地不足200米。注意交通安全。',
          severity: AlertSeverity.watch,
          location: const LocationInfo(
            name: '南京市江宁区',
            latitude: 31.9535,
            longitude: 118.8370,
          ),
          issuedAt: now.subtract(const Duration(hours: 5)),
          expiresAt: now.add(const Duration(hours: 3)),
          source: '江苏省气象局',
          type: WeatherAlertType.fog,
        ),
        WeatherAlert(
          id: 'alert-005',
          title: '寒潮橙色预警',
          description: '受强冷空气影响，未来48小时内最低气温将下降12-14℃。请做好防寒保暖措施。',
          severity: AlertSeverity.warning,
          location: const LocationInfo(
            name: '哈尔滨市道里区',
            latitude: 45.7500,
            longitude: 126.6500,
          ),
          issuedAt: now.subtract(const Duration(hours: 1)),
          expiresAt: now.add(const Duration(days: 2)),
          source: '黑龙江省气象局',
          type: WeatherAlertType.coldWave,
        ),
        WeatherAlert(
          id: 'alert-006',
          title: '高温红色预警',
          description: '预计未来3天最高气温将达42℃以上，请避免午后高温时段户外活动。',
          severity: AlertSeverity.emergency,
          location: const LocationInfo(
            name: '武汉市武昌区',
            latitude: 30.5728,
            longitude: 114.3055,
          ),
          issuedAt: now.subtract(const Duration(minutes: 45)),
          expiresAt: now.add(const Duration(days: 3)),
          source: '湖北省气象局',
          type: WeatherAlertType.heatWave,
        ),
      ];
}
