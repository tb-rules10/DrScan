import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dr_scan/constants/constants.dart';
import 'package:dr_scan/utils/Patient-Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants/textStyles.dart';
import 'ReportScreen.dart';

class PatientFormScreen extends StatefulWidget {
  static String id = "FormScreen";
  const PatientFormScreen({Key? key}) : super(key: key);

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  static late PatientData patientData;
  DateTime? currentBackPressTime;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final _step1Key = GlobalKey<FormState>();
  final _step4Key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkStep1 = false;
  bool checkStep2 = false;
  bool checkStep3 = false;
  bool checkStep4 = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _fev1Controller = TextEditingController();
  TextEditingController _fev1_fvcCntroller = TextEditingController();
  static int _genderIndex = 2;
  static int _smokerIndex = -1;
  static int _alcoholIndex = -1;
  static int _smokerTypeIndex = -1;
  static int _expectorationIndex = -1;
  static int _breathShortnessIndex = -1;
  static int _diabetesIndex = -1;
  static int _mMRCIndex = -1;
  static late String _gender = "Other";
  static late String _smoker = "Non Smoker";
  static late String _smokerType = "NONE";
  static late String _alcoholConsumer;
  static late String _hasExpectoration;
  static late String _hasDiabetes;
  static late String _hasBreathShortness;
  static late String _mMRCgrade;
  List<int> catValues = List<int>.filled(8, -1);
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _smokingOptions = ['Passive Smoker', 'Current Smoker', 'Non Smoker', 'Ex Smoker'];
  final List<String> _smokingPreference = ['Cigarette', 'Bidi', 'Ganja', 'Biomass Fuel'];
  final List<String> _mMRCgrading = ['Get breathless with strenuous exercise', 'Breath shortness when hurrying or walking up a slight hill', 'Walk slower than people of your age because of breathlessness', 'Stop for breath after walking about 100 yards or after a few minutes on level ground', 'Too breathless to leave the house or breathless while dressing/undressing'];
  final List<String> catOptions = [
    "I never cough",
    "I have no phlegm in my chest at all",
    "My chest does not feel tight at all",
    "When I walk up a hill or one flight of stairs I am not breathless",
    "I am not limited doing any activities at home",
    "I am confident leaving my home despite my lung condition",
    "I sleep soundly",
    "I have lots of energy",
  ];

