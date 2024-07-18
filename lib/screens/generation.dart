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

class _GenerationState extends ConsumerState<Generation> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  @override
  Widget build(BuildContext context) {
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

    void logWorkout() {
      for (var item in generationController) {
        for (var set in item.exerciseSets) {
          if (!set.completed) {
            showIncompleteWarning(context, ref);
            return;
          }
        }
      }
      ref.read(generationScreenControllerProvider.notifier).logWorkout();
    }

    void _startWorkout() {
      print('nothing');
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
            ElevatedButton(
              // Start of ElevatedButton widget
              onPressed: () {
                // Button action goes here
                // generationController.createWorkoutDisplay();
                print('hello');
                logWorkout();
              },
              style: ElevatedButton.styleFrom(
                // Start of style parameter
                splashFactory: NoSplash.splashFactory,
                shape: CircleBorder(), // Shape property
                padding: EdgeInsets.all(10), // Padding property
              ),
              child: Text(
                'GO!',
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
            //     width: 80,
            //     height: 80,
            //     child: OutlinedButton.icon(
            //       onPressed: startQuiz,
            //       style: OutlinedButton.styleFrom(
            //         foregroundColor: Colors.white,
            //       ),
            //       // icon: const Icon(Icons.arrow_right_alt),
            //       label: Expanded(
            //         child: Text('GO!',
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

void showIncompleteWarning(BuildContext context, WidgetRef ref) {
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
                  .logWorkout();
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
