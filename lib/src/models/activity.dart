class Activity {
  final String name;
  final String description;
  final String timeDescription;
  final Duration duration;
  final String startTime;
  final bool active;

  Activity({
    required this.name,
    required this.description,
    required this.timeDescription,
    required this.duration,
    required this.startTime,
    required this.active,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      name: map['name'],
      description: map['description'],
      timeDescription: map['time_description'],
      duration: Duration(seconds: map['duration']),
      startTime: map['start_time'],
      active: map['active'],
    );
  }
}
