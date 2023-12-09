import 'package:flutter/material.dart';
import 'package:sample1/screens/index.dart';
import 'package:sample1/layout/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _currentPageIndex = 0; // Variable to track the selected page index

  // List of pages to display
  final List<Widget> _pages = [
    ScanScreen(),
    RemediesScreen(),
    // const ActivityLogScreen(),

  ];

  // Function to handle item selection in the bottom navigation bar
  void _onNavigationItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex], // Display the selected page
      bottomNavigationBar: Navigation(onItemTapped: _onNavigationItemTapped),
    );
  }
}
