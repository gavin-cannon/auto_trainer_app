import 'dart:core';

import 'package:auto_trainer/data/dao/exercise_dao.dart';
import 'package:auto_trainer/data/database_setup.dart';
import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/muscle.dart';
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
}

final trainerRepositoryProvider = Provider((ref) => TrainerRepository());
