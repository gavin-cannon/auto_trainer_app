import 'package:auto_trainer/models/exercise.dart';

List<Exercise> exercises = [
    Exercise(
      name: 'Push-ups',
      description: 'Basic bodyweight exercise for upper body strength.',
      workoutHistory: ['2023-01-01', '2023-01-03', '2023-01-05'],
      mainMuscleGroups: ['Chest', 'Triceps'],
      secondaryMuscleGroups: ['Shoulders', 'Core'],
      skillRequired: 'Beginner',
      reps: 10,
      sets: 3,
      category: 'Strength',
    ),
    Exercise(
      name: 'Squats',
      description: 'Lower body exercise targeting quadriceps, hamstrings, and glutes.',
      workoutHistory: ['2023-01-02', '2023-01-04', '2023-01-06'],
      mainMuscleGroups: ['Quadriceps', 'Hamstrings', 'Glutes'],
      secondaryMuscleGroups: ['Calves', 'Core'],
      skillRequired: 'Beginner',
      reps: 12,
      sets: 3,
      category: 'Strength',
    ),
    Exercise(
      name: 'Running',
      description: 'Cardiovascular exercise that improves stamina and endurance.',
      workoutHistory: ['2023-01-01', '2023-01-03', '2023-01-05'],
      mainMuscleGroups: ['Legs', 'Cardiovascular system'],
      secondaryMuscleGroups: ['Core', 'Arms'],
      skillRequired: 'Beginner',
      reps: 0, // Not applicable for running
      sets: 0, // Not applicable for running
      category: 'Cardio',
    ),
    Exercise(
      name: 'Pull-ups',
      description: 'Upper body exercise targeting back, shoulders, and arms.',
      workoutHistory: ['2023-01-02', '2023-01-04', '2023-01-06'],
      mainMuscleGroups: ['Back', 'Shoulders', 'Arms'],
      secondaryMuscleGroups: ['Core'],
      skillRequired: 'Intermediate',
      reps: 8,
      sets: 3,
      category: 'Strength',
    ),
    Exercise(
      name: 'Yoga',
      description: 'Physical, mental, and spiritual practice that improves flexibility and mindfulness.',
      workoutHistory: ['2023-01-01', '2023-01-03', '2023-01-05'],
      mainMuscleGroups: ['Whole body'],
      secondaryMuscleGroups: ['Mind'],
      skillRequired: 'All levels',
      reps: 0, // Not applicable for yoga
      sets: 0, // Not applicable for yoga
      category: 'Flexibility',
    ),
    Exercise(
      name: 'Cycling',
      description: 'Cardiovascular exercise that improves leg strength and endurance.',
      workoutHistory: ['2023-01-02', '2023-01-04', '2023-01-06'],
      mainMuscleGroups: ['Legs', 'Cardiovascular system'],
      secondaryMuscleGroups: ['Core', 'Arms'],
      skillRequired: 'Beginner',
      reps: 0, // Not applicable for cycling
      sets: 0, // Not applicable for cycling
      category: 'Cardio',
    ),
    Exercise(
      name: 'Plank',
      description: 'Core exercise that strengthens the abdominals and improves stability.',
      workoutHistory: ['2023-01-01', '2023-01-03', '2023-01-05'],
      mainMuscleGroups: ['Core'],
      secondaryMuscleGroups: ['Shoulders', 'Legs'],
      skillRequired: 'Intermediate',
      reps: 60,
      sets: 3,
      category: 'Core',
    ),
    Exercise(
      name: 'Bench Press',
      description: 'Compound exercise for upper body strength, focusing on chest, shoulders, and triceps.',
      workoutHistory: ['2023-01-02', '2023-01-04', '2023-01-06'],
      mainMuscleGroups: ['Chest', 'Shoulders', 'Triceps'],
      secondaryMuscleGroups: ['Core'],
      skillRequired: 'Intermediate',
      reps: 8,
      sets: 4,
      category: 'Strength',
    ),
    Exercise(
      name: 'Swimming',
      description: 'Full-body workout that improves cardiovascular fitness and muscle strength.',
      workoutHistory: ['2023-01-01', '2023-01-03', '2023-01-05'],
      mainMuscleGroups: ['Whole body'],
      secondaryMuscleGroups: ['Cardiovascular system'],
      skillRequired: 'All levels',
      reps: 0, // Not applicable for swimming
      sets: 0, // Not applicable for swimming
      category: 'Cardio',
    ),
    Exercise(
      name: 'Deadlift',
      description: 'Compound exercise that targets the lower back, glutes, hamstrings, and core.',
      workoutHistory: ['2023-01-02', '2023-01-04', '2023-01-06'],
      mainMuscleGroups: ['Lower back', 'Glutes', 'Hamstrings'],
      secondaryMuscleGroups: ['Core'],
      skillRequired: 'Advanced',
      reps: 5,
      sets: 5,
      category: 'Strength',
    ),
  ];


