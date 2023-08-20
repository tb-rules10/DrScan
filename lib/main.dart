import 'package:dr_scan/pages/AuthenticationScreen.dart';
import 'package:dr_scan/pages/PatientFormScreen.dart';
import 'package:dr_scan/pages/HomeScreen.dart';
import 'package:dr_scan/pages/OnboardingScreen.dart';
import 'package:dr_scan/pages/ReportScreen.dart';
import 'package:dr_scan/pages/SettingsScreen.dart';
import 'package:dr_scan/pages/ShowPatientsScreen.dart';
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
        // initialRoute: ReportScreen.id,
        initialRoute: HomeScreen.id,
        // initialRoute: OnboardingScreen.id,
        // initialRoute: AuthenticationScreen.id,
        // initialRoute: PatientFormScreen.id,
        // initialRoute: SettingsScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          AuthenticationScreen.id: (context) => AuthenticationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          PatientFormScreen.id: (context) => PatientFormScreen(),
          SettingsScreen.id:(context) => SettingsScreen(),
          ShowPatientsScreen.id: (context) => ShowPatientsScreen(),


        },
    );
  }
}