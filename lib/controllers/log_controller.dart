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
    var rawInfo = await getLoggedWorkouts();
    print(rawInfo);
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
