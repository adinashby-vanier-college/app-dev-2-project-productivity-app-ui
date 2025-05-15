import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/interests_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/HomePage.dart';
import 'pages/AboutPage.dart';
import 'pages/NotificationsPage.dart';
import 'pages/ContactPage.dart';
import 'pages/PrivacyPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/notifications': (context) => NotificationsPage(),
        '/contact': (context) => ContactPage(),
        '/privacy': (context) => PrivacyPage(),
      },
    );
  }
}
