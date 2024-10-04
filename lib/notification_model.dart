import 'package:flutter/material.dart';

class NotificationModel with ChangeNotifier {
  final List<String> _notifications = [];

  List<String> get notifications => _notifications;

  void addNotification(String notification) {
    _notifications.insert(
        0, notification); // Add the latest notification to the top
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
