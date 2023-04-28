import 'package:flutter/material.dart';
import 'package:habitat/screens/main/main_screen.dart';
import 'package:habitat/screens/report_screen.dart';
import 'package:habitat/screens/reward/reward_screen.dart';
import 'package:habitat/screens/settingscreen/setting_screen.dart';
import 'package:habitat/screens/social_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: "habit@",
      theme: ThemeData(
        fontFamily: "SeoulNamsan",
        primaryColor: const Color(0xFF78C6F7),
        scaffoldBackgroundColor: const Color(0xFFA1EF7A),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/report': (context) => const ReportScreen(),
        '/reward': (context) => const RewardScreen(),
        '/social': (context) => const SocialScreen(),
        '/setting': (context) => const SettingScreen(),
      },
    ),
  );
}
