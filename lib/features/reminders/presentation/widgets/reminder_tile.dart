import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/core/constants/assets/assets.dart';

import '../../../../core/enums/reminder_priority.dart';
import '../../../../core/theme/colors.dart';
import '../../domain/entities/reminder.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({
    required this.reminder,
    required this.isSelected,
    required this.onLongPress,
    required this.isNoneSelected,
    required this.onTap,
    super.key,
  });

  final Reminder reminder;
  final VoidCallback onLongPress;
  final bool isSelected;
  final bool isNoneSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkTile,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: reminder.priority == ReminderPriority.low
                    ? Colors.green
                    : reminder.priority == ReminderPriority.medium
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(reminder.dateTime),
                      style: const TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${(reminder.dateTime.day).toString().padLeft(2, '0')} ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '${DateFormat('MMM').format(DateTime(reminder.dateTime.year, reminder.dateTime.month, 1))} ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          (reminder.dateTime.year).toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        reminder.title ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        reminder.description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                          fontWeight: FontWeight.w100,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (isSelected)
            Container(
              height: 100,
              color: Colors.black54,
              margin: const EdgeInsets.only(bottom: 16),
            ),
          Container(
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isNoneSelected && isSelected)
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue,
                    ),
                    child: Image.asset(
                      AppAssets.tick,
                      color: AppColors.white,
                    ),
                  ),
                if (!isNoneSelected && !isSelected)
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.text,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
