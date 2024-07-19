import 'package:auto_trainer/controllers/log_controller.dart';
import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Widget build(context) {
    final loggedWorkouts = ref.watch(logScreenControllerProvider);

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
      child: 
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

      //      PageView.builder(
      //       reverse: true,
      //   itemCount: loggedWorkouts.length,
      //   itemBuilder: (context, index) {
      //     return CustomScrollView(
      //       slivers: [
      //         SliverAppBar(
      //           pinned: true,
      //           flexibleSpace: FlexibleSpaceBar(
      //             title: Text('Workout on',
      //             style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         ),
      //         SliverList(
      //           delegate: SliverChildBuilderDelegate(
      //             (context, i) {
      //               return ListTile(
      //                 title: Text('loggedWorkouts[index].exercises[i].name'),
      //                 subtitle: Text('Sets: {loggedWorkouts[index].exercises[i].sets}, Reps: {loggedWorkouts[index].exercises[i].reps}'),
      //               );
      //             },
      //             childCount: 1,
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
