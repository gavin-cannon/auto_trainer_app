class Exercise {
  Exercise({
    required this.name,
    required this.description,
    required this.workoutHistory,
    required this.mainMuscleGroups,
    required this.secondaryMuscleGroups,
    required this.skillRequired,
    required this.reps,
    required this.sets,
    required this.category,
  });

  final String name;
  final String description;
  //TODO Fix these typing START
  final List<String> workoutHistory; // Example: List of dates or strings
  final List<String> mainMuscleGroups; // Example: List of muscle group names
  final List<String> secondaryMuscleGroups; // Example: List of muscle group names
  final String skillRequired; // Example: Beginner, Intermediate, Advanced
  //TODO Fix these typing END
  final int reps;
  final int sets;
  final String category;
}