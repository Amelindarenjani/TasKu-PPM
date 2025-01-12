import 'package:belajar_mobile/data/timer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeController extends StatefulWidget {
  const TimeController({super.key});

  @override
  State<TimeController> createState() => _TimeControllerState();
}

class _TimeControllerState extends State<TimeController> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () {
          provider.timerPlaying
              ? Provider.of<TimerService>(context, listen: false).pause()
              : Provider.of<TimerService>(context, listen: false).start();
        },
        icon: provider.timerPlaying
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
        color: Theme.of(context).colorScheme.inversePrimary,
        iconSize: 40,
      ),
    );
  }
}
