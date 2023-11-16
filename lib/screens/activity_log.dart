import 'package:flutter/material.dart';
import 'package:sample1/widgets/index.dart';

class ActivityLogScreen extends StatelessWidget {

  const ActivityLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // constraints: BoxConstraints.expand(
                //   height: Theme.of(context).textTheme.headlineMedium!.fontSize! + 10.0,
                // ),
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(127, 124, 102, 0), // Replace with your desired gradient colors
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0), // Add your desired padding
                          child: Text(
                            'Activity Log',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Expanded(
                child: ActivityLogList(),
              ),
            ],
          )
        )
    );

  }
}

