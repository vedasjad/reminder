import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/core/enums/reminder_priority.dart';
import 'package:reminder/core/theme/colors.dart';
import 'package:reminder/features/reminders/presentation/screens/reminders_list_screen.dart';

import 'core/utils/app_bloc_observer.dart';
import 'features/reminders/data/models/reminder_model.dart';
import 'features/reminders/presentation/blocs/reminders_bloc/reminders_bloc.dart';
import 'injector.dart' as injector;
import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(ReminderPriorityAdapter());
  await Hive.openBox<ReminderModel>('remindersBox');
  injector.initializeServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RemindersBloc>(),
      child: MaterialApp(
        title: 'Reminder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
                bodyMedium: TextStyle(
              color: AppColors.white,
            ))),
        home: const Scaffold(
          body: SafeArea(
            child: RemindersListScreen(),
          ),
        ),
      ),
    );
  }
}
