import 'package:dartz/dartz.dart';
import 'package:reminder/core/failures/failures.dart';
import 'package:reminder/core/types/types.dart';
import 'package:reminder/features/reminders/data/datasources/reminders_local_data_source/reminders_local_data_source.dart';
import 'package:reminder/features/reminders/data/models/reminder_model.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../domain/entities/reminder.dart';

class RemindersRepositoryImpl implements RemindersRepository {
  RemindersRepositoryImpl(this._remindersLocalDataSource);
  final RemindersLocalDataSource _remindersLocalDataSource;
  @override
  ResultVoid addReminder({
    required Reminder reminder,
  }) async {
    try {
      _remindersLocalDataSource.addReminder(
        reminder: ReminderModel.fromReminder(reminder),
      );
      return const Right(null);
    } catch (e) {
      return const Left(
        HiveFailure('Failed to add reminder'),
      );
    }
  }

  @override
  ResultVoid deleteReminder({
    required Reminder reminder,
  }) async {
    try {
      _remindersLocalDataSource.deleteReminder(
          reminder: ReminderModel.fromReminder(reminder));
      return const Right(null);
    } catch (e) {
      return const Left(
        HiveFailure('Failed to delete reminder'),
      );
    }
  }

  @override
  ResultVoid deleteRemindersList({
    required List<Reminder> remindersList,
  }) async {
    try {
      _remindersLocalDataSource.deleteRemindersList(
          remindersList: remindersList
              .map(
                (reminder) => ReminderModel.fromReminder(reminder),
              )
              .toList());
      return const Right(null);
    } catch (e) {
      return const Left(
        HiveFailure('Failed to delete remindersList'),
      );
    }
  }

  @override
  ResultFuture<List<Reminder>> getRemindersList() async {
    try {
      List<Reminder> remindersList = _remindersLocalDataSource
          .getRemindersList()
          .map(
            (reminderModel) => reminderModel.toReminder(),
          )
          .toList();
      return Right(remindersList);
    } catch (e) {
      return const Left(
        HiveFailure('Failed to get reminders list'),
      );
    }
  }

  @override
  ResultVoid updateReminder({
    required Reminder reminder,
  }) async {
    try {
      _remindersLocalDataSource.updateReminder(
        reminder: ReminderModel.fromReminder(reminder),
      );
      return const Right(null);
    } catch (e) {
      return const Left(
        HiveFailure('Failed to update reminder'),
      );
    }
  }
}
