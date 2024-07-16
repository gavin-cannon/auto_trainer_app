import 'package:auto_trainer/data/models/exercise.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSetup {
  static Database? _db;

  static Future<void> getConnection() async {
    _db ??=
        await openDatabase(join(await getDatabasesPath(), 'auto_trainer.db'))
            .then((database) {
      _db = database;
      print('hello this is a database');
      print(_db);
    });
  }

  static getDb() {
    if (_db == null) {
      getConnection();
    }
    return _db;
  }
}
