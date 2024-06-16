import 'package:auto_trainer/filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/questions_screen.dart';
// import 'package:quiz_app/start_screen.dart';
// import 'package:quiz_app/results_screen.dart';

class Generation extends StatefulWidget {
  const Generation({super.key});

  @override
  State<Generation> createState() {
    return _GenerationState();
  }
}

class _GenerationState extends State<Generation> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(context) {
    List<String> filters = [
      'Length',
      'Muscle Groups',
      'Goal',
      'Difficulty',
      'Type of Exercise'
    ];
    String selectedFilter = 'All';
    void onFilterSelected(String filter) {
      setState(() {
        selectedFilter = filter;
      });
      // Handle filter selection logic here
      print('Selected filter: $filter');
    }

    startQuiz() {
      print('hi');
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 1),
                Color.fromRGBO(0, 0, 0, 1),
                // Color.fromRGBO(255, 255, 255, 1),
                // Color.fromRGBO(255, 0, 0, 1),
                // Color.fromRGBO(0, 195, 255, 1),
                // Color.fromRGBO(0, 195, 255, 1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 50),
                FiltersBar(
                  filters: filters,
                  onFilterSelected: onFilterSelected,
                ),
                OutlinedButton.icon(
                  onPressed: startQuiz,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.fitness_center_outlined),
                  label: const Text('Generate Workout'),
                ),
                const SizedBox(height: 80),
                const SingleChildScrollView(
                  child: Text('This is where the workouts will go'),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  // Start of ElevatedButton widget
                  onPressed: () {
                    // Button action goes here
                  },
                  style: ElevatedButton.styleFrom(
                    // Start of style parameter
                    shape: CircleBorder(), // Shape property
                    padding: EdgeInsets.all(10), // Padding property
                  ),
                  child: Text(
                    'GO!',
                    style: GoogleFonts.protestRiot(
                      color: Color.fromARGB(255, 0, 191, 255),
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                // ClipOval(
                //   child:

                //   SizedBox(
                //     width: 80,
                //     height: 80,
                //     child: OutlinedButton.icon(
                //       onPressed: startQuiz,
                //       style: OutlinedButton.styleFrom(
                //         foregroundColor: Colors.white,
                //       ),
                //       // icon: const Icon(Icons.arrow_right_alt),
                //       label: Expanded(
                //         child: Text('GO!',
                //             style: GoogleFonts.protestRiot(
                //               color: Colors.white,
                //               fontSize: 30,
                //               fontWeight: FontWeight.bold,

                //             ),
                //             overflow: TextOverflow.visible,
                //             ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Generate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'Log',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Color.fromARGB(255, 1, 175, 255),
          backgroundColor: Colors.black,
          unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
