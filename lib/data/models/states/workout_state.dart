import 'package:auto_trainer/data/models/workout.dart';

enum WorkoutStatus {loading, loaded, error}

class WorkoutState {
  final WorkoutStatus status;
  final Workout? workout;
  final String? error;

  WorkoutState({
    required this.status,
    this.workout,
    this.error,
  });

  WorkoutState copyWith({
    WorkoutStatus? status,
    Workout? workout,
    String? error,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
      error: error,
    );
  }

}