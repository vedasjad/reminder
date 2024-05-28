import 'package:equatable/equatable.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../../../core/types/types.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/reminder.dart';

class DeleteRemindersList
    extends UseCaseWithParams<void, DeleteRemindersListParams> {
  DeleteRemindersList(this._repository);
  final RemindersRepository _repository;

  @override
  ResultVoid call(DeleteRemindersListParams params) async =>
      _repository.deleteRemindersList(remindersList: params.remindersList);
}

class DeleteRemindersListParams extends Equatable {
  const DeleteRemindersListParams({
    required this.remindersList,
  });

  final List<Reminder> remindersList;

  @override
  List<Object?> get props => [remindersList];
}
