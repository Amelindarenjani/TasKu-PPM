import 'package:belajar_mobile/data/timer_service.dart';
import 'package:belajar_mobile/data/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerOption extends StatelessWidget {
  const TimerOption({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 170),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selectableTimes.map<Widget>((time) {
          return InkWell(
            onTap: () => provider.selectTime(double.parse(time)),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              width: 60,
              height: 40,
              decoration: int.parse(time) == provider.selectedTime
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))
                  : BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
              child: Center(
                child: Text(
                  (int.parse(time) ~/ 60).toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: int.parse(time) == provider.selectedTime
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
