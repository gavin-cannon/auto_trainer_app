import 'package:auto_trainer/data/models/set.dart';
import 'package:flutter/material.dart';

class RepsWeightTile extends StatelessWidget {
  final TextEditingController repsController;
  final TextEditingController weightController;
  final VoidCallback onDelete;
  int reps;
  int weight;
  int id;
  final WorkoutSet setObject;

  RepsWeightTile({
    required this.repsController,
    required this.weightController,
    required this.onDelete,
    required this.reps,
    required this.weight,
    required this.id,
    required this.setObject,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(UniqueKey().toString()), // Unique key for each tile
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: repsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reps',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setObject.reps = int.tryParse(value) ?? 0;
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setObject.weight = int.tryParse(value) ?? 0;
                },
              ),
            ),
            SizedBox(width: 8.0),
            Text('lbs'),
          ],
        ),
      ),
    );
  }
}
