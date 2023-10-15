import 'package:flutter/material.dart';

class ActivityLog {
  final String message;
  final DateTime timestamp;

  ActivityLog(this.message, this.timestamp);
}

class ActivityLogList extends StatelessWidget {
  final List<ActivityLog> logs = [
    ActivityLog('Logged in', DateTime.now()),
    ActivityLog('Performed action A', DateTime.now()),
    ActivityLog('Performed action B', DateTime(2023, 1, 15)), // Adding a log with a past date
    // Add more log entries as needed
  ];

  ActivityLogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        final bool isNewDate = index == 0 ||
            log.timestamp.day != logs[index - 1].timestamp.day ||
            log.timestamp.month != logs[index - 1].timestamp.month ||
            log.timestamp.year != logs[index - 1].timestamp.year;

        return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isNewDate)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'asdad', // You can change this to your actual message
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                      ),
                      color: isNewDate ? Colors.yellow : Colors.transparent,
                    ),
                    child: ListTile(
                      title: Text(log.message),
                      subtitle: Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            log.timestamp.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        );
      },
    );
  }
}

