import 'package:flutter/material.dart';
import 'package:sample1/page/index.dart';
import 'package:sample1/widgets/index.dart';
import 'package:sample1/layout/index.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  img.Image? originalImage;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String imageUrl = 'https://th.bing.com/th/id/R.83b42c420685b7aedb2832765ff79e91?rik=LhOb%2fxuJ4hM50w&riu=http%3a%2f%2f3.bp.blogspot.com%2f-DwUTo6YzQw4%2fUYUVCIsOH8I%2fAAAAAAAABMI%2fDq5UnqIDUPY%2fs1600%2f24.%2bCorgi%2bPuppies.jpg&ehk=JngszHOzPLMToXKTfaSrE%2f0BV7xmaoJFTkK76jkBJ6M%3d&risl=&pid=ImgRaw&r=0';

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
            // Image.network(
            //   imageUrl,
            //   width: 28,
            //   height: 28,
            // ),
            // SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'Scan and analyze',dirIcon:''),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'Home Remedies',dirIcon:''),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0), // Gap between HomeBoxWidgets
              child: HomeBoxWidget(label: 'History',dirIcon:''),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Navigation()
    );
  }
}
