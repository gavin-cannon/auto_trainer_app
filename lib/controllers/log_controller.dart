import 'dart:async';
import 'dart:math';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/muscle.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/widgets/workout_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';

class LogScreenController extends StateNotifier<List<WorkoutDisplay>> {
  LogScreenController() : super([]);
  late final TrainerRepository trainerRepo = TrainerRepository();
  late List<Exercise> exercises;
  late List<Exercise> workout;
  late List<WorkoutDisplay> loggedWorkoutDisplay = [];

  final random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);

  Future<void> testFunction() async {
    print('hello');
  }

  Future<List<Map<String, dynamic>>> getLoggedWorkouts() async {
    var result = await trainerRepo.getAllWorkouts();
    return result;
  }

  Future<void> createWorkoutLogDisplay() async {
    var rawInformation = await getLoggedWorkouts();
    var workoutsMap = {};
    for (var map in rawInformation) {
      // print('inside for loop of function ');
      // print(map);
      int workoutId = map['workout_id'];
      if (!workoutsMap.containsKey(workoutId)) {
        workoutsMap[workoutId] = Workout(
            id: map['workout_id'],
            startDate: map['workout_start'],
            endDate: map['workout_end'],
            session: []);
      }
      List<WorkoutSet> sets = [];

      var exerciseRawInfo =
          await trainerRepo.getExerciseInfoById(map['exercise_id']);

      print(exerciseRawInfo);
      Exercise exercise = Exercise(
          id: exerciseRawInfo[0]['exercise_id'],
          name: exerciseRawInfo[0]['exercise_name'],
          description: exerciseRawInfo[0]['description'],
          push: exerciseRawInfo[0]['exercise_push'] == 1,
          pull: exerciseRawInfo[0]['exercise_pull'] == 1,
          muscles: [],
          skill: exerciseRawInfo[0]['skill']);

      for (var exerciseItem in exerciseRawInfo) {
        exercise.muscles.add(Muscle(
            id: exerciseItem['muscle_id'],
            name: exerciseItem['muscle_name'],
            primary: exerciseItem['primary_muscle'] == 1));
      }
      // var sessionKeys = workoutsMap[workoutId].session.toList();

      // if (sessionKeys.contains(map['exercise_id'])) {
      //   workoutsMap[workoutId].session[map['exercise_id']].add(WorkoutSet(reps: map[], weight: weight));
      // }
      workoutsMap[workoutId].session.add({
        map['exercise_id'],
        WorkoutSet(
            reps: map['reps'],
            weight: map['weight'],
            setGroup: map['set_group'])
      });
      // Exercise? exercise = workoutsMap[workoutId].session.firstWhere(
      //       (exercise) => exercise.id == map['exercise_id'],
      //       orElse: () => null,
      //     );

      // if (exercise == null) {
      //   exercise = Exercise(
      //       id: map['exercise_id'],
      //       name: map['exercise_name'],
      //       description: map['exercise_description'],
      //       push: map['exercise_push'] == 1,
      //       pull: map['exercise_pull'] == 1,
      //       muscles: [],
      //       skill: map['exercise_skill']);
      //   workoutsMap[workoutId].session.add(exercise);
      // }
      // exercise.muscles.add(
      //   Muscle(
      //       id: map['muscle_id'],
      //       name: map['muscle_name'],
      //       primary: map['muscle_primary']),
      // );
      // WorkoutSet workoutSet = WorkoutSet(
      //   reps: map['reps'],
      //   weight: map['weight'], // Assuming weight is stored as a double
      // );
    }

    List<dynamic> workouts = workoutsMap.values.toList();
    var workoutDisplayList = [];
    for (var workoutItem in workouts) {
      var display = WorkoutDisplay(workout: workoutItem, id: workoutItem.id);
      workoutDisplayList.add(display);
    }
    state = [...workoutDisplayList];
  }
}
//  Map<int, Exercise> exerciseMap = {};
//     print('maps print:');
//     print(maps.length);
//     for (var map in maps) {
//       print(map['exercise_name']);

//       int exerciseId = map['exercise_id'];
//       if (!exerciseMap.containsKey(exerciseId)) {
//         exerciseMap[exerciseId] = Exercise(
//           id: map['exercise_id'],
//           name: map['exercise_name'],
//           description: map['description'],
//           push: map['push'] == 1,
//           pull: map['pull'] == 1,
//           skill: map['skill'],
//           muscles: [],
//         );
//       }
//       exerciseMap[exerciseId]!.muscles.add(Muscle(
//             id: map['muscle_id'],
//             name: map['muscle_name'],
//             primary: map['primary_muscle'] == 1,
//           ));

//           return exerciseMap.values.toList();

final logScreenControllerProvider =
    StateNotifierProvider<LogScreenController, List<WorkoutDisplay>>((ref) {
  return LogScreenController();
});
