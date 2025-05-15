import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy & Security')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Image
            Image.asset(
              'assets/image/welcome.png',
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            // Text box with background
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFBBDEFB), // Light blue background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'This app is designed to help you manage your time and build better habits. '
                    'We respect your privacy and only collect the basic information needed to support your account and personalize your experience. '
                    'Your data is securely stored and never shared with third parties.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
