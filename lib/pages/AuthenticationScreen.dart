import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';

class AuthenticationScreen extends StatefulWidget {
  static String id = "AuthenticationScreen";

  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';

  // Valid user credentials
  String validEmail = "abhinav123@gmail.com";
  String validPassword = "abhinav123";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(0, height * 0.15, 0, height * 0.037),
                child: Center(
                  child: Text(
                    'DrScan',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Inter',
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: height * 0.12,
              ),
              _buildTextFieldWithLabelAndIcon(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email,
              ),
              SizedBox(height: height * 0.02),
              _buildTextFieldWithLabelAndIcon(
                label: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
              ),
              SizedBox(height: height * 0.045),
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.trim() == validEmail &&
                      _passwordController.text.trim() == validPassword) {
                    // Navigate to home screen
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("loggedIn", true);

                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid email or password")),
                    );
                  }
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(295, 56),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xff0175ff),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Inter',
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.170,
              ),
              const Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: ' Register',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(
                            0xff0175ff), // Set your desired color for "Register" text
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextFieldWithLabelAndIcon({
  required String label,
  required TextEditingController controller,
  required IconData icon,
}) {
  return Stack(
    children: [
      Container(
        height: 56,
        width: 295,
        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 10,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: controller.text.isEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(3, 5, 0, 5),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff827D7D),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
      Positioned(
        top: 18,
        right: 10,
        child: Icon(icon),
      ),
    ],
  );
}
