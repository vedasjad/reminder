import 'package:get_it/get_it.dart';
import 'package:reminder/features/reminders/data/repositories/reminders_repository_impl.dart';
import 'package:reminder/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:reminder/features/reminders/domain/usecases/add_or_update_reminder.dart';
import 'package:reminder/features/reminders/domain/usecases/delete_reminder.dart';
import 'package:reminder/features/reminders/domain/usecases/delete_reminders_list.dart';
import 'package:reminder/features/reminders/domain/usecases/update_reminder.dart';

import 'features/reminders/data/datasources/reminders_local_data_source/reminders_local_data_source.dart';
import 'features/reminders/domain/usecases/get_reminders_list.dart';
import 'features/reminders/presentation/blocs/reminders_bloc/reminders_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeServices() async {
  ///----------------------------RemindersDataSources---------------------------

  getIt.registerLazySingleton<RemindersLocalDataSource>(
      () => RemindersLocalDataSourceImpl());

  ///----------------------------ReminderRepos----------------------------------

  getIt.registerLazySingleton<RemindersRepository>(
    () => RemindersRepositoryImpl(
      getIt(),
    ),
  );

  ///----------------------------ReminderBloc-----------------------------------

  getIt.registerFactory<RemindersBloc>(
    () => RemindersBloc(
      addReminder: getIt(),
      updateReminder: getIt(),
      deleteReminder: getIt(),
      deleteRemindersList: getIt(),
      getRemindersList: getIt(),
    ),
  );

  ///----------------------------RemindersUseCases------------------------------

  getIt.registerLazySingleton(
    () => AddReminder(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => UpdateReminder(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => DeleteReminder(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => DeleteRemindersList(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => GetRemindersList(
      getIt(),
    ),
  );
}
