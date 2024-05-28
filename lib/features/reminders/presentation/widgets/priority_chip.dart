import 'package:flutter/material.dart';
import 'package:reminder/core/extensions/reminder_priority.dart';

import '../../../../core/enums/reminder_priority.dart';
import '../../../../core/theme/colors.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({
    required this.priority,
    required this.selectedPriority,
    required this.onTap,
    super.key,
  });
  final ReminderPriority priority;
  final ReminderPriority selectedPriority;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPriority == priority;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? priority == ReminderPriority.low
                    ? Colors.green
                    : priority == ReminderPriority.medium
                        ? Colors.yellow
                        : Colors.red
                : Colors.transparent,
          ),
        ),
        padding:
            EdgeInsets.symmetric(vertical: 4, horizontal: isSelected ? 16 : 12),
        child: Text(
          priority.toShortString,
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 22,
            color: isSelected ? AppColors.white : AppColors.text,
          ),
        ),
      ),
    );
  }
}
