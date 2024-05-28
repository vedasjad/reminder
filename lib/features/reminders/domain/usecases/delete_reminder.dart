import 'package:equatable/equatable.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../../../core/types/types.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/reminder.dart';

class DeleteReminder extends UseCaseWithParams<void, DeleteReminderParams> {
  DeleteReminder(this._repository);
  final RemindersRepository _repository;

  @override
  ResultVoid call(DeleteReminderParams params) async =>
      _repository.deleteReminder(reminder: params.reminder);
}

class DeleteReminderParams extends Equatable {
  const DeleteReminderParams({
    required this.reminder,
  });

  final Reminder reminder;

  @override
  List<Object?> get props => [reminder];
}
