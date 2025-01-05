import 'package:auto_trainer/data/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditPageExerciseTile extends StatelessWidget {
  final List<Exercise> exercises;

  const EditPageExerciseTile({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    List<ListTile> exerciseItems = [];
    for (var exercise in exercises) {
      exerciseItems.add(ListTile(title: Text('Reps: ${exercise.reps}'), subtitle: Text('Weight: ${exercise.weight}'),));
    }
    return Column(
      children: [
        Card(
          child: ExpansionTile(
            title: Text(
              exercises[0].name,
            ),
            children: [...exerciseItems],
          ),
        ),
      ],
    );
  }
}