  void onCatValueChanged(int catIndex, int value) {
    setState(() {
      catValues[catIndex] = value;
    });
  }
  void checkStep1Complete(){
    setState(() => checkStep1 = _step1Key.currentState!.validate());
  }
  void checkStep2Complete(){
    checkStep2 = (_smokerIndex != -1 &&
        _alcoholIndex != -1 &&
        (_smokerIndex == 2) ? true : _smokerTypeIndex != -1 &&
        _expectorationIndex != -1 &&
        _diabetesIndex != -1 &&
        _breathShortnessIndex != -1 &&
        _mMRCIndex != -1);
    setState(() => checkStep2);
    check(checkStep2);
  }
  void checkStep3Complete(){
    setState(() {
      checkStep3 = !catValues.contains(-1);
    });
    check(checkStep3);
  }
  void checkStep4Complete(){
    setState(() => checkStep4 = _step4Key.currentState!.validate());
  }
  void check(bool checkStep) {
    if(!checkStep) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Answer all the Questions"))
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }
  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    int age = int.tryParse(value) ?? 0;
    if (age <= 0 || age > 150) {
      return 'Enter a valid age between 1 and 150';
    }
    return null;
  }
  String? validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Height is required';
    }
    double height = double.tryParse(value) ?? 0.0;
    if (height <= 0 || height > 300) {
      return 'Enter a valid height between 1 and 300';
    }
    return null;
  }
  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }
    double weight = double.tryParse(value) ?? 0.0;
    if (weight <= 0 || weight > 500) {
      return 'Enter a valid weight between 1 and 500';
    }
    return null;
  }
  String? validateFEV1PreBD(String? value) {
    if (value == null || value.isEmpty) {
      return 'FEV1 PRE-BD is required';
    }
    double fev1PreBD = double.tryParse(value) ?? 0.0;
    if (fev1PreBD <= 0 || fev1PreBD > 100) {
      return 'Enter a valid value between 1 and 100';
    }

    return null;
  }
  String? validateFEV1_FVCPostBD(String? value) {
    if (value == null || value.isEmpty) {
      return 'FEV1/FVC POST-BD is required';
    }
    double fev1FVCPostBD = double.tryParse(value) ?? 0.0;
    if (fev1FVCPostBD <= 0) {
      return 'Enter a valid value greater than 0';
    }
    return null;
  }

  onStepContinue() async {
    switch(_currentStep){
      case 0:
        checkStep1Complete();
        if(checkStep1) {
          setState(() => _currentStep += 1);
        }
        break;
      case 1:
        checkStep2Complete();
        if(checkStep2) {
          setState(() => _currentStep += 1);
        }
        break;
      case 2:
        checkStep3Complete();
        if(checkStep3) {
          setState(() => _currentStep += 1);
        }
        break;
      case 3:
        checkStep4Complete();
        if(checkStep4) {
          checkStep3Complete();
          checkStep2Complete();
          checkStep1Complete();
          if(!checkStep3){
            setState(() => _currentStep = 2);
          }
          else if(!checkStep2){
            setState(() => _currentStep = 1);
          }
          else if(!checkStep1){
            setState(() => _currentStep = 0);
          }
          else{
            print("Form Completed");
            FocusScope.of(context).unfocus();
            await handleFormSubmit();
            patientData.printInfo();
            // Push to next page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ReportScreen(
                patientData: patientData,
              )),
            );
          }
        }
        break;
    }
  }
  onStepTapped(int step){
    setState(() => _currentStep = step);
  }
  onStepCancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  Future<void> handleFormSubmit()async {
    setState(() {
      patientData = PatientData(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        gender: _gender,
        smoker: _smoker,
        smokerType: _smoker == "Non Smoker" ? "NONE" : _smokerType,
        alcoholConsumer: _alcoholConsumer,
        hasExpectoration: _hasExpectoration,
        hasBreathShortness: _hasBreathShortness,
        hasDiabetes: _hasDiabetes,
        mMRCgrade: int. parse(_mMRCgrade),
        catValues: catValues,
        fev1PreBD: double.parse(_fev1Controller.text),
        fev1FVCPostBD: double.parse(_fev1_fvcCntroller.text),
      );
    });
    await sendPatientData("copdPrediction");
  }
  Future<void> sendPatientData(String urlPostfix) async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/$urlPostfix');
      var jsonData = patientData.toJson();
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(jsonData)
      ).timeout(const Duration(seconds: 10));
      Map<String, dynamic> temp = await json.decode(response.body);
      setState(() {
        patientData.goldGrade = temp['data']['Gold Grade'];
      });
      // print(temp);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("ERROR - $e"))
      );
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Double tap to exit, your progress will be lost."),)
      );
      return Future.value(false);
    }
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 130,
                centerTitle: true,
                floating: true,
                pinned: true,
                leading: GestureDetector(
                  onTap: () =>  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Double tap to exit, your progress will be lost."),)
                  ),
                  onDoubleTap: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    Navigator.pop(context);
                    },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Patient Registration Form'),
                  centerTitle: true,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
                      children: [
                        Stepper(
                          type: stepperType,
                          physics: ScrollPhysics(),
                          currentStep: _currentStep,
                          onStepTapped: (step) => onStepTapped(step),
                          onStepContinue:  onStepContinue,
                          onStepCancel: onStepCancel,
                          controlsBuilder: (BuildContext context, ControlsDetails details) {
                            // return SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: onStepContinue,
                                    child: Text(_currentStep < 3 ? "NEXT" : "SUBMIT"),
                                  ),
                                  SizedBox(width: 10.0,),
                                  TextButton(
                                    onPressed: onStepCancel,
                                    child: const Text(
                                      "PREVIOUS",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          steps: <Step>[
                            Step(
                              title: Text(
                                "Patient Details",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: (_currentStep == 0) ? null : Colors.grey,
                                ),
                              ),

                              content: Form(
                                key: _step1Key,
                                child: Column(
                                  children: <Widget>[
                                    buildTextFormField(
                                      _nameController, 'Name',
                                      validator: validateName,
                                    ),
                                    buildTextFormField(
                                        _ageController, 'Age',
                                        validator: validateAge,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                                        ]),
                                    buildTextFormField(
                                      _heightController, 'Height (cm)',
                                      validator: validateHeight,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                      ],),
                                    buildTextFormField(
                                      _weightController, 'Weight (kg)',
                                      validator: validateWeight,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                      ],),
                                    SizedBox(height: 20,),
                                    buildToggleButton(
                                        context,
                                        _genderIndex,
                                        "Gender",
                                        _genderOptions,
                                            (index){
                                          setState(() {
                                            _genderIndex = index!;
                                            _gender = _genderOptions[_genderIndex];
                                          });
                                        }
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: checkStep1 ? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: Text(
                                "Symptoms",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: (_currentStep == 1) ? null : Colors.grey,
                                ),
                              ),
                              content: Column(
                                children: <Widget>[
                                  buildToggleButton(
                                      context,
                                      _smokerIndex,
                                      "Type of Smoker",
                                      // "Do you smoke?",
                                      _smokingOptions,
                                          (index){
                                        setState(() {
                                          _smokerIndex = index!;
                                          _smoker = _smokingOptions[_smokerIndex];
                                        });
                                      },
                                      toggleSwitches: 4,
                                      height: 50
                                  ),
                                  Visibility(
                                    visible: (_smoker != "Non Smoker" && _smokerIndex!=-1),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        buildToggleButton(
                                            context,
                                            _smokerTypeIndex,
                                            "Preferred Smoking Method",
                                            // "Type of Smoking",
                                            _smokingPreference,
                                                (index){
                                              setState(() {
                                                _smokerTypeIndex = index!;
                                                _smokerType = _smokingPreference[_smokerTypeIndex];
                                              });
                                            },
                                          toggleSwitches: 4,
                                          height: 50
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  buildToggleButton(
                                      context,
                                      _alcoholIndex,
                                      // "Do you consume alcohol?",
                                      "Alcohol Consumer",
                                      ["Yes", "No"],
                                          (index){
                                        setState(() {
                                          _alcoholIndex = index!;
                                          _alcoholConsumer = ["Yes", "No"][_alcoholIndex];
                                        });
                                      },
                                      toggleSwitches: 2
                                  ),
                                  SizedBox(height: 20,),
                                  buildToggleButton(
                                      context,
                                      _expectorationIndex,
                                      "Expectoration (Coughing and spitting out mucus)",
                                      // "Do you have any expectoration?",
                                      ["Yes", "No"],
                                          (index){
                                        setState(() {
                                          _expectorationIndex = index!;
                                          _hasExpectoration = ["Yes", "No"][_expectorationIndex];
                                        });
                                      },
                                      toggleSwitches: 2
                                  ),
                                  SizedBox(height: 20,),
                                  buildToggleButton(
                                      context,
                                      _breathShortnessIndex,
                                      "Shortness of Breath",
                                      // "Do you have any expectoration?",
                                      ["Yes", "No"],
                                          (index){
                                        setState(() {
                                          _breathShortnessIndex = index!;
                                          _hasBreathShortness = ["Yes", "No"][_breathShortnessIndex];
                                        });
                                      },
                                      toggleSwitches: 2
                                  ),
                                  SizedBox(height: 20,),
                                  buildToggleButton(
                                      context,
                                      _diabetesIndex,
                                      "Diabetic",
                                      // "Do you have any expectoration?",
                                      ["Yes", "No"],
                                          (index){
                                        setState(() {
                                          _diabetesIndex = index!;
                                          _hasDiabetes = ["Yes", "No"][_diabetesIndex];
                                        });
                                      },
                                      toggleSwitches: 2
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "mMRC Grade\n(Choose any one option from below)",
                                        style: GoogleFonts.inter(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("mMRC Grading Information", style: TextStyle(fontWeight: FontWeight.bold),),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      for (int i = 0; i < _mMRCgrading.length; i++)
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 3.0,),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.circle,
                                                                    color: Colors.black54,
                                                                    size: 10,
                                                                  ),
                                                                  SizedBox(width: 5,),
                                                                  Text(
                                                                    "mMRC Grade $i",
                                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 8), // Add some space between subheading and info
                                                            Text(_mMRCgrading[i]),
                                                            SizedBox(height: 16), // Add space between each grade
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context); // Close the dialog
                                                      },
                                                      child: Text("OK"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Icon(
                                          Icons.info,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: ToggleSwitch(
                                      initialLabelIndex: _mMRCIndex,
                                      totalSwitches: 5,
                                      minWidth: 1e8,
                                      minHeight: 40,
                                      inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
                                      borderColor: [Color(0xff212121)],
                                      dividerColor: Color(0xff212121),
                                      borderWidth: 1.0,
                                      multiLineText: true,
                                      labels: const ["0", "1", "2", "3", "4"],
                                      onToggle: (index){
                                        setState(() {
                                          _mMRCIndex = index!;
                                          _mMRCgrade = ["0", "1", "2", "3", "4"][index];
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: checkStep2? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: Text(
                                "CAT Assessment",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: (_currentStep == 1) ? null : Colors.grey,
                                ),
                              ),
                              content: Column(
                                children: <Widget>[
                                  for (int catIndex = 0; catIndex < 8; catIndex++)
                                    Padding(
                                      padding: (catIndex == 7) ? EdgeInsets.only(bottom: 5.0) : EdgeInsets.only(bottom: 20.0),
                                      child: buildToggleButton(
                                        context,
                                        catValues[catIndex],
                                        catOptions[catIndex],
                                        ["0", "1", "2", "3", "4", "5"],
                                            (index) {
                                          onCatValueChanged(catIndex, index!);
                                        },
                                        toggleSwitches: 6,
                                        height: 50,
                                      ),
                                    ),

                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: checkStep3? StepState.complete : StepState.indexed,
                            ),
                            Step(
                              title: Text(
                                "Report Info",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  color: (_currentStep == 2) ? null : Colors.grey,
                                ),
                              ),
                              content: Form(
                                key: _step4Key,
                                child: Column(
                                  children: <Widget>[
                                    buildTextFormField(
                                      _fev1Controller, 'FEV1 PRE-BD (%PRED)',
                                      validator: validateFEV1PreBD,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                      ],),
                                    buildTextFormField(
                                      _fev1_fvcCntroller, 'FEV1/FVC POST-BD (L/SEC)',
                                      validator: validateFEV1_FVCPostBD,
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                                      ],),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                              isActive:_currentStep >= 0,
                              state: checkStep4 ? StepState.complete : StepState.indexed,
                            ),
                          ],
                        ),
                        SizedBox(height: 150,)
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildToggleButton(BuildContext context, int initialLabelIndex, String buttonLabel, List<String> toggleOptions, void Function(int?)? onChanged, {int? toggleSwitches, double? height}) {
    return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buttonLabel,
                              style: GoogleFonts.inter(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 15,),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: ToggleSwitch(
                                initialLabelIndex: initialLabelIndex,
                                totalSwitches: toggleSwitches ?? 3,
                                minWidth: 1e8,
                                minHeight: height ?? 40,
                                inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
                                borderColor: [Color(0xff212121)],
                                dividerColor: Color(0xff212121),
                                borderWidth: 1.0,
                                multiLineText: true,
                                centerText: true,
                                labels: toggleOptions,
                                onToggle: onChanged,
                              ),
                            ),
                          ],
                        );
  }

  Widget buildTextFormField(TextEditingController myController, String label, {TextInputType? keyboardType, List<TextInputFormatter>? inputFormatters, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: TextFormField(
        controller: myController,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )
        ),
      ),
    );
  }
}


