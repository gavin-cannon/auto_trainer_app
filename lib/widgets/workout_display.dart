import 'package:auto_trainer/controllers/generation_controller.dart';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';
import 'package:auto_trainer/widgets/reps_weight_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutDisplay extends ConsumerStatefulWidget {
  final Workout workout;
  final int id;
  List<ExerciseDisplay>? exerciseDisplayList;

  WorkoutDisplay({required this.workout, required this.id});

  @override
  ConsumerState<WorkoutDisplay> createState() {
    return _WorkoutDisplayState();
  }
}

class _WorkoutDisplayState extends ConsumerState<WorkoutDisplay> {
  bool expanded = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var setsGroupsMaps = {};

    // for (var itemSet in widget.workout.session) {
    //   for
    // }
    // for (var item in widget.workout.session) {
    //   if ( setsGroupsMaps.containsKey(item.setInfo.setGroup)){

    //   }
    //   item.setInfo.setGroup;

      //   var item = itemSet.toList();
      //   var setGroup = item[1].setGroup;
      //   var exercise = item[0];
      //   var workoutSet = item[1];

      //   if (!setsMap.containsKey(setGroup)) {
      //     setsMap[setGroup] = {};
      //   }

      //   if (!setsMap[setGroup].containsKey(exercise)) {
      //     setsMap[setGroup][exercise] = [];
      //   }
      //   for (var key in setsMap[setGroup].keys) {
      //     if (key.id == exercise.id) {
      //       setsMap[setGroup][key].add(workoutSet);
      //     }
      //   }
      //   // setsMap[setGroup][exercise]!.add(workoutSet);
      // }
      // var groupedExerciseSets = setsMap.entries.toList();
      // int i = 0;

      // for (var exercise in groupedExerciseSets) {
      //   print(exercise.value);
      //   var exerciseObjects = exercise.value.keys.toList();
      //   print(exerciseObjects);
      //   var exerciseDisplay = ExerciseDisplay(
      //       exercise: exerciseObjects[0], exerciseSets: exercise.value[1], id: i);
      //   i++;
    // }

    // if (!setsMap.containsKey(item[0])) {
    //   setsMap[item[0]] = [];
    //   setsMap[item[0]]
    //       .add(WorkoutSet(reps: item[1].reps, weight: item[1].weight));
    // } else {
    //   setsMap[item[0]]
    //       .add(WorkoutSet(reps: item[1].reps, weight: item[1].weight));
    // }

    //   widget.repsWeightTiles.add(RepsWeightTile(
    //     id: i,
    //     setObject: set,
    //     reps: set.reps,
    //     weight: set.weight!,
    //     repsController: TextEditingController(text: set.reps.toString()),
    //     weightController: TextEditingController(text: set.weight.toString()),
    //     onDelete: () {
    //       setState(() {
    //         widget.repsWeightTiles.removeWhere((item) => item.setObject == set);
    //         widget.exerciseSets.remove(set);

    //         ref
    //             .read(generationScreenControllerProvider.notifier)
    //             .removeSet(widget.id, set);
    //       });
    //     },
    //   ));
    //   i++;
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didUpdateWidget(covariant WorkoutDisplay oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   if (oldWidget.repsWeightTiles != widget.repsWeightTiles) {
  //     int i = 0;
  //     for (var set in widget.exerciseSets) {
  //       widget.repsWeightTiles.add(RepsWeightTile(
  //         id: i,
  //         setObject: set,
  //         reps: set.reps,
  //         weight: set.weight!,
  //         repsController: TextEditingController(text: set.reps.toString()),
  //         weightController: TextEditingController(text: set.weight.toString()),
  //         onDelete: () {
  //           setState(() {
  //             widget.repsWeightTiles
  //                 .removeWhere((item) => item.setObject == set);
  //             widget.exerciseSets.remove(set);

  //             ref
  //                 .read(generationScreenControllerProvider.notifier)
  //                 .removeSet(widget.id, set);
  //           });
  //         },
  //       ));
  //       i++;
  //     }
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.workout.startDate),
            trailing: IconButton(
              icon:
                  Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded) ...[
            ...[Text('hello')],
          ],
        ],
      ),
    );
  }
  // Container(
  //   padding: EdgeInsets.all(16.0),
  //   margin: EdgeInsets.all(16.0),
  //   decoration: BoxDecoration(
  //     color: Colors.black,
  //     border: Border.all(
  //       color: Color.fromARGB(255, 0, 132, 255),
  //     ),
  //     borderRadius: BorderRadius.circular(8.0),

  //   ),
  //   child: Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //      Text(
  //         widget.exercise.name,
  //         style: TextStyle(
  //           fontSize: 20.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(height: 10.0),
  //       Text(
  //         widget.exercise.name,
  //         style: TextStyle(fontSize: 16.0),
  //       ),
  //       SizedBox(height: 10.0),
  //       ElevatedButton(
  //         onPressed: () {},
  //         child: Text('Button'),
  //       ),
  //     ],
  //   ),
  // );
}
