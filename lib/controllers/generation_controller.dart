import 'dart:async';

import 'package:auto_trainer/data/models/exercise.dart';
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
    await trainerRepo.complexQuery();
  }

  Future<void> createWorkoutDisplay(length, goal) async {
    await getAllExercises();
    var newWorkoutDisplay = [];
    for (final exercise in filteredExercises) {
      print(exercise);
      newWorkoutDisplay.add(ExerciseDisplay(exercise: exercise));
    }
    state = [...newWorkoutDisplay];
    workoutDisplay.clear();
  }

  Future<void> filterWorkout(selectedSubFilters) async {
    filteredExercises.clear();
    await getAllExercises();
    var filters = selectedSubFilters.keys.toList();
    var subFilters = selectedSubFilters.values.toList();
    for (var i = 0; i < exercises.length; i++) {
      if (exercises[i].skill == subFilters[3]) {
        print('inside if state');
        filteredExercises.add(exercises[i]);
      }
    }
    createWorkoutDisplay(subFilters[0], subFilters[2]);
  }
}

final generationScreenControllerProvider =
    StateNotifierProvider<GenerationScreenController, List<ExerciseDisplay>>(
        (ref) {
  return GenerationScreenController();
});
