import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder/features/reminders/domain/usecases/add_or_update_reminder.dart';
import 'package:reminder/features/reminders/domain/usecases/delete_reminder.dart';
import 'package:reminder/features/reminders/domain/usecases/delete_reminders_list.dart';
import 'package:reminder/features/reminders/domain/usecases/get_reminders_list.dart';
import 'package:reminder/features/reminders/domain/usecases/update_reminder.dart';

import '../../../domain/entities/reminder.dart';

part 'reminders_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc({
    required AddReminder addReminder,
    required UpdateReminder updateReminder,
    required DeleteReminder deleteReminder,
    required DeleteRemindersList deleteRemindersList,
    required GetRemindersList getRemindersList,
  })  : _addReminder = addReminder,
        _updateReminder = updateReminder,
        _getRemindersList = getRemindersList,
        _deleteRemindersList = deleteRemindersList,
        _deleteReminder = deleteReminder,
        super(const RemindersInitial()) {
    on<AddReminderEvent>(_addReminderEventHandler);
    on<UpdateReminderEvent>(_updateReminderEventHandler);
    on<DeleteReminderEvent>(_deleteReminderEventHandler);
    on<DeleteRemindersListEvent>(_deleteRemindersListEventHandler);
    on<GetRemindersListEvent>(_getRemindersListEventHandler);
  }

  final AddReminder _addReminder;
  final UpdateReminder _updateReminder;
  final DeleteReminder _deleteReminder;
  final DeleteRemindersList _deleteRemindersList;
  final GetRemindersList _getRemindersList;

  Future<void> _addReminderEventHandler(
    AddReminderEvent event,
    Emitter<RemindersState> emit,
  ) async {
    final result = await _addReminder(
      AddReminderParams(
        reminder: event.reminder,
      ),
    );
    if (!result.isLeft()) {
      List<Reminder> newRemindersList = List<Reminder>.from(state.remindersList)
        ..add(event.reminder);
      emit(
        RemindersFinal(remindersList: newRemindersList),
      );
    }
  }

  Future<void> _updateReminderEventHandler(
    UpdateReminderEvent event,
    Emitter<RemindersState> emit,
  ) async {
    final result = await _updateReminder(
      UpdateReminderParams(
        reminder: event.reminder,
      ),
    );
    if (!result.isLeft()) {
      List<Reminder> newRemindersList =
          List<Reminder>.from(state.remindersList);
      print(newRemindersList.length);
      newRemindersList
          .removeWhere((reminder) => reminder.id == event.reminder.id);
      newRemindersList.add(event.reminder);
      print(newRemindersList.length);
      emit(
        RemindersFinal(remindersList: newRemindersList),
      );
    }
  }

  Future<void> _deleteReminderEventHandler(
    DeleteReminderEvent event,
    Emitter<RemindersState> emit,
  ) async {
    final result = await _deleteReminder(
      DeleteReminderParams(
        reminder: event.reminder,
      ),
    );
    if (!result.isLeft()) {
      List<Reminder> newRemindersList = List<Reminder>.from(state.remindersList)
        ..remove(event.reminder);
      emit(
        state.copyWith(remindersList: newRemindersList),
      );
    }
  }

  Future<void> _deleteRemindersListEventHandler(
    DeleteRemindersListEvent event,
    Emitter<RemindersState> emit,
  ) async {
    final result = await _deleteRemindersList(
      DeleteRemindersListParams(
        remindersList: event.remindersList,
      ),
    );
    if (!result.isLeft()) {
      List<Reminder> newRemindersList =
          List<Reminder>.from(state.remindersList);
      print(newRemindersList);
      List<Reminder> toBeDeleted = event.remindersList;
      print(toBeDeleted);
      for (Reminder reminder in toBeDeleted) {
        newRemindersList.removeWhere((rem) => reminder.id == rem.id);
        print("Hello");
      }
      emit(
        RemindersInitial(remindersList: newRemindersList),
      );
    }
  }

  Future<void> _getRemindersListEventHandler(
    GetRemindersListEvent event,
    Emitter<RemindersState> emit,
  ) async {
    final result = await _getRemindersList();
    result.fold(
      (failure) => emit(state),
      (newRemindersList) => emit(
        state.copyWith(remindersList: newRemindersList),
      ),
    );
  }
}
