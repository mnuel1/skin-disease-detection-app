import 'package:flutter/material.dart';
import 'package:sample1/screens/index.dart';

class Navigation extends StatefulWidget {

  final Function(int) onItemTapped; // Callback to notify the parent

  const Navigation({Key? key, required this.onItemTapped}) : super(key: key);

  @override
  _Navigation createState() => _Navigation();
}

class _Navigation extends State<Navigation> {

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 10, // Spread radius
              blurRadius: 10, // Blur radius
              offset: const Offset(
                  0, -7), // Offset (0, -2) means shadow at the top
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.scanner),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.healing),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: '',
            // ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            widget.onItemTapped(index); // Notify the parent of item selection
          },
        ),
      );

  }
}
