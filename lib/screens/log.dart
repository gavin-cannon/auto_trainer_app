import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:quiz_app/data/questions.dart';
// import 'package:quiz_app/questions_screen.dart';
// import 'package:quiz_app/start_screen.dart';
// import 'package:quiz_app/results_screen.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() {
    return _LogScreenState();
  }
}

class _LogScreenState extends State<LogScreen> {

  @override
  Widget build(context) {
   
    
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
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              
              children: [
                   const SizedBox(height: 80),
               
             
                const SingleChildScrollView(
                  child: Text('Workout History',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                  ),
                ),
                Divider(color: Colors.white,
                thickness: 1,
                indent: 5,
                endIndent: 5,
                ),
                const SizedBox(height: 30),
               
              ],
            ),
          ),
        );
  }
}
