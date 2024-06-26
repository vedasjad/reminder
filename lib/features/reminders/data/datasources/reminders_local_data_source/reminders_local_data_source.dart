import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/core/extensions/reminder_priority.dart';
import 'package:reminder/features/reminders/data/models/reminder_model.dart';
import 'package:reminder/features/reminders/data/services/notifications/notifications_service.dart';

abstract class RemindersLocalDataSource {
  Box<ReminderModel> openDB();
  Future<void> deleteReminder({required ReminderModel reminder});
  Future<void> deleteRemindersList(
      {required List<ReminderModel> remindersList});
  Future<void> addReminder({required ReminderModel reminder});
  Future<void> updateReminder({required ReminderModel reminder});
  Future<List<ReminderModel>> getRemindersList();
}

class RemindersLocalDataSourceImpl implements RemindersLocalDataSource {
  late Box<ReminderModel> remindersBox;
  late NotificationService _notificationService;
  RemindersLocalDataSourceImpl({
    required NotificationService notificationService,
  }) {
    remindersBox = openDB();
    _notificationService = notificationService;
  }

  @override
  Box<ReminderModel> openDB() {
    return Hive.box<ReminderModel>('remindersBox');
  }

  @override
  Future<void> addReminder({required ReminderModel reminder}) async {
    await remindersBox.put(reminder.id, reminder);
    await _notificationService.scheduleNotification(
      reminder.id,
      reminder.title ?? 'No Title',
      reminder.description ?? 'No Description',
      reminder.dateTime,
      reminder.priority.toShortString,
    );
    await FirebaseAnalytics.instance.logEvent(
      name: 'create_reminder',
      parameters: {
        'id': reminder.id,
        'title': reminder.title,
        'description': reminder.description,
        'date_time': reminder.dateTime.toIso8601String(),
        'priority': reminder.priority.toShortString,
      },
    );
  }

  @override
  Future<void> deleteReminder({required ReminderModel reminder}) async {
    await remindersBox.delete(reminder.id);
    await _notificationService.cancelNotification(reminder.id);
    await FirebaseAnalytics.instance.logEvent(
      name: 'delete_single_reminder',
      parameters: {
        'id': reminder.id,
      },
    );
  }

  @override
  Future<void> deleteRemindersList(
      {required List<ReminderModel> remindersList}) async {
    for (ReminderModel reminder in remindersList) {
      await remindersBox.delete(reminder.id);
      await _notificationService.cancelNotification(reminder.id);
      await FirebaseAnalytics.instance.logEvent(
        name: 'delete_reminder',
        parameters: {
          'id': reminder.id,
        },
      );
    }
  }

  @override
  Future<List<ReminderModel>> getRemindersList() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'view_reminder',
    );
    return remindersBox.values.toList();
  }

  @override
  Future<void> updateReminder({required ReminderModel reminder}) async {
    await remindersBox.put(reminder.id, reminder);
    await _notificationService.updateNotification(
      reminder.id,
      reminder.title ?? 'No Title',
      reminder.description ?? 'No Description',
      reminder.dateTime,
      reminder.priority.toShortString,
    );
    await FirebaseAnalytics.instance.logEvent(
      name: 'update_reminder',
      parameters: {
        'id': reminder.id,
        'title': reminder.title,
        'description': reminder.description,
        'date_time': reminder.dateTime.toIso8601String(),
        'priority': reminder.priority.toShortString,
      },
    );
  }
}
