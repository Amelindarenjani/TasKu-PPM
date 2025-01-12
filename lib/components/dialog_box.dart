import 'package:belajar_mobile/components/dialog_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final FocusNode? focusNode;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              cursorColor: Colors.grey.shade700,
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: 'Create a new task',
                  hintStyle: TextStyle(color: Colors.grey.shade600)),
            ),

            // MaterialButton(onPressed: onPressed)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Button Cancel
                DialogButton(text: 'Cancel', onPressed: onCancel),

                // space
                const SizedBox(
                  width: 10,
                ),

                // Button save
                DialogButton(text: 'Save', onPressed: onSave)
              ],
            )
          ],
        ),
      ),
    );
  }
}
