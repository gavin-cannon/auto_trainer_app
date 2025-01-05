import 'dart:async';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/states/workout_state.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';

class EditWorkoutScreenController extends StateNotifier<WorkoutState> {
  static Workout w = Workout(id: 0, session: {});

  EditWorkoutScreenController({required Workout workout})
      : super(WorkoutState(status: WorkoutStatus.loading)) {
    fetchWorkout(workout);
  }

  late final TrainerRepository trainerRepo = TrainerRepository();
  late Workout storedWorkout;

  Future<void> fetchWorkout(Workout workout) async {
    final workoutDetails = await trainerRepo.getWorkoutDetailsById(workout.id);
    print(workoutDetails);
    for (var workoutMaps in workoutDetails) {
      if (workout.session.containsKey(workoutMaps['set_group'])) {
        workout.session[workoutMaps['set_group']].add(
          Exercise(
            id: workoutMaps['exercise_id'],
            description:
                workout.session[workoutMaps['set_group']][0].description,
            muscles: workout.session[workoutMaps['set_group']][0].muscles,
            name: workout.session[workoutMaps['set_group']][0].name,
            pull: workout.session[workoutMaps['set_group']][0].pull,
            push: workout.session[workoutMaps['set_group']][0].push,
            skill: workout.session[workoutMaps['set_group']][0].skill,
            reps: workoutMaps['reps'],
            weight: workoutMaps['weight'],
          ),
        );
      } else {
        trainerRepo.getExerciseMuscleInfoById(workoutMaps['exercise_id']);
        workout.session[workoutMaps['set_group']] = [
          Exercise(
            id: workoutMaps['exercise_id'],
            description: workoutMaps['description'],
            muscles: [],
            name: workoutMaps['name'],
            pull: workoutMaps['pull'] == 1,
            push: workoutMaps['push'] == 1,
            skill: workoutMaps['skill'],
            reps: workoutMaps['reps'],
            weight: workoutMaps['weight'],
          )
        ];
      }
    }
    state = WorkoutState(status: WorkoutStatus.loaded, workout: workout);
  }

  Future<void> deleteWorkoutById(int id) async {
    trainerRepo.deleteWorkoutAndDetailsById(id);
  }

  Future<String> testFunction() async {
    print('hello');
    await Future.delayed(Duration(seconds: 2));
    return 'hello';
  }

  // Future<List<Map<String, dynamic>>> getSelectedWorkout() async {
  // var result = await trainerRepo.getWorkout();
  // return result;
  // }

//   Future<void> createWorkoutLogDisplay() async {
//     Map<DateTime, List<Workout>> newWorkoutLogs = {};
//     var rawInfo = await getLoggedWorkouts();
//     print(rawInfo);

//     for (var workoutMap in rawInfo) {
//       DateTime workoutDateAndTime = DateTime.parse(workoutMap['workout_end']);
//       DateTime workoutDateOnly = DateTime.utc(workoutDateAndTime.year,
//           workoutDateAndTime.month, workoutDateAndTime.day);

//       print(workoutDateOnly);
//       newWorkoutLogs.update(
//         workoutDateOnly,
//         (existingList) {
//           existingList.add(Workout(
//               id: workoutMap['workout_id'],
//               startDate: workoutMap['workout_start'],
//               endDate: workoutMap['workout_end'],
//               session: []));
//           return existingList.cast<Workout>();
//         },
//         ifAbsent: () {
//           return <Workout>[
//             Workout(
//                 id: workoutMap['workout_id'],
//                 startDate: workoutMap['workout_start'],
//                 endDate: workoutMap['workout_end'],
//                 session: [])
//           ];
//         },
//       );
//     }
//     state = newWorkoutLogs;
//   }
}

final editWorkoutScreenControllerProvider = StateNotifierProvider.family<
    EditWorkoutScreenController, WorkoutState, Workout>((ref, workout) {
  return EditWorkoutScreenController(workout: workout);
});
