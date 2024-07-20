import 'package:flutter/material.dart';

class StatsWidget extends StatelessWidget {
  final Map<String, int> stats;

  const StatsWidget({Key? key, required this.stats}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final workoutsLogged = stats['Workouts'] ?? 0;
    final totalSets = stats['Sets'] ?? 0;
    final totalReps = stats['Reps'] ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Workouts Logged: $workoutsLogged',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 20),
        Text(
          'Total Sets: $totalSets',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 20),
        Text(
          'Total Reps: $totalReps',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
