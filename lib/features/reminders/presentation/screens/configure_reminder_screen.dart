import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/core/constants/assets/assets.dart';
import 'package:reminder/core/enums/reminder_priority.dart';
import 'package:reminder/core/theme/colors.dart';
import 'package:reminder/features/reminders/presentation/widgets/date_widget.dart';
import 'package:reminder/features/reminders/presentation/widgets/scroll_selector.dart';

import '../../domain/entities/reminder.dart';
import '../blocs/reminders_bloc/reminders_bloc.dart';
import '../widgets/fill_tile.dart';
import '../widgets/priority_chip.dart';

class ConfigureReminderScreen extends StatefulWidget {
  const ConfigureReminderScreen({
    required this.reminder,
    this.isNew = false,
    super.key,
  });
  final Reminder reminder;
  final bool isNew;

  @override
  State<ConfigureReminderScreen> createState() =>
      _ConfigureReminderScreenState();
}

class _ConfigureReminderScreenState extends State<ConfigureReminderScreen> {
  late DateTime selectedDateTime;
  late FixedExtentScrollController _hourScrollController,
      _minuteScrollController;
  String _title = '', _description = '';
  late ReminderPriority _selectedPriority;

  final List<ReminderPriority> priorities = [
    ReminderPriority.low,
    ReminderPriority.medium,
    ReminderPriority.high,
  ];

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.reminder.dateTime;
    _hourScrollController = FixedExtentScrollController(
        initialItem: selectedDateTime.hour + 1000 * 24);
    _minuteScrollController = FixedExtentScrollController(
        initialItem: selectedDateTime.minute + 1000 * 60);
    _title = widget.reminder.title ?? '';
    _description = widget.reminder.description ?? '';
    _selectedPriority = widget.reminder.priority;
  }

  String getTimeDifference(DateTime givenDateTime) {
    DateTime now = DateTime.now();
    Duration difference = givenDateTime.difference(now);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    if (years > 0) {
      return '$years year${years > 1 ? 's' : ''} and $months month${months > 1 ? 's' : ''}';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''} and $days day${days > 1 ? 's' : ''}';
    } else if (days > 0) {
      return '$days day${days > 1 ? 's' : ''} and $hours hour${hours > 1 ? 's' : ''}';
    } else {
      return '$hours hour${hours > 1 ? 's' : ''} and $minutes min${minutes > 1 ? 's' : ''}';
    }
  }

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScrollSelector(
                    selectedIndex: selectedDateTime.hour,
                    scrollController: _hourScrollController,
                    onScroll: (index) {
                      setState(() {
                        selectedDateTime = selectedDateTime.copyWith(
                          hour: index % 24,
                        );
                      });
                    },
                  ),
                  ScrollSelector(
                    selectedIndex: selectedDateTime.minute,
                    scrollController: _minuteScrollController,
                    onScroll: (index) {
                      setState(() {
                        selectedDateTime = selectedDateTime.copyWith(
                          minute: index % 60,
                        );
                      });
                    },
                    isMinute: true,
                  ),
                ],
              ),
              DateWidget(
                selectedDateTime: selectedDateTime,
                updateDateCallback: (selectedDate) {
                  setState(() {
                    selectedDateTime = selectedDateTime.copyWith(
                      day: selectedDate.day,
                      month: selectedDate.month,
                      year: selectedDate.year,
                    );
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(priorities.length, (index) {
                  return PriorityChip(
                    priority: priorities[index],
                    selectedPriority: _selectedPriority,
                    onTap: () {
                      setState(() {
                        _selectedPriority = priorities[index];
                      });
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              FillTile(
                text: _title,
                onChanged: (newTitle) {
                  setState(() {
                    _title = newTitle;
                  });
                },
              ),
              FillTile(
                text: _description,
                onChanged: (newDescription) {
                  setState(() {
                    _description = newDescription;
                  });
                },
                isDescription: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<RemindersBloc>().add(
                            DeleteReminderEvent(
                              reminder: widget.reminder,
                            ),
                          );
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppAssets.delete,
                        color: AppColors.white,
                        height: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                child: Image.asset(
                  AppAssets.cross,
                  color: AppColors.white,
                  height: 30,
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  "Add Reminder",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Reminder in ${getTimeDifference(selectedDateTime)}",
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                !widget.isNew
                    ? context.read<RemindersBloc>().add(
                          UpdateReminderEvent(
                            reminder: widget.reminder.copyWith(
                              dateTime: selectedDateTime,
                              title: _title,
                              description: _description,
                              priority: _selectedPriority,
                            ),
                          ),
                        )
                    : context.read<RemindersBloc>().add(
                          AddReminderEvent(
                            reminder: widget.reminder.copyWith(
                              dateTime: selectedDateTime,
                              title: _title,
                              description: _description,
                              priority: _selectedPriority,
                            ),
                          ),
                        );
                Navigator.pop(context);
              },
              child: SizedBox(
                child: Image.asset(
                  AppAssets.tick,
                  color: AppColors.white,
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
