import 'package:auto_trainer/controllers/log_controller.dart';
import 'package:auto_trainer/data/models/workout.dart';
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
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(context) {
    CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
    final loggedWorkouts = ref.watch(logScreenControllerProvider);
    int currentIndex = 0;
    void goToNextWorkout(List<Widget> loggedWorkouts) {
      setState(() {
        if (currentIndex < loggedWorkouts.length - 1) {
          currentIndex++;
        }
      });
    }

    void goToPreviousWorkout() {
      setState(() {
        if (currentIndex > 0) {
          currentIndex--;
        }
      });
    }

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
        children: [ TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
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
          ElevatedButton(
            // Start of ElevatedButton widget
            onPressed: () {
              // Button action goes here
              // generationController.createWorkoutDisplay();
              ref
                  .read(logScreenControllerProvider.notifier)
                  .createWorkoutLogDisplay();
              print('hello');
            },
            style: ElevatedButton.styleFrom(
              // Start of style parameter
              splashFactory: NoSplash.splashFactory,
              shape: CircleBorder(), // Shape property
              padding: EdgeInsets.all(10), // Padding property
            ),
            child: Text(
              'go',
              style: GoogleFonts.protestRiot(
                color: Color.fromARGB(255, 0, 191, 255),
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
          if (loggedWorkouts.isNotEmpty) ...[
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Workout on ${(loggedWorkouts[currentIndex] as WorkoutDisplay).workout.startDate}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      loggedWorkouts[currentIndex],
                    ]),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: currentIndex > 0 ? goToPreviousWorkout : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: currentIndex < loggedWorkouts.length - 1
                      ? () => goToNextWorkout(loggedWorkouts)
                      : null,
                ),
              ],
            ),
          ] else ...[
            Center(
              child: Text(
                'No workouts logged yet',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
