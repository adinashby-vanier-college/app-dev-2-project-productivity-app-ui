import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser; // Get current user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          SizedBox(height: 30),

          // Profile Picture and User Info
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 50),
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(user?.displayName ?? "Name not set", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(user?.email ?? "No email available", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Log out Button
          ElevatedButton(
            onPressed: () {
              _showLogoutDialog(context);
            },
            child: Text("Log Out"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // ✅ Correct
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  // Show a confirmation dialog before logging out
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Log out'),
        content: Text('Are you sure you want to log out? You\'ll need to login again to use the app.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Log out the user
              Navigator.of(context).pushReplacementNamed('/login'); // Navigate to Login page
            },
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
