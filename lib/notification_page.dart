import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart'; // Import the notification model

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String? isNotificationZero;

  // void _checkNotification(){
  //   if ()
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotificationModel>(
        builder: (context, notificationModel, child) {
          final notifications = notificationModel.notifications;

          // If there are no notifications, display a message
          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                'You have no notifications',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // Wrapping content in SingleChildScrollView
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  // Prevent independent scrolling
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap:
                      true, // Makes the ListView take only the needed height
                  itemCount: notificationModel.notifications.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: Text(notificationModel.notifications[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
