class WorkoutSet {
  final int reps;
  final double? weight; // weight can be null if not applicable
  final double? resistance; // resistance can be null if not applicable
  final Duration? duration; // duration can be null if not applicable

  WorkoutSet({
    required this.reps,
    this.weight,
    this.resistance,
    this.duration,
  });
}
