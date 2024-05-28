import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/features/reminders/data/models/reminder_model.dart';

abstract class RemindersLocalDataSource {
  Box<ReminderModel> openDB();
  Future<void> deleteReminder({required ReminderModel reminder});
  Future<void> deleteRemindersList(
      {required List<ReminderModel> remindersList});
  Future<void> addReminder({required ReminderModel reminder});
  Future<void> updateReminder({required ReminderModel reminder});
  List<ReminderModel> getRemindersList();
}

class RemindersLocalDataSourceImpl implements RemindersLocalDataSource {
  late Box<ReminderModel> remindersBox;
  RemindersLocalDataSourceImpl() {
    remindersBox = openDB();
  }

  @override
  Box<ReminderModel> openDB() {
    return Hive.box<ReminderModel>('remindersBox');
  }

  @override
  Future<void> addReminder({required ReminderModel reminder}) async {
    await remindersBox.put(reminder.id, reminder);
  }

  @override
  Future<void> deleteReminder({required ReminderModel reminder}) async {
    await remindersBox.delete(reminder.id);
  }

  @override
  Future<void> deleteRemindersList(
      {required List<ReminderModel> remindersList}) async {
    for (ReminderModel reminder in remindersList) {
      await remindersBox.delete(reminder.id);
    }
  }

  @override
  List<ReminderModel> getRemindersList() {
    return remindersBox.values.toList();
  }

  @override
  Future<void> updateReminder({required ReminderModel reminder}) async {
    await remindersBox.put(reminder.id, reminder);
  }
}
