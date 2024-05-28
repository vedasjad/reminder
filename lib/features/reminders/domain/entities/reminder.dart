import 'package:equatable/equatable.dart';

import '../../../../core/enums/reminder_priority.dart';

class Reminder extends Equatable {
  final String id;

  final DateTime dateTime;

  final String? title;

  final String? description;

  final ReminderPriority priority;

  const Reminder({
    required this.id,
    required this.dateTime,
    required this.priority,
    this.title,
    this.description,
  });

  Reminder copyWith({
    DateTime? dateTime,
    String? title,
    String? description,
    ReminderPriority? priority,
  }) {
    return Reminder(
      id: id,
      dateTime: dateTime ?? this.dateTime,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        dateTime,
        title,
        description,
        priority,
      ];
}
