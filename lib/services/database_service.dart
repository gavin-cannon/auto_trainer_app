import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = 'tasks';
  final String _tasksIdColumnName = 'id';
  final String _tasksContentColumnName = 'content';
  final String _tasksStatusColumnName = 'status';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'auto_test.db');
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE $_tasksTableName (
      $_tasksIdColumnName INTEGER PRIMARY KEY,
      $_tasksContentColumnName TEXT NOT NULL,
      $_tasksStatusColumnName INTEGER NOT NULL
      )
''');
      },
    );
    return database;
  }
}
