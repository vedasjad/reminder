import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import 'bottom_fill_box.dart';

class FillTile extends StatefulWidget {
  const FillTile({
    super.key,
    this.isDescription = false,
    required this.text,
    required this.onChanged,
  });
  final bool isDescription;
  final String text;
  final Function(String) onChanged;

  @override
  State<FillTile> createState() => _FillTileState();
}

class _FillTileState extends State<FillTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return BottomFillBox(
                  isDescription: widget.isDescription,
                  text: widget.text,
                  onChanged: widget.onChanged,
                );
              });
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.darkTile,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.text.trim().isEmpty
                            ? "Enter ${widget.isDescription ? 'Description' : 'Title'}"
                            : widget.text.trim(),
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: widget.isDescription
                              ? FontWeight.w100
                              : FontWeight.normal,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
