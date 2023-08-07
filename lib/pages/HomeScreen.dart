import 'package:dio/dio.dart';
import 'package:dr_scan/pages/PatientFormScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import '../components/homeScreenButtons.dart';
import '../constants/textStyles.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  Future<void> downloadFile(BuildContext context) async {
    print("Sending  download request");
    final url = 'http://10.0.2.2:5000/api/fetchData';
    final dir = await getExternalStorageDirectory();
    final savePath = dir!.path + '/patient_data.xlsx';
    print(savePath);
    final dio = Dio();
    try {
      await dio.download(url, savePath);
      print('File downloaded successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File downloaded successfully at - ${savePath}')),
      );

      // Open the downloaded file
      OpenFile.open(savePath);
    } catch (e) {
      print('Download error: $e');
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg"),
                  ),

                  Image.asset(
                    "assets/images/button-removebg-preview.png",
                    height: 45,
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: 3,
                    width: width,
                  ),
                  Text(
                    "Doctor Abhinav",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 30
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              buildBlackButton(context, _colorScheme),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WhiteButton(
                    height: height, width: width,
                    heading: "See your Result",
                    subHeading: "Lorem iipsem somethin text",
                    onTap: (){

                    },
                  ),
                  WhiteButton(
                    height: height, width: width,
                    heading: "Data Information",
                    subHeading: "Download the recorded patient data",
                    onTap: () {
                      downloadFile(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "BottomNav",
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            selectedFontSize: 8,
            unselectedFontSize: 8,
            currentIndex: 0,
            selectedItemColor: _colorScheme.tertiary,
            unselectedItemColor: _colorScheme.primary,
            selectedLabelStyle: kBottomNavText,
            unselectedLabelStyle: kBottomNavText,
            iconSize: 30,
            elevation: 1.5,
            onTap: (int index) {

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
    );
  }

  GestureDetector buildBlackButton(BuildContext context, ColorScheme _colorScheme) {
    return GestureDetector(
              onTap: () => Navigator.pushNamed(context, PatientFormScreen.id),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: _colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "COPD Scan",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 21,
                                  color: Colors.white,
                              ),
                            ),
                            Text(
                              "Digitalize your medical records with a single tap this is sample text.",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                          "assets/images/homepagecard.png",
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

}
