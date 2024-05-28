import 'package:hive/hive.dart';
import 'package:reminder/features/reminders/domain/entities/reminder.dart';

import '../../../../core/enums/reminder_priority.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final DateTime dateTime;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final ReminderPriority priority;

  ReminderModel({
    required this.id,
    required this.dateTime,
    required this.priority,
    this.title,
    this.description,
  });

  factory ReminderModel.fromReminder(Reminder reminder) => ReminderModel(
        id: reminder.id,
        dateTime: reminder.dateTime,
        priority: reminder.priority,
        title: reminder.title,
        description: reminder.description,
      );

  Reminder toReminder() => Reminder(
        id: id,
        dateTime: dateTime,
        priority: priority,
        title: title,
        description: description,
      );
}
