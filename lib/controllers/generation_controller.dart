import 'dart:async';
import 'dart:math';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';
import 'package:path/path.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';

class GenerationScreenController extends StateNotifier<List<ExerciseDisplay>> {
  GenerationScreenController() : super([]);
  late final TrainerRepository trainerRepo = TrainerRepository();
  late List<Exercise> exercises;
  late List<Exercise> workout;
  late List<ExerciseDisplay> workoutDisplay = [];
  late List<Exercise> filteredExercises = [];
  final random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);

  // @override
  // Future<List<ExerciseDisplay>> build() {
  //   return createWorkoutDisplay();
  // }

  Future<void> testFunction() async {
    print('hello');
  }

  Future<void> getAllExercises() async {
    exercises = await trainerRepo.getAllExercises();
    for (final exercise in exercises) {
      print(exercise);
    }
  }

  complexQueryCaller() async {
    await trainerRepo.getAllExercises();
  }

  Future<void> createWorkoutDisplay(length, goal) async {
    workoutDisplay.clear();
    await getAllExercises();
    int sets;
    var reps;
    int weight = 25;
    int numberOfExercises = 1;
    switch (goal) {
      case 'Bodybuilding':
        {
          reps = 10;
          sets = next(3, 5);
        }
      case 'Strength Gain':
        {
          reps = 6;
          sets = next(2, 3);
        }
      default:
        {
          reps = 10;
          sets = next(1, 4);
        }
    }
    switch (length) {
      case '15 min':
        {
          numberOfExercises = 3;
        }
      case '30 min':
        {
          numberOfExercises = 4;
        }
      case '45 min':
        {
          numberOfExercises = 6;
        }
      case '1 hour':
        {
          numberOfExercises = 8;
        }
    }
    workoutDisplay = [];
    for (var i = 0; i < numberOfExercises; i++) {
      var exerciseSelector = next(0, filteredExercises.length);
      print(filteredExercises[exerciseSelector]);
      workoutDisplay.add(
        ExerciseDisplay(
          exercise: filteredExercises[exerciseSelector],
          exerciseSets: [
            WorkoutSet(reps: reps, weight: weight),
            WorkoutSet(reps: reps, weight: weight),
            WorkoutSet(reps: reps, weight: weight)
          ],
          id: i,
        ),
      );
    }
    state = [...workoutDisplay];
  }

  Future<void> filterWorkout(selectedSubFilters) async {
    filteredExercises.clear();
    await getAllExercises();
    var filters = selectedSubFilters.keys.toList();
    var subFilters = selectedSubFilters.values.toList();
    for (var i = 0; i < exercises.length; i++) {
      if (exercises[i].skill == subFilters[3]) {
        filteredExercises.add(exercises[i]);
      }
    }
    // for (var exercise in filteredExercises) {
    //   print(exercise.name);
    // }
    print(subFilters[0]);
    createWorkoutDisplay(subFilters[0], subFilters[2]);
  }

  Future<void> removeSet(int id, var set) async {
    // workoutDisplay[id].exerciseSets.remove(set);
    // print([...workoutDisplay]);
    print(workoutDisplay[id].exerciseSets[0].reps);
  }

  Future<void> logWorkout() async {
    print('inside the generation controller');
    for (var exercise in workoutDisplay) {
      for (var set in exercise.exerciseSets) {
        if (!set.completed) {}
      }
    }
  }
}

final generationScreenControllerProvider =
    StateNotifierProvider<GenerationScreenController, List<ExerciseDisplay>>(
        (ref) {
  return GenerationScreenController();
});
