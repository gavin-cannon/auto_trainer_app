class Workout {
  Workout({
    required this.id,
    this.date,
  });
  final int id;
  final date;
  List<dynamic> session = [];

//  List ought to be Map of [{Exercise,  [{set: [reps, weight, etc]}] }]
//  OR
//  Map of {Exercise : [set: [reps, weight, etc]]}
}
