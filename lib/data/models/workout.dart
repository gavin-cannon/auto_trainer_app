import 'package:auto_trainer/data/models/exercise.dart';

class Workout {
  Workout({
    required this.id,
    this.startDate,
    this.endDate,
    required this.session
  });
  final int id;
  final startDate;
  final endDate;
  Map<int, dynamic> session = {};

//  List ought to be Map of [{Exercise,  [{set: [reps, weight, etc]}] }]
//  OR
//  Map of {Exercise : [set: [reps, weight, etc]]}
}
