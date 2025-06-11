class Reminder {
  final String plant;
  final String remindAbout;
  final String repeat;
  final DateTime dateTime;

  Reminder({
    required this.plant,
    required this.remindAbout,
    required this.repeat,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'plant': plant,
      'task': remindAbout,
      'repeat': repeat,
      'hour': dateTime.hour,
      'minute': dateTime.minute,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      plant: map['plant'] ?? '',
      remindAbout: map['task'] ?? '',
      repeat: map['repeat'] ?? '',
      dateTime: DateTime(0, 0, 0, map['hour'] ?? 0, map['minute'] ?? 0),
    );
  }
}
