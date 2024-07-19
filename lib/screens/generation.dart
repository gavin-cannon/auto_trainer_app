import 'dart:async';

import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_trainer/controllers/generation_controller.dart';

class Generation extends ConsumerStatefulWidget {
  const Generation({super.key});

  @override
  ConsumerState<Generation> createState() {
    return _GenerationState();
  }
}

class _GenerationState extends ConsumerState<Generation>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> selectedAnswers = [];
  String buttonLabel = 'GO!';
  DateTime? startTime;
  Timer? timer;
  String elapsedTime = '00:00:00';
  bool showFilterBar = true;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final duration = DateTime.now().difference(startTime!);
        elapsedTime = duration.toString().split('.').first.padLeft(8, "0");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final generationController = ref.watch(generationScreenControllerProvider);

    // generationController.getAllExercises();
    // generationController.createWorkoutDisplay();

    List<String> filters = [
      'Length',
      'Muscle Groups',
      'Goal',
      'Difficulty',
      'Type of Exercise'
    ];
    String selectedFilter = 'Goal';

    void onFilterSelected(String filter) {
      setState(() {
        selectedFilter = filter;
      });
      //TODO Handle filter selection logic here
      print('Selected filter: $filter');
    }

    void logWorkout(DateTime startTime) {
      for (var item in generationController) {
        for (var set in item.exerciseSets) {
          if (!set.completed) {
            showIncompleteWarning(context, ref, startTime);
            return;
          }
        }
      }

      ref
          .read(generationScreenControllerProvider.notifier)
          .logWorkout(startTime, DateTime.now());
    }

    void _startWorkout() {
      setState(() {
        startTime = DateTime.now();
        buttonLabel = 'LOG!';
        showFilterBar = false;
      });
      startTimer();
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 1),
            // Color.fromRGBO(255, 255, 255, 1),
            // Color.fromRGBO(255, 0, 0, 1),
            // Color.fromRGBO(0, 195, 255, 1),
            // Color.fromRGBO(0, 195, 255, 1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            if (!showFilterBar)
              Text(
                elapsedTime,
                style: GoogleFonts.protestRiot(
                  color: Color.fromARGB(255, 0, 191, 255),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (showFilterBar)
              FiltersBar(
                onFilterSelected: (selectedSubFilters) {
                  print('Selected $selectedSubFilters');
                  ref
                      .read(generationScreenControllerProvider.notifier)
                      .filterWorkout(selectedSubFilters);
                },
              ),
            OutlinedButton.icon(
              onPressed: ref
                  .read(generationScreenControllerProvider.notifier)
                  .complexQueryCaller,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.fitness_center_outlined),
              label: const Text('Generate Workout'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: generationController.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: generationController[index],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            const SizedBox(height: 30),
            ElevatedButton(
              // Start of ElevatedButton widget
              onPressed: () {
                // Button action goes here
                // generationController.createWorkoutDisplay();
                if (buttonLabel == 'GO!') {
                  _startWorkout();
                } else {
                  logWorkout(startTime!);
                }
                print('hello');
              },
              style: ElevatedButton.styleFrom(
                // Start of style parameter
                splashFactory: NoSplash.splashFactory,
                shape: CircleBorder(), // Shape property
                padding: EdgeInsets.all(10), // Padding property
              ),
              child: Text(
                buttonLabel,
                style: GoogleFonts.protestRiot(
                  color: Color.fromARGB(255, 0, 191, 255),
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(height: 30),
            // ClipOval(
            //   child:

            //   SizedBox(
            //     width: 105,
            //     height: 105,
            //     child: OutlinedButton.icon(
            //       onPressed: () {
            //          if (buttonLabel == 'GO!') {
            //       _startWorkout();
            //     } else {
            //       logWorkout();
            //     }
            //       },
            //       style: OutlinedButton.styleFrom(
            //         foregroundColor: Colors.white,
            //       ),
            //       // icon: const Icon(Icons.arrow_right_alt),
            //       label: Expanded(
            //         child: Text(buttonLabel,
            //             style: GoogleFonts.protestRiot(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,

            //             ),
            //             overflow: TextOverflow.visible,
            //             ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

void showIncompleteWarning(
    BuildContext context, WidgetRef ref, DateTime startTime) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sets Not Marked Complete'),
        content: Text(
            'Press Continue to log all sets including those that are not marked complete.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              ref
                  .read(generationScreenControllerProvider.notifier)
                  .logWorkout(startTime, DateTime.now());
              Navigator.of(context).pop();
            },
            child: Text('Continue'),
          ),
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
