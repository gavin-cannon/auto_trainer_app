class WorkoutSet {
  int reps;
  int weight; // weight can be null if not applicable
  double? resistance; // resistance can be null if not applicable
  Duration? duration; // duration can be null if not applicable
  bool completed ;
  int get repsGetter => reps;

  WorkoutSet({
    required this.reps,
    required this.weight,
    this.resistance,
    this.duration,
    this.completed = false,
  });
}
