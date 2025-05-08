import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/interests_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/interests': (context) => InterestsPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
