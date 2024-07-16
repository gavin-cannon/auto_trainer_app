import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:flutter/material.dart';

class ExerciseDisplay extends StatefulWidget {
  final Exercise exercise;
  final List<WorkoutSet> exerciseSet;
  ExerciseDisplay({required this.exercise, required this.exerciseSet });

  @override
  State<StatefulWidget> createState() {
    return _ExerciseDisplayState();
  }
}

class _ExerciseDisplayState extends State<ExerciseDisplay> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.exercise.name),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded) ...[
            for (var set in widget.exerciseSet)
              ListTile(
                title: Text('Reps: ${set.reps}, Weight: ${set.weight}'),
                onLongPress: () {
                  // Handle deletion on long press
                  // Example: show delete confirmation dialog
                },
              ),
            ElevatedButton(
              onPressed: () {
                // Handle adding a new set
                // Example: add a new ExerciseSet to widget.exercise.sets
              },
              child: Text('Add Set'),
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
