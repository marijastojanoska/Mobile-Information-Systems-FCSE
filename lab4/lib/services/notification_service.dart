import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  Future<void> initialize() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'channel',
          channelName: 'notifications',
          channelDescription: 'test',
          ledColor: Colors.white,
          defaultColor: const Color(0xFF4caf50),
          importance: NotificationImportance.High,
        )
      ],
    );
  }

  Future<void> showNotification(String title, String body) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'channel',
        title: title,
        body: body,
      ),
    );
  }
}