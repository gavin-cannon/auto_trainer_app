import 'package:auto_trainer/controllers/edit_controller.dart';
import 'package:auto_trainer/data/models/states/workout_state.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/widgets/edit_page_exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutEditScreen extends ConsumerStatefulWidget {
  final Workout workout;

  WorkoutEditScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutEditScreen> createState() {
    return _WorkoutEditScreenState();
  }
}

class _WorkoutEditScreenState extends ConsumerState<WorkoutEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final workoutDetails =
        ref.watch(editWorkoutScreenControllerProvider(widget.workout));

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () {
                  AlertDialog(
                    title: const Text('Delete Workout'),
                    content: Text(
                      'Are you sure you want to delete the workout ? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pop(false), // Return false on Cancel
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => Navigator.of(context)
                            .pop(true), // Return true on Confirm
                        child: const Text('Yes, delete'),
                      ),
                    ],
                  );
                  ref
                      .read(editWorkoutScreenControllerProvider(widget.workout)
                          .notifier)
                      .deleteWorkoutById(widget.workout.id);
                },
                child: Text('Delete'),
              ),
            ],
          ),
          switch (workoutDetails.status) {
            WorkoutStatus.loading => CircularProgressIndicator(
                color: Colors.blue, // Change the spinner color
                strokeWidth: 4.0, // Adjust the thickness of the spinner
              ),

            // TODO: Handle this case.
            WorkoutStatus.loaded => Expanded(
                child: ListView.builder(
                  itemCount: workoutDetails.workout!.session.length,
                  itemBuilder: (context, index) {
                    final exercise = workoutDetails.workout!.session[index][0];
                    final reps = exercise.reps;
                    return EditPageExerciseTile(
                        exercises: workoutDetails.workout!.session[index]);

                    // ListTile(
                    //   title: Text(exercise.name),
                    //   subtitle: Text('$reps'),
                    // );
                  },
                ),
              ),
            WorkoutStatus.error => throw UnimplementedError(),
          },
        ],
      ),
    ));
  }
}

Future<void> _deleteModal(BuildContext context, Workout workout) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete?', style: TextStyle(color: Colors.white)),
        content: Text('This action cannot be undone.',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm Delete'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
