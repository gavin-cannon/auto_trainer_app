import 'package:auto_trainer/controllers/generation_controller.dart';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/widgets/reps_weight_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseDisplay extends ConsumerStatefulWidget {
  final Exercise exercise;
  final List<WorkoutSet> exerciseSets;
  final int id;
  List<RepsWeightTile> repsWeightTiles = [];

  ExerciseDisplay(
      {required this.exercise, required this.exerciseSets, required this.id});

  @override
  ConsumerState<ExerciseDisplay> createState() {
    return _ExerciseDisplayState();
  }
}

class _ExerciseDisplayState extends ConsumerState<ExerciseDisplay> {
  bool expanded = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 0;
    for (var set in widget.exerciseSets) {
      widget.repsWeightTiles.add(RepsWeightTile(
        id: i,
        setObject: set,
        reps: set.reps,
        weight: set.weight!,
        repsController: TextEditingController(text: set.reps.toString()),
        weightController: TextEditingController(text: set.weight.toString()),
        onDelete: () {
          setState(() {
             widget.repsWeightTiles.removeWhere((item) => item.setObject == set);
            widget.exerciseSets.remove(set);
           
            ref
                .read(generationScreenControllerProvider.notifier)
                .removeSet(widget.id, set);
          });
        },
      ));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.exercise.name),
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
            ...widget.repsWeightTiles,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  var newItemReps = widget.exerciseSets.last.reps;
                  var newItemWeight = widget.exerciseSets.last.weight;
                  var id = widget.repsWeightTiles
                      .map((item) => item.id)
                      .reduce((a, b) => a > b ? a : b);
                  var newSet =
                      WorkoutSet(reps: newItemReps, weight: newItemWeight);
                  widget.exerciseSets.add(newSet);
                  widget.repsWeightTiles.add(RepsWeightTile(
                      setObject: newSet,
                      repsController:
                          TextEditingController(text: newItemReps.toString()),
                      weightController:
                          TextEditingController(text: newItemWeight.toString()),
                      onDelete: () {
                        setState(() {
                          widget.repsWeightTiles.removeWhere((item) => item.setObject == newSet);
            widget.exerciseSets.remove(newSet);
           
            ref
                .read(generationScreenControllerProvider.notifier)
                .removeSet(widget.id, newSet);
                        });
                      },
                      reps: newItemReps,
                      weight: newItemWeight!,
                      id: id));
                });
              },
              child: Text('+ Add Set'),
            ),
          ],
        ],
      ),
    );

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
}
