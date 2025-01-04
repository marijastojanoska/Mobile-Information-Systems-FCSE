import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/exam_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'screens/calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'channel',
        channelName: 'notifications',
        channelDescription: 'test',
        ledColor: Colors.tealAccent,
        defaultColor: const Color(0xFF4caf50),
        importance: NotificationImportance.High,
      ),
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExamProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Exam Calendar',
        theme: ThemeData(
          primaryColor: const Color(0xFF4caf50),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
            bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.black87),
          ),
        ),
        home: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Calendar(),
        ),
      ),
    );
  }
}
