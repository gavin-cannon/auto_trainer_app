import 'package:auto_trainer/controllers/generation_controller.dart';
import 'package:auto_trainer/data/dao/exercise_dao.dart';
import 'package:auto_trainer/data/database_setup.dart';
import 'package:auto_trainer/data/repositories/trainer_repository.dart';
import 'package:auto_trainer/screens/generation.dart';
import 'package:auto_trainer/screens/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 0, 132, 255),
  ),
  textTheme: GoogleFonts.protestRiotTextTheme(),
  splashFactory: NoSplash.splashFactory,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await initDatabase();
  // ExerciseDao exerciseDao = ExerciseDao();
  // await initDatabase();
  var trainerRepo = TrainerRepository();
  trainerRepo.setDatabase(db);
  // await DatabaseSetup();
  // final trainerRepositoryProvider = Provider((ref) => TrainerRepository(exerciseDao));
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const HostScreen(),
    );
  }
}

Future<Database> initDatabase() async {
  // Get the location where the database should be stored
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "auto_trainer.db");
  print(path);
  // Check if the database exists
  var exists = await databaseExists(path);

  if (!exists) {
    // If the database does not exist, create it by copying it from assets
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy the database file
    ByteData data = await rootBundle.load('assets/auto_trainer.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    print('in initdb creat');
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }

  // Open the database
  return await openDatabase(path, version: 1);
}
