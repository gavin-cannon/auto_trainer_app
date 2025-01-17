import 'package:auto_trainer/data/models/set.dart';
import 'package:flutter/material.dart';

class RepsWeightTile extends StatefulWidget {
  final TextEditingController repsController;
  final TextEditingController weightController;
  final VoidCallback onDelete;
  final int reps;
  final int weight;
  final int id;
  final WorkoutSet setObject;

  const RepsWeightTile({super.key, 
    required this.repsController,
    required this.weightController,
    required this.onDelete,
    required this.reps,
    required this.weight,
    required this.id,
    required this.setObject,
  });

  @override
  _RepsWeightTileState createState() => _RepsWeightTileState();
}

class _RepsWeightTileState extends State<RepsWeightTile> {
  bool isChecked = false;

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
        widget.onDelete();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                  widget.setObject.completed = isChecked;
                });
              },
              checkColor: Colors.white,
              activeColor: isChecked ? Colors.green : Colors.grey,
            ),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: widget.repsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reps',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.setObject.reps = int.tryParse(value) ?? 0;
                },
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: widget.weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.setObject.weight = int.tryParse(value) ?? 0;
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
