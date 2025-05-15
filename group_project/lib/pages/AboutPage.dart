import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        setState(() {
          _nameController.text = data?['name'] ?? '';
          _ageController.text = data?['age']?.toString() ?? ''; // ✅ Safe null check
        });
      }
    }
  }


  Future<void> _saveNameAndAge() async {
    final age = int.tryParse(_ageController.text);
    if (age == null || age < 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be at least 16 to use the app.')),
      );
      return;
    }

    // Update name in FirebaseAuth (displayName)
    await user?.updateDisplayName(_nameController.text.trim());
    await user?.reload();

    // Update Firestore
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'name': _nameController.text.trim(),
      'age': age,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated')),
    );
    Navigator.pop(context); // Go back to HomePage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
        leading: BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Email Address'),
            SizedBox(height: 6),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: user?.email ?? '',
              ),
            ),
            SizedBox(height: 16),
            Text('Age'),
            SizedBox(height: 6),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveNameAndAge,
                child: Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
