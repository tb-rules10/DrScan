import 'package:dr_scan/pages/AuthenticationScreen.dart';
import 'package:dr_scan/pages/BottomNavbar.dart';
import 'package:dr_scan/pages/HomeScreen.dart';
import 'package:dr_scan/pages/OnboardingScreen.dart';
import 'package:dr_scan/pages/SettingScreen.dart';
import 'package:flutter/material.dart';
import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BeKushal());
}

class BeKushal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        // initialRoute: HomeScreen.id,
        initialRoute: OnboardingScreen.id,
        // initialRoute: AuthenticationScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          AuthenticationScreen.id: (context) => AuthenticationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          BottomNavbar.id:(context) => BottomNavbar(),
        },
    );
  }
}