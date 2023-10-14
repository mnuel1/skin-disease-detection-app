import 'package:flutter/material.dart';




class HomeBoxWidget extends StatelessWidget{

  final String label;
  final String dirIcon;

  const HomeBoxWidget({super.key, required this.label,required this.dirIcon});

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue, // Border color
            width: 2.0,         // Border width
          ),
          borderRadius: BorderRadius.circular(15.0), // Border radius
        ),
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 100.0,
        ),
        padding: const EdgeInsets.all(5.0),

        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              child: Image.asset(dirIcon,height: 30, width: 30),
            ),
            Container(decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue, // Border color
                width: 2.0,         // Border width
              ),
            ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(label),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        // Add your button's action here
                      },
                    )
                  ),
                ],
              ),
            )
          ],
        )

    );
  }
}