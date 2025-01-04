import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/exam.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';

class ExamProvider with ChangeNotifier {
  final List<Exam> _exams = [];
  final Map<String, bool> _notifiedExam = {};
  final LocationService _locationService = LocationService();
  final NotificationService _notificationService = NotificationService();
  ExamProvider() {
    _notificationService.initialize();
    _locationService.startListening(checkLocation);
  }

  List<Exam> get exams => [..._exams];

  List<Exam> fetchExam(DateTime date) {
    return _exams
        .where((exam) =>
    exam.dateTime.year == date.year &&
        exam.dateTime.month == date.month &&
        exam.dateTime.day == date.day)
        .toList();
  }

  void addExam(String title, DateTime dateTime, LatLng location, String locationName) {
    final newExam = Exam(
      id: DateTime.now().toString(),
      title: title,
      dateTime: dateTime,
      locationName: locationName,
      location: location,
    );
    _exams.add(newExam);
    _notifiedExam[newExam.id] = false;
    notifyListeners();
  }

  void checkLocation(Position position) async {
    for (var exam in _exams) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        exam.location.latitude,
        exam.location.longitude,
      );
      if (!_notifiedExam[exam.id]! && distance < 100 ) {
        await _notificationService.showNotification(
          "Reminder",
          "Exam for ${exam.title} less than 100 meters away",
        );
        _notifiedExam[exam.id] = true;
      }
    }
  }
}