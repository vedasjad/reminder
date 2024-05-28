import 'package:equatable/equatable.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../../../core/types/types.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/reminder.dart';

class AddReminder extends UseCaseWithParams<void, AddReminderParams> {
  AddReminder(this._repository);
  final RemindersRepository _repository;

  @override
  ResultVoid call(AddReminderParams params) async =>
      _repository.addReminder(reminder: params.reminder);
}

class AddReminderParams extends Equatable {
  const AddReminderParams({
    required this.reminder,
  });

  final Reminder reminder;

  @override
  List<Object?> get props => [reminder];
}
