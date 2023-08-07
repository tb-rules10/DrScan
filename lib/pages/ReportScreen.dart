import 'package:dr_scan/utils/Patient-Model.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  static String id = "ReportScreen";
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

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var _colorScheme = Theme.of(context).colorScheme;
    return Placeholder();
  }
}
