import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const DialogButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.inversePrimary,
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}
