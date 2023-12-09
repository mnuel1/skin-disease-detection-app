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
            width: 2.0,         // Border width
          ),
          borderRadius: BorderRadius.circular(15.0), // Border radius
        ),
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 100.0,
        ),
        padding: const EdgeInsets.all(5.0),

        alignment: Alignment.center,
        child: Text(label),


    );
  }
}