import 'package:auto_trainer/controllers/edit_controller.dart';
import 'package:auto_trainer/data/models/states/workout_state.dart';
import 'package:auto_trainer/data/models/workout.dart';
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
                  Navigator.pop(context);
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
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: workoutDetails.workout!.session[index],
                    );
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
