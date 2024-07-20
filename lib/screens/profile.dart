import 'package:auto_trainer/controllers/profile_controller.dart';
import 'package:auto_trainer/widgets/achievements.dart';
import 'package:auto_trainer/widgets/filters_bar.dart';
import 'package:auto_trainer/widgets/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  // achievementsProvider = ref
  // challengeWorkoutsProvider = ref
  var stats;
  var achievements;
  @override
  bool get wantKeepAlive => true;
  @override
  initState() {
     stats = ref.read(statsProviderClassProvider.notifier).getStats();
     achievements = ref
        .read(achievementProviderClassProvider.notifier)
        .getAllAchievements();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    // TODO: implement didUpdateWidget
    stats = ref.read(statsProviderClassProvider.notifier).getStats();
    achievements = ref
        .read(achievementProviderClassProvider.notifier)
        .getAllAchievements();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    stats = ref.watch(statsProviderClassProvider);
    achievements = ref.watch(achievementProviderClassProvider);

    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('User Profile ',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      print('insdie onpressed');
                      stats = ref
                          .read(statsProviderClassProvider.notifier)
                          .getStats();
                    },
                  ),
                ],
              ),
              StatsWidget(stats: stats),
               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const Text('Achievements:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,),),
                   IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: () {
                          achievements = ref
                              .read(achievementProviderClassProvider.notifier)
                              .checkAchievements();
                        },
                      ),
                 ],
               ),
              Expanded(child: AchievementsBox(achievements: achievements)),
            ],
          ),
        ),
      ),
    );
  }
}
