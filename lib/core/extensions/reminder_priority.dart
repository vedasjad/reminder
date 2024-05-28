import '../enums/reminder_priority.dart';

extension ReminderPriorityExtension on ReminderPriority {
  String get toShortString {
    switch (this) {
      case ReminderPriority.low:
        return 'Low';
      case ReminderPriority.medium:
        return 'Medium';
      case ReminderPriority.high:
        return 'High';
      default:
        return '';
    }
  }
}
