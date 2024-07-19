import 'package:auto_trainer/data/models/muscle.dart';
import 'package:auto_trainer/data/models/set.dart';

class Exercise {
  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.push,
    required this.pull,
    this.workoutHistory,
    required this.muscles,
    this.primaryMuscleGroups,
    this.secondaryMuscleGroups,
    required this.skill,
    this.reps,
    this.workoutSets,
    //TODO add category to db
    this.category,
  });



  final int id;
  final String name;
  final String description;
  final bool push;
  final bool pull;

  //TODO Fix these typing START
  List<Muscle> muscles = [];
  List<String>? workoutHistory; // Example: List of dates or strings
  List<String>? primaryMuscleGroups; // Example: List of muscle group names
  List<String>? secondaryMuscleGroups; // Example: List of muscle group names
  List<String>? equipment;
  final String skill; // Example: Beginner, Intermediate, Advanced, Expert
  //TODO Fix these typing END


  int? reps;
  List<WorkoutSet>? workoutSets;
  String? category;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'push': push,
      'pull': pull,
      'skill': skill
    };
  }
}
