import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';
import 'screens/notification_screen.dart';

class AppRouter {
  static final router = MaterialApp.router(
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/task':
          return MaterialPageRoute(builder: (_) => const TaskScreen());
        case '/notifications':
          return MaterialPageRoute(builder: (_) => const NotificationScreen());
        default:
          return MaterialPageRoute(builder: (_) => const HomeScreen());
      }
    },
  );
}
