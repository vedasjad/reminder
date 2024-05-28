import 'package:reminder/core/types/types.dart';

import '../entities/reminder.dart';

abstract class RemindersRepository {
  const RemindersRepository();

  ResultVoid addReminder({
    required Reminder reminder,
  });

  ResultVoid updateReminder({
    required Reminder reminder,
  });

  ResultVoid deleteReminder({
    required Reminder reminder,
  });

  ResultVoid deleteRemindersList({
    required List<Reminder> remindersList,
  });

  ResultFuture<List<Reminder>> getRemindersList();
}
