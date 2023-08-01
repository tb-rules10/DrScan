import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AuthenticationScreen.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = "OnboardingScreen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Color(0xff1c1c1c),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // Page 1
                  _buildOnboardingPage(
                    imagePath: 'assets/images/onboard1.png',
                    title: 'Scan Report',
                    description:
                    'Scan your report easily to get analyzed with our machine learning model',
                  ),
                  // Page 2
                  _buildOnboardingPage(
                    imagePath: 'assets/images/onboard2.png',
                    title: 'Analyze',
                    description:
                    'Analyze your report to get more insight with our dataset',
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentPage == 0) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  Navigator.pushNamed(context, AuthenticationScreen.id);
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(216, 47),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff0175FF),
                ),
              ),
              child: Text(
                _currentPage == 0 ? 'Next' : 'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Image.asset(
            imagePath,
            width: 340,
            height: 490,
          ),
        ),
        SizedBox(height: 23),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}