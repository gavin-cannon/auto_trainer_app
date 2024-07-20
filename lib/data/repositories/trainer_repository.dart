import 'dart:core';

import 'package:auto_trainer/data/dao/exercise_dao.dart';
import 'package:auto_trainer/data/database_setup.dart';
import 'package:auto_trainer/data/models/achievement.dart';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/muscle.dart';
import 'package:auto_trainer/data/models/set.dart';
import 'package:auto_trainer/widgets/exercise_display.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';

class TrainerRepository {
  var _db = DatabaseSetup.getDb();
  static var databaseMain;

  TrainerRepository();

  setDatabase(Database db) {
    databaseMain = db;
  }

  Future<List<Exercise>> getAllExercisesBasic() async {
    var database = await DatabaseSetup.getDb();
    final List<Map<String, dynamic>> maps =
        await databaseMain.query('exercise');
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        push: maps[i]['push'] == 1,
        pull: maps[i]['pull'] == 1,
        skill: maps[i]['skill'],
        muscles: [],
      );
    });
  }

  Future<List<Exercise>> getAllExercises() async {
    var database = await DatabaseSetup.getDb();
    final List<Map<String, dynamic>> maps = await databaseMain.rawQuery('''
 SELECT 
      exercise.id AS exercise_id, 
      exercise.name AS exercise_name, 
      exercise.description, 
      exercise.push, 
      exercise.pull, 
      exercise.skill, 
      muscle.id AS muscle_id, 
      muscle.name AS muscle_name, 
      muscle_exercise.primary_muscle
    FROM exercise
    INNER JOIN muscle_exercise ON exercise.id = muscle_exercise.exercise_id
    INNER JOIN muscle ON muscle.id = muscle_exercise.muscle_id;
''');
    Map<int, Exercise> exerciseMap = {};
    print('maps print:');
    print(maps.length);
    for (var map in maps) {
      print(map['exercise_name']);

      int exerciseId = map['exercise_id'];
      if (!exerciseMap.containsKey(exerciseId)) {
        exerciseMap[exerciseId] = Exercise(
          id: map['exercise_id'],
          name: map['exercise_name'],
          description: map['description'],
          push: map['push'] == 1,
          pull: map['pull'] == 1,
          skill: map['skill'],
          muscles: [],
        );
      }
      exerciseMap[exerciseId]!.muscles.add(Muscle(
            id: map['muscle_id'],
            name: map['muscle_name'],
            primary: map['primary_muscle'] == 1,
          ));

      // for (var map in maps) {
      //   print(map);
      // }
      // return List.generate(maps.length, (i) {
      //   return Exercise(
      //     id: maps[i]['id'],
      //     name: maps[i]['name'],
      //     description: maps[i]['description'],
      //     push: maps[i]['push'],
      //     pull: maps[i]['pull'],
      //     skill: maps[i]['skill'],
      //   );
      // });
    }
    return exerciseMap.values.toList();
  }

  Future<void> logWorkout(List<ExerciseDisplay> workout, int workoutId) async {
    for (ExerciseDisplay exerciseDis in workout) {
      for (WorkoutSet set in exerciseDis.exerciseSets) {
        await databaseMain.transaction((txn) async {
          int workoutDetailsId = await txn.rawInsert(
            '''
    INSERT INTO workout_details (
      exercise_id,
      reps,
      duration,
      distance,
      incline,
      weight,
      set_group
    ) VALUES (?, ?, ?, ?, ?, ?, ?)
    ''',
            [
              exerciseDis.exercise.id,
              set.reps,
              set.duration ?? null,
              set.distance ?? null,
              set.incline ?? null,
              set.weight,
              exerciseDis.id
            ],
          );

          print(workoutDetailsId);

          await txn.rawInsert(
            '''
    INSERT INTO workout_workout_details (
      workout_id,
      workout_details_id
      ) VALUES (?, ?)
    ''',
            [
              workoutId,
              workoutDetailsId,
            ],
          );
        });
      }
    }
  }

  Future<void> insertExercise(Exercise exercise) async {
    await _db.insert('exercise', exercise.toMap());
  }

  Future<void> updateExercise(Exercise exercise) async {
    await _db.update('exercise', exercise.toMap(),
        where: 'id = ?', whereArgs: [exercise.id]);
  }

  Future<void> deleteExercise(int id) async {
    await _db.delete('exercises', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> createWorkout(DateTime startTime, DateTime endTime) async {
    String textStartTime = startTime.toIso8601String();
    String textEndTime = endTime.toIso8601String();
    return await databaseMain.insert(
      'workout',
      {
        'start_date_time': textStartTime,
        'end_date_time': textEndTime,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllWorkouts() async {
    print('inside funciton call log');
    const String query = '''
    SELECT
      wd.*, 
      w.id AS workout_id,
      w.start_date_time AS workout_start,
      w.end_date_time AS workout_end
    FROM 
      workout_details wd
    JOIN
      workout_workout_details wwd ON wwd.workout_details_id = wd.workout_details_id
    JOIN 
      workout w ON wwd.workout_id = w.id
    ORDER BY 
      w.start_date_time DESC;
  ''';
    final List<Map<String, dynamic>> result =
        await databaseMain.rawQuery(query);
    // print(result);
    return result;
  }

  Future<int> getAllWorkoutsCount() async {
    const String query = '''
    SELECT COUNT(*) AS total_workouts
    FROM workout;
 ''';
    final result = await databaseMain.rawQuery(query);
    return result.first['total_workouts'] as int;
  }

  Future<int> getAllSetsCount() async {
    const String query = '''
    SELECT COUNT(*) AS total_sets
    FROM workout_details;
 ''';
    final result = await databaseMain.rawQuery(query);
    return result.first['total_sets'] as int;
  }

  Future<List<int>> getAllReps() async {
    const String query = '''
    SELECT reps 
    FROM workout_details;
 ''';
    final result = await databaseMain.rawQuery(query);
    List<int> repsList = [];
    for (var row in result) {
      if (row.containsKey('reps') && row['reps'] != null) {
        repsList.add(row['reps'] as int);
      }
    }
    return repsList;
  }

  Future<List<Map<String, dynamic>>> getExerciseInfoById(int exerciseId) async {
    const String query = '''
  SELECT 
      exercise.id AS exercise_id, 
      exercise.name AS exercise_name, 
      exercise.description, 
      exercise.push, 
      exercise.pull, 
      exercise.skill, 
      muscle.id AS muscle_id, 
      muscle.name AS muscle_name, 
      muscle_exercise.primary_muscle
    FROM exercise
    INNER JOIN muscle_exercise ON exercise.id = muscle_exercise.exercise_id
    INNER JOIN muscle ON muscle.id = muscle_exercise.muscle_id
    WHERE exercise.id = ?;
  ''';
    final List<Map<String, dynamic>> result =
        await databaseMain.rawQuery(query, [exerciseId]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    const String query = '''
    SELECT a.*
    FROM 
    achievement a
''';
    final List<Map<String, dynamic>> result =
        await databaseMain.rawQuery(query);
    return result;
  }

  Future<int?> getExerciseByName(String exerciseName) async {
    const String query = '''
SELECT 
e.id
FROM
exercise e
WHERE e.name = ?;
''';

    List<Map<String, dynamic>> result =
        await databaseMain.rawQuery(query, [exerciseName]);

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllSetsByExerciseId(
      int exerciseId) async {
    String query = '''
    SELECT 
    wd.weight
    FROM
    workout_details wd
    WHERE wd.exercise_id = ?;
    ''';
    List<Map<String, dynamic>> result =
        await databaseMain.rawQuery(query, [exerciseId]);
    return result;
  }

  Future<void> updateAchievement(Achievement achievement) async {
    var outcome = await databaseMain.update(
      'achievement',
      achievement.toMap(),
      where: 'id = ?',
      whereArgs: [achievement.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(outcome);
  }
}

final trainerRepositoryProvider = Provider((ref) => TrainerRepository());
