class WorkoutSet {
  int reps;
  int weight; 
  double? resistance; 
  Duration? duration; 
  bool completed;
  int? incline;
  int? distance;
  int? setGroup;
  int get repsGetter => reps;

  WorkoutSet({
    required this.reps,
    required this.weight,
    this.resistance,
    this.duration,
    this.completed = false,
    this.incline,
    this.distance,
    this.setGroup
  });
}
