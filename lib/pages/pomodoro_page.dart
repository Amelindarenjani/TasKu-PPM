import 'package:belajar_mobile/components/time_controller.dart';
import 'package:belajar_mobile/components/timer_card.dart';
import 'package:belajar_mobile/components/timer_option.dart';

import 'package:belajar_mobile/data/timer_service.dart';
import 'package:belajar_mobile/data/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  static int timeInMinute = 25;
  double percent = 0;
  int timeInSec = timeInMinute * 60;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimerService>(context);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isLandscape = constraints.maxWidth > 600;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: isLandscape
                    ? Column(
                        // Mengubah dari Row ke Column untuk memastikan satu kolom pada web
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Ronde
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${provider.rounds} / 4',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Round',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Title
                              Text(
                                provider.currentState,
                                style: TextStyle(
                                  color: renderColor(
                                      context, provider.currentState),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 30,
                                ),
                              ),

                              // Reset button
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () => Provider.of<TimerService>(
                                          context,
                                          listen: false)
                                      .reset(),
                                  icon: Icon(
                                    Icons.refresh,
                                    size: 32,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const TimerCard(), // TimerCard tetap ada di tengah
                          const SizedBox(height: 30),
                          const TimerOption(),
                          const SizedBox(height: 30),
                          const TimeController(),
                        ],
                      )
                    : Column(
                        // Untuk mobile tetap dalam satu kolom
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Ronde
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '${provider.rounds} / 4',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Round',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Title
                              Text(
                                provider.currentState,
                                style: TextStyle(
                                  color: renderColor(
                                      context, provider.currentState),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 35,
                                ),
                              ),

                              // Reset button
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () => Provider.of<TimerService>(
                                          context,
                                          listen: false)
                                      .reset(),
                                  icon: Icon(
                                    Icons.refresh,
                                    size: 32,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const TimerCard(), // TimerCard tetap ada di tengah
                          const SizedBox(height: 40),
                          const TimerOption(),
                          const SizedBox(height: 35),
                          const TimeController(),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
