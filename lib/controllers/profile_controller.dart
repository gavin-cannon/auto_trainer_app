import 'dart:async';
import 'dart:math';
import 'package:auto_trainer/data/models/achievement.dart';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/muscle.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/widgets/workout_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';

class StatsProviderClass extends StateNotifier<Map<String, int>> {
  StatsProviderClass() : super({});
  late final TrainerRepository trainerRepo = TrainerRepository();

  final random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);

  Future<void> testFunction() async {
    print('hello');
  }

  Future<void> getStats() async {
    Map<String, int> newStatsMap = {};
    var totalWorkouts = await getTotalWorkouts();
    var totalSets = await getTotalSets();
    var totalReps = await getTotalReps();
    newStatsMap['Workouts'] = totalWorkouts;
    newStatsMap['Sets'] = totalSets;
    newStatsMap['Reps'] = totalReps;

    state = newStatsMap;
  }

  Future<int> getTotalWorkouts() async {
    int workoutTotal = await trainerRepo.getAllWorkoutsCount();
    return workoutTotal;
  }

  Future<int> getTotalSets() async {
    int setsTotal = await trainerRepo.getAllSetsCount();
    return setsTotal;
  }

  Future<int> getTotalReps() async {
    var rawData = await trainerRepo.getAllReps();
    int totalReps = 0;
    for (var reps in rawData) {
      totalReps += reps;
    }
    return totalReps;
  }
}

class AchievementProviderClass extends StateNotifier<List<Achievement>> {
  AchievementProviderClass() : super([]);
  late final TrainerRepository trainerRepo = TrainerRepository();

  final random = Random();
  int next(int min, int max) => min + random.nextInt(max - min);

  Future<void> testFunction() async {
    print('hello');
  }

  Future<void> getAllAchievements() async {
    var achievements = await trainerRepo.getAllAchievements();
    state = List.generate(achievements.length, (i) {
      return Achievement.fromMap(achievements[i]);
    });
  }

  Future<List<Achievement>> getAchievementsList() async {
    var achievements = await trainerRepo.getAllAchievements();
    return List.generate(achievements.length, (i) {
      return Achievement.fromMap(achievements[i]);
    });
  }

  Future<void> checkAchievements() async {
    var achievements = await getAchievementsList();
    print(achievements);
    for (var achievement in achievements) {
      if (!achievement.completed) {
        if (achievement.requirementType == 'max') {
          int? exerciseId =
              await trainerRepo.getExerciseByName(achievement.requirementField);
          var setMaps = await trainerRepo.getAllSetsByExerciseId(exerciseId!);
          for (var set in setMaps) {
            if (set['weight'] >= achievement.requirementAmount) {
              achievement.completed = true;
            }
          }
        } else if (achievement.requirementType == 'total') {
          if (achievement.requirementField == 'reps') {
            var rawData = await trainerRepo.getAllReps();
            int totalReps = 0;
            for (var reps in rawData) {
              totalReps += reps;
            }
            if (totalReps >= achievement.requirementAmount) {
              achievement.completed = true;
            }
          } else if (achievement.requirementField == 'sets') {
            var totalSets = await trainerRepo.getAllSetsCount();
            if (totalSets >= achievement.requirementAmount) {
              achievement.completed = true;
            }
          }
        }
      }
    }
    saveAchievements(achievements);
    state = [...achievements];
  }

  Future<void> saveAchievements(List<Achievement> achievements) async {
    for (Achievement achievement in achievements) {
      trainerRepo.updateAchievement(achievement);
    }
  }

  Future<int> getTotalWorkouts() async {
    int workoutTotal = await trainerRepo.getAllWorkoutsCount();
    return workoutTotal;
  }

  Future<int> getTotalSets() async {
    int setsTotal = await trainerRepo.getAllSetsCount();
    return setsTotal;
  }

  Future<int> getTotalReps() async {
    var rawData = await trainerRepo.getAllReps();
    int totalReps = 0;
    for (var reps in rawData) {
      totalReps += reps;
    }
    return totalReps;
  }
}

final achievementProviderClassProvider =
    StateNotifierProvider<AchievementProviderClass, List<Achievement>>((ref) {
  return AchievementProviderClass();
});

final statsProviderClassProvider =
    StateNotifierProvider<StatsProviderClass, Map<String, int>>((ref) {
  return StatsProviderClass();
});
