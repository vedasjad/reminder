import 'package:equatable/equatable.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../../../core/types/types.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/reminder.dart';

class UpdateReminder extends UseCaseWithParams<void, UpdateReminderParams> {
  UpdateReminder(this._repository);
  final RemindersRepository _repository;

  @override
  ResultVoid call(UpdateReminderParams params) async =>
      _repository.addReminder(reminder: params.reminder);
}

class UpdateReminderParams extends Equatable {
  const UpdateReminderParams({
    required this.reminder,
  });

  final Reminder reminder;

  @override
  List<Object?> get props => [reminder];
}
