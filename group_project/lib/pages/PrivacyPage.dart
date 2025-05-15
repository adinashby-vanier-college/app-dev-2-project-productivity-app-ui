import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Me')),
      body: Center(child: Text('This app is designed to help you manage your time and build better habits. We respect your privacy and only collect the basic information needed to support your account and personalize your experience. Your data is securely stored and never shared with third parties.')),
    );
  }
}
