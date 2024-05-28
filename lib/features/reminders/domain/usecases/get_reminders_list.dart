import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';

import '../../../../core/types/types.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/reminder.dart';

class GetRemindersList extends UseCaseWithoutParams<List<Reminder>> {
  GetRemindersList(this._repository);
  final RemindersRepository _repository;

  @override
  ResultFuture<List<Reminder>> call() async => _repository.getRemindersList();
}
