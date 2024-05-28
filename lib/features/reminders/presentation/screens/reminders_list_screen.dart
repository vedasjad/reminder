import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/constants/assets/assets.dart';
import 'package:reminder/core/enums/reminder_priority.dart';
import 'package:reminder/core/theme/colors.dart';
import 'package:reminder/features/reminders/presentation/screens/configure_reminder_screen.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/reminder.dart';
import '../blocs/reminders_bloc/reminders_bloc.dart';
import '../widgets/reminder_tile.dart';

class RemindersListScreen extends StatefulWidget {
  const RemindersListScreen({super.key});

  @override
  State<RemindersListScreen> createState() => _RemindersListScreenState();
}

class _RemindersListScreenState extends State<RemindersListScreen> {
  @override
  void initState() {
    context.read<RemindersBloc>().add(
          const GetRemindersListEvent(),
        );
    super.initState();
  }

  List<Reminder> selectedReminders = [];

  @override
  Widget build(BuildContext context) {
    final bool isNoneSelected = selectedReminders.isEmpty;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isNoneSelected) {
            Uuid uuid = const Uuid();
            DateTime currentDateTime = DateTime.now();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: ConfigureReminderScreen(
                    reminder: Reminder(
                      dateTime: currentDateTime.copyWith(
                          day: currentDateTime.day + 1),
                      priority: ReminderPriority.low,
                      id: '${currentDateTime.toIso8601String()}_${uuid.v4()}',
                    ),
                    isNew: true,
                  ),
                ),
              ),
            );
          } else {
            context.read<RemindersBloc>().add(DeleteRemindersListEvent(
                remindersList: List.from(selectedReminders)));
            selectedReminders.clear();
            setState(() {});
          }
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.darkTile,
        child: isNoneSelected
            ? const Icon(
                Icons.add,
                color: AppColors.blue,
                size: 30,
              )
            : Image.asset(
                AppAssets.delete,
                color: Colors.red,
                height: 30,
              ),
      ),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: isNoneSelected
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    selectedReminders.clear();
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      AppAssets.cross,
                      color: AppColors.white,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
          title: isNoneSelected
              ? const Text(
                  "Reminders",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.white,
                  ),
                )
              : Text(
                  "${selectedReminders.length} item${selectedReminders.length > 1 ? 's' : ''} selected",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w100,
                    color: AppColors.white,
                  ),
                )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            BlocBuilder<RemindersBloc, RemindersState>(
              builder: (context, state) {
                List<Reminder> remindersList = List.from(state.remindersList);
                remindersList.sort((a, b) {
                  int priorityComparison =
                      b.priority.index.compareTo(a.priority.index);
                  if (priorityComparison != 0) {
                    return priorityComparison;
                  }
                  return a.dateTime.compareTo(b.dateTime);
                });
                return ListView.builder(
                  itemCount: remindersList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == remindersList.length) {
                      return const SizedBox(
                        height: 100,
                      );
                    }
                    return ReminderTile(
                      reminder: remindersList[index],
                      onLongPress: () {
                        if (selectedReminders.isEmpty) {
                          selectedReminders.add(remindersList[index]);
                          setState(() {});
                        }
                      },
                      onTap: () {
                        selectedReminders.isEmpty
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ConfigureReminderScreen(
                                      reminder: remindersList[index]),
                                ),
                              )
                            : selectedReminders.contains(remindersList[index])
                                ? selectedReminders.remove(remindersList[index])
                                : selectedReminders.add(remindersList[index]);
                        setState(() {});
                      },
                      isNoneSelected: selectedReminders.isEmpty,
                      isSelected:
                          selectedReminders.contains(remindersList[index]),
                    );
                  },
                );
              },
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.95),
                      ],
                      stops: const [0.0, 0.8, 0.9, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
