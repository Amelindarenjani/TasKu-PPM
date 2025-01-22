import 'package:belajar_mobile/data/timer_service.dart';
import 'package:belajar_mobile/data/utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class TimerCard extends StatefulWidget {
  const TimerCard({super.key});

  @override
  State<TimerCard> createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  double percent = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    final seconds = provider.currentDuration % 60;
    return Column(
      children: [
        CircularPercentIndicator(
            percent: percent,
            radius: 130,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            animation: true,
            animateFromLastPercent: true,
            lineWidth: 15,
            progressColor: Theme.of(context).colorScheme.secondary,
            center: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    (provider.currentDuration ~/ 60).toString(),
                    style: TextStyle(
                        color: renderColor(context, provider.currentState),
                        fontSize: 65,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  ':',
                  style: TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      color: renderColor(context, provider.currentState)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: Text(
                    seconds == 0
                        ? "${seconds.round()}0"
                        : seconds.round().toString(),
                    style: TextStyle(
                        color: renderColor(context, provider.currentState),
                        fontSize: 65,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
