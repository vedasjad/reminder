import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class BottomFillBox extends StatefulWidget {
  const BottomFillBox({
    super.key,
    required this.isDescription,
    required this.text,
    required this.onChanged,
  });

  final bool isDescription;
  final String text;
  final Function(String) onChanged;

  @override
  State<BottomFillBox> createState() => _BottomFillBoxState();
}

class _BottomFillBoxState extends State<BottomFillBox> {
  String newValue = '';
  @override
  void initState() {
    newValue = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.sizeOf(context).width - 32,
      decoration: BoxDecoration(
        color: AppColors.darkTile,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Add Reminder ${widget.isDescription ? 'Description' : 'Title'}",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              initialValue: widget.text,
              autofocus: true,
              cursorColor: AppColors.blue,
              onChanged: (newString) {
                setState(() {
                  newValue = newString;
                });
              },
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 20,
              ),
              maxLength: widget.isDescription ? 150 : 50,
              textCapitalization: widget.isDescription
                  ? TextCapitalization.sentences
                  : TextCapitalization.words,
              decoration: InputDecoration(
                hintText:
                    'Enter ${widget.isDescription ? 'description' : 'title'}',
                hintStyle: const TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkText,
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onChanged(newValue);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
