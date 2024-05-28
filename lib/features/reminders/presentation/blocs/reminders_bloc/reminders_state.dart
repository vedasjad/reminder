part of 'reminders_bloc.dart';

sealed class RemindersState extends Equatable {
  final List<Reminder> remindersList;
  const RemindersState({
    required this.remindersList,
  });

  RemindersState copyWith({
    List<Reminder>? remindersList,
  });

  @override
  List<Object?> get props => [remindersList];
}

final class RemindersInitial extends RemindersState {
  const RemindersInitial({
    super.remindersList = const [],
  });
  @override
  List<Object> get props => [super.remindersList];

  @override
  RemindersInitial copyWith({List<Reminder>? remindersList}) {
    return RemindersInitial(
      remindersList: remindersList ?? this.remindersList,
    );
  }
}

final class RemindersFinal extends RemindersState {
  const RemindersFinal({
    required super.remindersList,
  });
  @override
  List<Object> get props => [super.remindersList];

  @override
  RemindersFinal copyWith({List<Reminder>? remindersList}) {
    return RemindersFinal(
      remindersList: remindersList ?? this.remindersList,
    );
  }
}
