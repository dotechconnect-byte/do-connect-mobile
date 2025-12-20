import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Notifier for tab switching
  final ValueNotifier<Map<String, dynamic>?> tabSwitchNotifier = ValueNotifier(null);

  void switchToAttendanceTab(String date) {
    tabSwitchNotifier.value = {
      'tab': 3, // Attendance tab index
      'date': date,
    };
  }

  void clearTabSwitch() {
    tabSwitchNotifier.value = null;
  }
}
