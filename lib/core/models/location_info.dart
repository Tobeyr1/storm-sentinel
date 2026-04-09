class LocationInfo {
  final String name;
  final double latitude;
  final double longitude;

  const LocationInfo({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationInfo &&
          name == other.name &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => Object.hash(name, latitude, longitude);

  @override
  String toString() => 'LocationInfo($name, $latitude, $longitude)';
}
