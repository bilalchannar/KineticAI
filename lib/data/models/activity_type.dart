enum ActivityType {
  stationary,
  walking,
  running,
  hiking,
  unknown;

  String get displayName {
    return switch (this) {
      ActivityType.stationary => 'Stationary',
      ActivityType.walking => 'Walking',
      ActivityType.running => 'Running',
      ActivityType.hiking => 'Hiking',
      ActivityType.unknown => 'Unknown',
    };
  }
}
