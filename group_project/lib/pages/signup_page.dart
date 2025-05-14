import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String message = 'Connecting to Firebase...';
  String? documentId; // For delete

  @override
  void initState() {
    super.initState();
    _createTestDocument();
  }

  // 🔹 CREATE
  Future<void> _createTestDocument() async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('testSignup').add({
        'status': 'Signup page opened',
        'timestamp': Timestamp.now(),
      });
      setState(() {
        message = ' Document added.';
        documentId = docRef.id;
      });
      _readLastDocument();
    } catch (e) {
      setState(() {
        message = ' Firestore write failed.';
      });
    }
  }

  // 🔹 READ
  Future<void> _readLastDocument() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('testSignup')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        setState(() {
          message += '\n\n Last Document:\n${data['status']}';
        });
      }
    } catch (e) {
      setState(() {
        message += '\n Read failed.';
      });
    }
  }

  // 🔹 DELETE
  Future<void> _deleteTestDocument() async {
    if (documentId == null) return;

    try {
      await FirebaseFirestore.instance.collection('testSignup').doc(documentId).delete();
      setState(() {
        message += '\n Document deleted.';
      });
    } catch (e) {
      setState(() {
        message += '\n Delete failed.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signup Page Placeholder',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _deleteTestDocument,
                child: Text('Delete Last Document'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
