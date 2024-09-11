import 'package:auto_trainer/data/models/exercise.dart';
import 'package:auto_trainer/data/models/set.dart';

class WorkoutItem {
  Exercise exercise;
  List<WorkoutSet> setInfo = [];

  WorkoutItem({
    required this.exercise,
    required this.setInfo,
  });
}
