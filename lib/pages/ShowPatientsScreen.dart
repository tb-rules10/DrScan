import 'package:flutter/material.dart';

class ShowPatientsScreen extends StatefulWidget {
  static String id = "ShowPatientsScreen";

  @override
  State<ShowPatientsScreen> createState() => _ShowPatientsScreenState();
}

class _ShowPatientsScreenState extends State<ShowPatientsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            centerTitle: true,
            floating: true,
            pinned: true,
            leading: GestureDetector(
              onTap: () =>  Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32,
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Patient Records'),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Center(
                child: Text(
                    "Future Scope",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                ),
              ),
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
