part of 'reminders_bloc.dart';

sealed class RemindersEvent extends Equatable {
  const RemindersEvent();
}

final class AddReminderEvent extends RemindersEvent {
  const AddReminderEvent({
    required this.reminder,
  });
  final Reminder reminder;
  @override
  List<Object?> get props => [
        reminder,
      ];
}

final class UpdateReminderEvent extends RemindersEvent {
  const UpdateReminderEvent({
    required this.reminder,
  });
  final Reminder reminder;
  @override
  List<Object?> get props => [
        reminder,
      ];
}

final class DeleteReminderEvent extends RemindersEvent {
  const DeleteReminderEvent({
    required this.reminder,
  });
  final Reminder reminder;
  @override
  List<Object?> get props => [
        reminder,
      ];
}

final class DeleteRemindersListEvent extends RemindersEvent {
  const DeleteRemindersListEvent({
    required this.remindersList,
  });
  final List<Reminder> remindersList;
  @override
  List<Object?> get props => [
        remindersList,
      ];
}

final class GetRemindersListEvent extends RemindersEvent {
  const GetRemindersListEvent();
  @override
  List<Object?> get props => [];
}
