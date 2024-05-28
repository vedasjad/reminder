import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/constants/assets/assets.dart';
import 'package:reminder/core/theme/colors.dart';
import 'package:reminder/features/reminders/presentation/screens/configure_reminder_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/enums/reminder_priority.dart';
import '../../../../core/utils/toast.dart';
import '../../domain/entities/reminder.dart';
import '../blocs/reminders_bloc/reminders_bloc.dart';
import '../widgets/passed_reminder_tile.dart';
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

  bool isSorted = false;
  bool isHistory = false;

  List<Reminder> selectedReminders = [];

  @override
  Widget build(BuildContext context) {
    final bool isNoneSelected = selectedReminders.isEmpty;
    return BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ///for testing
              // NotificationService notificationService =
              //     getIt<NotificationService>();
              // notificationService.showNotification(
              //   99,
              //   'It Helps',
              //   'Dont go further',
              //   DateTime.now().add(const Duration(seconds: 1)),
              //   'Medium',
              // );
              if (isNoneSelected) {
                Uuid uuid = const Uuid();
                DateTime currentDateTime = DateTime.now();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: ConfigureReminderScreen(
                        reminder: Reminder(
                          dateTime: currentDateTime.copyWith(
                            day: currentDateTime.day,
                            second: 0,
                          ),
                          priority: ReminderPriority.low,
                          id: '${currentDateTime.toIso8601String()}_${uuid.v4()}'
                              .hashCode,
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
            centerTitle: !isNoneSelected,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: isNoneSelected
                ? null
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
                ? isHistory
                    ? const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.white,
                        ),
                      )
                    : const Text(
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
                  ),
            actions: [
              if (isNoneSelected)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isHistory = !isHistory;
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.history,
                      color: AppColors.white,
                    ),
                  ),
                ),
              isNoneSelected
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isSorted = !isSorted;
                        });
                        if (isSorted) {
                          showToast("Sorted by Time");
                        } else {
                          showToast("Sorted by Priority");
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.sort,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedReminders.clear();
                          selectedReminders.addAll(state.remindersList);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.select_all,
                          color: AppColors.white,
                        ),
                      ),
                    ),
            ],
          ),
          body: PopScope(
            canPop: isNoneSelected && !isHistory,
            onPopInvoked: (isPopped) {
              if (isNoneSelected && isHistory) {
                setState(() {
                  isHistory = false;
                });
              }
              if (!isNoneSelected) {
                selectedReminders.clear();
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Builder(
                    builder: (context) {
                      List<Reminder> remindersList =
                          List.from(state.remindersList);
                      List<Reminder> passedReminders = remindersList
                          .where((reminder) =>
                              reminder.dateTime.isBefore(DateTime.now()))
                          .toList();
                      remindersList.removeWhere((reminder) =>
                          reminder.dateTime.isBefore(DateTime.now()));
                      if (!isSorted) {
                        remindersList.sort((a, b) {
                          int priorityComparison =
                              b.priority.index.compareTo(a.priority.index);
                          if (priorityComparison != 0) {
                            return priorityComparison;
                          }
                          return a.dateTime.compareTo(b.dateTime);
                        });
                      } else {
                        remindersList.sort((a, b) {
                          return a.dateTime.compareTo(b.dateTime);
                        });
                      }
                      if (remindersList.isEmpty && !isHistory) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Reminders by clicking on the icon below.",
                                ),
                              ],
                            ),
                          ],
                        );
                      }

                      if (isHistory) {
                        if (passedReminders.isEmpty) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No History",
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: passedReminders.length + 1,
                          itemBuilder: (context, index) {
                            if (index == passedReminders.length) {
                              return const SizedBox(
                                height: 100,
                              );
                            }
                            return Hero(
                              tag: passedReminders[index].id,
                              child: PassedReminderTile(
                                reminder: passedReminders[index],
                                onLongPress: () {
                                  if (selectedReminders.isEmpty) {
                                    selectedReminders
                                        .add(passedReminders[index]);
                                    setState(() {});
                                  }
                                },
                                onTap: () {
                                  selectedReminders.isEmpty
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ConfigureReminderScreen(
                                                    reminder:
                                                        passedReminders[index]),
                                          ),
                                        )
                                      : selectedReminders
                                              .contains(passedReminders[index])
                                          ? selectedReminders
                                              .remove(passedReminders[index])
                                          : selectedReminders
                                              .add(passedReminders[index]);
                                  setState(() {});
                                },
                                isNoneSelected: selectedReminders.isEmpty,
                                isSelected: selectedReminders
                                    .contains(passedReminders[index]),
                              ),
                            );
                          },
                        );
                      } else {
                        return ListView.builder(
                          itemCount: remindersList.length + 1,
                          itemBuilder: (context, index) {
                            if (index == remindersList.length) {
                              return const SizedBox(
                                height: 100,
                              );
                            }
                            return Hero(
                              tag: remindersList[index].id,
                              child: ReminderTile(
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
                                            builder: (_) =>
                                                ConfigureReminderScreen(
                                                    reminder:
                                                        remindersList[index]),
                                          ),
                                        )
                                      : selectedReminders
                                              .contains(remindersList[index])
                                          ? selectedReminders
                                              .remove(remindersList[index])
                                          : selectedReminders
                                              .add(remindersList[index]);
                                  setState(() {});
                                },
                                isNoneSelected: selectedReminders.isEmpty,
                                isSelected: selectedReminders
                                    .contains(remindersList[index]),
                              ),
                            );
                          },
                        );
                      }
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
          ),
        );
      },
    );
  }
}
