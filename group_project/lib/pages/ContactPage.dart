
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContactUsPage extends StatefulWidget {
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final user = FirebaseAuth.instance.currentUser;
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _submitMessage() async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Message cannot be empty")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('messages').add({
      'email': user?.email ?? '',
      'phone': _phoneController.text.trim(),
      'message': _messageController.text.trim(),
      'timestamp': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Message submitted successfully")),
    );

    _messageController.clear();
    _phoneController.clear();
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not open $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email Address"),
            SizedBox(height: 6),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: user?.email ?? '',
              ),
            ),
            SizedBox(height: 16),

            Text("Phone Number"),
            SizedBox(height: 6),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "+1",
              ),
            ),
            SizedBox(height: 16),

            Text("Message"),
            SizedBox(height: 6),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitMessage,
                child: Text("SUBMIT"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Social Icons

      Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.xTwitter),
            iconSize: 30,
            onPressed: () => _openUrl('https://twitter.com'),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.apple),
            iconSize: 30,
            onPressed: () => _openUrl('https://www.apple.com'),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.facebook),
            iconSize: 30,
            onPressed: () => _openUrl('https://facebook.com'),
          ),
        ],
      )

      ],
        ),
      ),
    );
  }
}
