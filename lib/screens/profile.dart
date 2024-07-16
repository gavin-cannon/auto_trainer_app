import 'package:auto_trainer/widgets/achievements.dart';
import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(context) {
 
    return
       Scaffold(
        body: Container(
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
          child:  Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              
              children: [
                   const SizedBox(height: 40),
                    const Text('Gavin Cannon',
                    style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                    ),
                    Text('Become a Greek God'),
             
                
                const Row(
                  children: [
                  Text('Workouts Logged:'),
                  Text('Distance Covered:'),
                  Text('Total Sets:'),
                  Text('Total Reps:')
                  ]
                ),
                const Row(
                  children: [
                    Text('50 miles run'),
                    Text('50 workouts logged'),
                    Text('Consistency 1x week'),
                  ],
                ),
              Expanded(child: AchievementsBox()),
                 Expanded(
                   child: ListView(
                    children: [Text('This is where the ACHIEVEMENTS will go'),
                   
                    Text('50 miles run'),
                      Text('50 workouts logged'),
                      Text('Consistency 1x week'),
                    ],
                                   ),
                 ),
                 SizedBox(height: 30),
               
              ],
            ),
          ),
        ),
        
      );
  }
}
