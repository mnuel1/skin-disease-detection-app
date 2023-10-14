import 'package:flutter/material.dart';
import 'package:sample1/page/index.dart';
import 'package:sample1/widgets/index.dart';
import 'package:sample1/layout/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final List<Widget> _pages = [
    const BlankPage(title: 'Home'),
    const BlankPage(title: 'Scan'),
    const BlankPage(title: 'Remedies'),
    const BlankPage(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   // title: Center(child: Image.asset('assets/image 9.png', height: 30, width: 30)), // Logo
      // ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
                child: HomeBoxWidget(label: 'Scan and analyze',dirIcon:'assets/image 8.png'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
                child: HomeBoxWidget(label: 'Home Remedies',dirIcon:'assets/homeremedies.jpg'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
                child: HomeBoxWidget(label: 'History',dirIcon:'assets/image7.jfif'),
              ),
            ],
          ),
      ),
        bottomNavigationBar: Navigation()
    );
  }
}
