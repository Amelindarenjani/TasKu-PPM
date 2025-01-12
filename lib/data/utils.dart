import 'package:flutter/material.dart';

List selectableTimes = [
  "300",
  "600",
  "900",
  "1200",
  "1500",
  "1800",
  "2100",
  "2400",
  "2700",
  "3000",
  "3300",
  "3600",
  "7200",
];

Color renderColor(BuildContext context, String currentState) {
  if (currentState == "FOCUS") {
    return Theme.of(context).colorScheme.inversePrimary;
  } else {
    return Colors.red.shade800;
  }
}
