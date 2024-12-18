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

class EditWorkoutScreenController extends StateNotifier<Workout> {
  static Workout w = Workout(id: 0, session: []);

  EditWorkoutScreenController() : super(w);

  late final TrainerRepository trainerRepo = TrainerRepository();
  late Workout workout;

  Future<void> testFunction() async {
    print('hello');
  }

  Future<List<Map<String, dynamic>>> getSelectedWorkout() async {
    var result = await trainerRepo.getWorkout();
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
          return <Workout>[
            Workout(
                id: workoutMap['workout_id'],
                startDate: workoutMap['workout_start'],
                endDate: workoutMap['workout_end'],
                session: [])
          ];
        },
      );
    }
    state = newWorkoutLogs;
  }
}

final editWorkoutScreenControllerProvider =
    StateNotifierProvider<EditWorkoutScreenController, Workout>((ref) {
  return EditWorkoutScreenController();
});
