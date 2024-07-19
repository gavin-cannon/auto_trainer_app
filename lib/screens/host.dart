import 'package:auto_trainer/screens/challenge.dart';
import 'package:auto_trainer/screens/generation.dart';
import 'package:auto_trainer/screens/log.dart';
import 'package:auto_trainer/screens/profile.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HostScreenState();
  }
}

class _HostScreenState extends State<HostScreen> {
  int _selectedPageIndex = 0;
  final PageController _pageController = PageController();

  void _selectPage(int index) {
    setState(() {
      print('hello');
      print(index);
      _selectedPageIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // Widget activePage = const Generation();

    // if (_selectedPageIndex == 1) {
    //   activePage = const LogScreen();
    // }
    // if (_selectedPageIndex == 2) {
    //   activePage = const ChallengeScreen();
    // }
    // if (_selectedPageIndex == 3) {
    //   activePage = const ProfileScreen();
    // }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        children: 
          const <Widget>[
            Generation(),
            LogScreen(),
            ChallengeScreen(),
            ProfileScreen(),
          ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.local_fire_department),
            label: 'Challenges',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Color.fromARGB(255, 1, 175, 255),
        backgroundColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
