// ignore_for_file: must_be_immutable

import 'package:dr_scan/constants/textStyles.dart';
import 'package:dr_scan/pages/HomeScreen.dart';
import 'package:dr_scan/pages/SettingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavbar extends StatefulWidget {
  static String id = "BottomNavbar";

  int? pageIndex;
  BottomNavbar({
    this.pageIndex,
  });
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _currentIndex;
  final List<Widget> _screens = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageIndex ?? 0;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    var _colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
            // return SlideTransition(
            //   position: Tween<Offset>(
            //     begin: const Offset(1, 0), // Slide from right
            //     end: Offset.zero,
            //   ).animate(animation),
            //   child: child,
            // );
          },
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: Hero(
        tag: "BottomNav",
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            selectedFontSize: 8,
            unselectedFontSize: 8,
            currentIndex: 0,
            selectedItemColor: _colorScheme.primary,
            unselectedItemColor: _colorScheme.tertiary,
            selectedLabelStyle: kBottomNavText,
            unselectedLabelStyle: kBottomNavText,
            iconSize: 30,
            elevation: 1.5,
            onTap: (int index) {
              if(index == 0 && _currentIndex !=0 && widget.pageIndex!= null) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}