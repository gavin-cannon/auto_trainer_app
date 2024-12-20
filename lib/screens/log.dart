import 'package:auto_trainer/controllers/log_controller.dart';
import 'package:auto_trainer/data/models/workout.dart';
import 'package:auto_trainer/screens/workout_edit.dart';
import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:auto_trainer/widgets/workout_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/questions_screen.dart';
// import 'package:quiz_app/start_screen.dart';
// import 'package:quiz_app/results_screen.dart';

class LogScreen extends ConsumerStatefulWidget {
  const LogScreen({super.key});

  @override
  ConsumerState<LogScreen> createState() {
    return _LogScreenState();
  }
}

class _LogScreenState extends ConsumerState<LogScreen> {
  late final ValueNotifier<List<Workout>> _selectedWorkouts;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Map<DateTime, List<Workout>> kWorkouts = {};

  // {
  //   DateTime.utc(2024, 11, 1): [
  //     Workout(
  //         id: 0,
  //         startDate: DateTime.utc(2024, 11, 1),
  //         session: [],
  //         endDate: DateTime.utc(2024, 11, 1)),
  //     Workout(
  //         id: 0,
  //         startDate: DateTime.utc(2024, 11, 1),
  //         session: [],
  //         endDate: DateTime.utc(2024, 11, 1))
  //   ],
  //   DateTime.utc(2024, 12, 1): [
  //     Workout(
  //         id: 0,
  //         startDate: DateTime.utc(2024, 12, 1),
  //         session: [],
  //         endDate: DateTime.utc(2024, 12, 1)),
  //     Workout(
  //         id: 0,
  //         startDate: DateTime.utc(2024, 12, 1),
  //         session: [],
  //         endDate: DateTime.utc(2024, 12, 1))
  //   ],
  // };

  // {
  //   DateTime.utc(2024, 11, 1): [
  //     Workout(
  //         id: 0,
  //         startDate: DateTime.utc(2024, 11, 1),
  //         session: [],
  //         endDate: DateTime.utc(2024, 11, 1))
  //   ]
  // };

  @override
  void initState() {
    // TODO: implement initState
    _loadLoggedWorkouts();
    super.initState();
    _selectedDay = _focusedDay;
    _selectedWorkouts = ValueNotifier(_getWorkoutsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedWorkouts.dispose();
    super.dispose();
  }

  Future<void> _loadLoggedWorkouts() async {
    await ref
        .read(logScreenControllerProvider.notifier)
        .createWorkoutLogDisplay();
    kWorkouts = ref.read(logScreenControllerProvider);
    // kWorkouts = ref.read(logScreenControllerProvider);
    // ref.read(logScreenControllerProvider.notifier).createWorkoutLogDisplay();
    // setState(() {
    //   print(ref.read(logScreenControllerProvider));
    // });
  }

  List<Workout> _getWorkoutsForDay(DateTime day) {
    // Implementation exampleb
    return kWorkouts[day] ?? [];
  }

  List<DateTime> daysInRange(DateTime start, DateTime end) {
    return [];
  }

  List<Workout> _getWorkoutsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getWorkoutsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedWorkouts.value = _getWorkoutsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedWorkouts.value = _getWorkoutsForRange(start, end);
    } else if (start != null) {
      _selectedWorkouts.value = _getWorkoutsForDay(start);
    } else if (end != null) {
      _selectedWorkouts.value = _getWorkoutsForDay(end);
    }
  }

  @override
  Widget build(context) {
    Future<void> _workoutModal(BuildContext context, Workout workout) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$workout', style: TextStyle(color: Colors.white)),
            content: Text(
                'A dialog is a type of modal window that\n'
                'appears in front of app content to\n'
                'provide critical information, or prompt\n'
                'for a decision to be made.',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Edit'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Delete'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  _deleteModal(context, workout);
                },
              ),
            ],
          );
        },
      );
    }

    final loggedWorkouts = ref.watch(logScreenControllerProvider);
    // ref.read(logScreenControllerProvider.notifier).createWorkoutLogDisplay();

    // int currentIndex = 0;
    // void goToNextWorkout(List<Widget> loggedWorkouts) {
    //   setState(() {
    //     if (currentIndex < loggedWorkouts.length - 1) {
    //       currentIndex++;
    //       print(currentIndex);
    //     }
    //   });
    // }

    // void goToPreviousWorkout() {
    //   setState(() {
    //     if (currentIndex > 0) {
    //       currentIndex--;
    //     }
    //   });
    // }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(logScreenControllerProvider.notifier)
                  .createWorkoutLogDisplay();
              kWorkouts = loggedWorkouts;
              print('this is working');
            },
            child: Text('Hello'),
          ),
          TableCalendar<Workout>(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: (day) {
              // Return the workouts for the specific day from the map
              print(loggedWorkouts);
              print(day);
              print(loggedWorkouts[day]);
              return loggedWorkouts[day] ?? [];
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Workout>>(
              valueListenable: _selectedWorkouts,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WorkoutEditScreen(workout: value[index])),
                            );
                          },
                          child: Text('${value[index]}'),
                        )

                        // ListTile(
                        //   onTap: () => print('${value[index]}'),
                        //   title: Text('${value[index]}'),
                        // ),
                        );
                  },
                );
              },
            ),
          ),

          // ElevatedButton(
          //   // Start of ElevatedButton widget
          //   onPressed: () {
          //     // Button action goes here
          //     // generationController.createWorkoutDisplay();
          //     ref
          //         .read(logScreenControllerProvider.notifier)
          //         .createWorkoutLogDisplay();
          //     print('hello');
          //     print(loggedWorkouts);
          //     print(loggedWorkouts.isNotEmpty);
          //   },
          //   style: ElevatedButton.styleFrom(
          //     // Start of style parameter
          //     splashFactory: NoSplash.splashFactory,
          //     shape: CircleBorder(), // Shape property
          //     padding: EdgeInsets.all(10), // Padding property
          //   ),
          //   child: Text(
          //     'go',
          //     style: GoogleFonts.protestRiot(
          //       color: Color.fromARGB(255, 0, 191, 255),
          //       fontSize: 70,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     overflow: TextOverflow.visible,
          //   ),
          // ),
          // if (loggedWorkouts.isNotEmpty) ...[
          //   Expanded(
          //     child: CustomScrollView(
          //       slivers: [
          //         SliverAppBar(
          //           pinned: true,
          //           flexibleSpace: FlexibleSpaceBar(
          //             title: Text(
          //               'Workout on ${(loggedWorkouts[currentIndex] as WorkoutDisplay).workout.startDate}',
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ),
          //         ),
          //         SliverList(
          //           delegate: SliverChildListDelegate([
          //             loggedWorkouts[currentIndex],
          //           ]),
          //         ),
          //       ],
          //     ),
          //   ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       IconButton(
          //         icon: Icon(Icons.arrow_back),
          //         onPressed: currentIndex > 0 ? goToPreviousWorkout : null,
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.arrow_forward),
          //         onPressed: currentIndex < loggedWorkouts.length - 1
          //             ? () => goToNextWorkout(loggedWorkouts)
          //             : null,
          //       ),
          //     ],
          //   ),
          // ] else ...[
          //   Center(
          //     child: Text(
          //       'No workouts logged yet',
          //       style: TextStyle(color: Colors.white, fontSize: 20),
          //     ),
          //   ),
          // ]
        ],
      ),
    );
  }
}
// () => _workoutModal(context, value[index])

Future<void> _deleteModal(BuildContext context, Workout workout) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete?', style: TextStyle(color: Colors.white)),
        content: Text('This action cannot be undone.',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm Delete'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
