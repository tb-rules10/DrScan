// ignore_for_file: prefer_const_constructors

import 'package:dr_scan/pages/HomeScreen.dart';
import 'package:dr_scan/utils/Patient-Model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

class ReportScreen extends StatefulWidget {
  static String id = "ReportScreen";

  // const ReportScreen({super.key});
  final PatientData patientData;
  ReportScreen({
    super.key,
    required this.patientData,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("**************");
    widget.patientData.printInfo();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var _colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: Scaffold(
          // child: SingleChildScrollView(
            body: CustomScrollView(
              slivers: [
              SliverAppBar(
                // shadowColor: Colors.transpaRrent,
                // forceMaterialTransparency: true,
                // forceElevated: true,
                // elevation: -1,
                // foregroundColor: Colors.transparent,
                // backgroundColor: Colors.transparent,

               expandedHeight: 130,
                centerTitle: true,
                floating: false,
                pinned: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Report'),
                  centerTitle: true,
                ),

              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 4,color: Theme.of(context).colorScheme.primary,),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          // width: double.infinity,
                          height: height * 0.137,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                          child: Container(
                            // width: 319,
                            height: height * 0.173,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: const Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[800]!.withOpacity(0.5),
                                  spreadRadius: 1.5,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes the shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Image.asset('assets/images/people.png'),
                                  // child: Text('hello'),
                                ),
                                Stack(
                                  children: [
                                    Positioned(
                                      child: Text(
                                        widget.patientData.name,
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                        child: Text(
                                          widget.patientData.age.toString(),
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(35, 35, 0, 0),
                                        child: Text(
                                          widget.patientData.gender,
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 155,
                          height: 139,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87.withOpacity(0.5),
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                  blurRadius: 5)
                            ],
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                  child: Text(
                                    'GOLD',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 50,
                                left: 15,
                                child: Text(
                                  'GRADE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                top: 87,
                                left: 15,
                                child: ClipOval(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Theme.of(context).colorScheme.outline,
                                    child: Center(
                                      child: Text(
                                        widget.patientData.goldGrade.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 155,
                          height: 139,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87.withOpacity(0.5),
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                  blurRadius: 5)
                            ],
                          ),
                          child: Stack(
                            children: [
                              const Positioned(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(17, 17, 0, 0),
                                  child: Text(
                                    'MRC',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: 48,
                                left: 15,
                                child: Text(
                                  'GRADE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                top: 85,
                                left: 15,
                                child: ClipOval(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: Theme.of(context).colorScheme.outline,
                                    child: Center(
                                      child: Text(
                                        widget.patientData.mMRCgrade.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                      
                    // 2nd one
                    parsescreen("SMOKER", widget.patientData.smoker, "Smoke Free.png"),
                    const SizedBox(
                      height: 20,
                    ),
                      
                    Visibility(
                      visible: widget.patientData.smoker != "Non Smoker",
                      child: Column(
                        children: [
                          parsescreen(
                              "SMOKING METHOD", widget.patientData.smokerType, "Smoke Free.png"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                      
                    parsescreen("ALCOHOL", widget.patientData.alcoholConsumer, "wine.png"),
                    const SizedBox(
                      height: 20,
                    ),
                      
                    parsescreen("MUCUS", widget.patientData.hasExpectoration, "mucus.png"),
                    const SizedBox(
                      height: 20,
                    ),
                      
                    parsescreen(
                        "BREATHSHORTNESS", widget.patientData.hasBreathShortness, "breathless.png"),
                    const SizedBox(
                      height: 20,
                    ),
                      
                    parsescreen("DIABETES", widget.patientData.hasDiabetes, "diabetes.png"),
                    SizedBox(height: 20,),
                      
                    // parsescreen("MUCUS", "YES"),
                  ],
                ),
              ),],
            ),
          // ),
        ),
      );
    // );
  }

  Container parsescreen(String headText, String value, String image) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          border: Border.all(color: const Color(0xff1c1c1c), width: 1.5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/$image'),
                SizedBox(width: 20,),
                Text(
                  headText,
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
