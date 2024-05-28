import 'package:hive/hive.dart';

part 'reminder_priority.g.dart';

@HiveType(typeId: 1)
enum ReminderPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}
