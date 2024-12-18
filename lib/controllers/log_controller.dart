import 'dart:async';
import 'dart:math';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/muscle.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/data/models/workout_item.dart';
import 'package:auto_trainer/widgets/workout_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';

class LogScreenController extends StateNotifier<Map<DateTime, List<Workout>>> {
  LogScreenController() : super({});
  late final TrainerRepository trainerRepo = TrainerRepository();
  late List<Exercise> exercises;
  late List<Workout> workouts = [];
  late List<WorkoutDisplay> loggedWorkoutDisplay = [];
  late Map<DateTime, List<Workout>> dateTimeWorkout = {};

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
    Map<DateTime, List<Workout>> newWorkoutLogs = {};
    var rawInfo = await getLoggedWorkouts();
    print(rawInfo);

    for (var workoutMap in rawInfo) {
      DateTime workoutDateAndTime = DateTime.parse(workoutMap['workout_end']);
      DateTime workoutDateOnly = DateTime.utc(workoutDateAndTime.year,
          workoutDateAndTime.month, workoutDateAndTime.day);

      print(workoutDateOnly);
      newWorkoutLogs.update(
        workoutDateOnly,
        (existingList) {
          existingList.add(Workout(
              id: workoutMap['workout_id'],
              startDate: workoutMap['workout_start'],
              endDate: workoutMap['workout_end'],
              session: []));
          return existingList.cast<Workout>();
        },
        ifAbsent: () {
          return <Workout>[Workout(
              id: workoutMap['workout_id'],
              startDate: workoutMap['workout_start'],
              endDate: workoutMap['workout_end'],
              session: [])];
        },
      );

      // if (newWorkoutLogs[workoutDateOnly]){
      // }
      // newWorkoutLogs[] = [
      //   Workout(
      //     id: workoutMap['workout_id'],
      //     startDate: workoutMap['workout_start'],
      //     endDate: workoutMap['workout_end'],
      //     session: [],
      //   )
      // ];
    }
    // var newLoggedWorkouts = [];

    // for (var workout in workouts) {
    //   newLoggedWorkouts.add(WorkoutDisplay(workout: workout, id: workout.id));
    // }
    state = newWorkoutLogs;
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
    StateNotifierProvider<LogScreenController, Map<DateTime, List<Workout>>>(
        (ref) {
  return LogScreenController();
});
