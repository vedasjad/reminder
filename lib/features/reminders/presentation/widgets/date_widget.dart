import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/colors.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    required this.selectedDateTime,
    required this.updateDateCallback,
    super.key,
  });
  final DateTime selectedDateTime;
  final Function(DateTime) updateDateCallback;

  Future showDateSelector(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: (context),
      firstDate: DateTime.now(),
      initialDate: selectedDateTime,
      currentDate: selectedDateTime,
      lastDate: DateTime(selectedDateTime.year + 5),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.blue,
              onPrimary: Colors.white,
              surface: AppColors.darkTile,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate == null) return;
    updateDateCallback(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await showDateSelector(context);
      },
      onTap: () async {
        await showDateSelector(context);
      },
      onHorizontalDragUpdate: (_) async {
        await showDateSelector(context);
      },
      onVerticalDragUpdate: (_) async {
        await showDateSelector(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${(selectedDateTime.day).toString().padLeft(2, '0')}  ',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w100,
              color: AppColors.white,
            ),
          ),
          Text(
            '${DateFormat('MMM').format(DateTime(selectedDateTime.year, selectedDateTime.month, 1))}  ',
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w100,
              color: AppColors.white,
            ),
          ),
          Text(
            (selectedDateTime.year).toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w100,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
