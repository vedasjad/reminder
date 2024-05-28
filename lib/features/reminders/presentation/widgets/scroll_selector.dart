import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ScrollSelector extends StatelessWidget {
  const ScrollSelector({
    required this.selectedIndex,
    required this.scrollController,
    required this.onScroll,
    this.isMinute = false,
    super.key,
  });
  final int selectedIndex;
  final FixedExtentScrollController scrollController;
  final Function(int) onScroll;
  final bool isMinute;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 350,
          width: 50,
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 20,
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 60,
            controller: scrollController,
            onSelectedItemChanged: onScroll,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(
                    (isMinute ? index % 60 : index % 24)
                        .toString()
                        .padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color:
                          selectedIndex == (isMinute ? index % 60 : index % 24)
                              ? AppColors.white
                              : AppColors.text,
                    ),
                  ),
                );
              },
              childCount: null,
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.95),
                  ],
                  stops: const [0.0, 0.1, 0.2, 0.8, 0.9, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
