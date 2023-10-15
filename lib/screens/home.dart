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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: Image.asset('assets/image 9.png', height: 100, width: 225)), // Logo
      //   backgroundColor: Colors.transparent,
      //   // height:200,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: Image.asset('assets/image 9.png', height: 100, width: 225),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'Scan and analyze',dirIcon:'assets/image 8.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'Home Remedies',dirIcon:'assets/homeremedies.jpg'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'History',dirIcon:'assets/image7.jfif'),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Navigation()
    );
  }
}
