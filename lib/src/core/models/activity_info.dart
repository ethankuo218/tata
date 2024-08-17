class ActivityInfo {
  final String name;
  final String description;
  final String timeDescription;
  final Duration duration;
  final String startTime;
  final bool active;

  ActivityInfo({
    required this.name,
    required this.description,
    required this.timeDescription,
    required this.duration,
    required this.startTime,
    required this.active,
  });

  factory ActivityInfo.fromJson(Map<String, dynamic> map) {
    return ActivityInfo(
      name: map['name'],
      description: map['description'],
      timeDescription: map['time_description'],
      duration: Duration(seconds: map['duration']),
      startTime: map['start_time'],
      active: map['active'],
    );
  }
}
