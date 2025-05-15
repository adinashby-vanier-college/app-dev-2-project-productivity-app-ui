import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _agreed = false;

  Future<void> _registerUser() async {
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please accept Terms and Conditions')),
      );
      return;
    }

    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final user = userCredential.user;

      if (user != null) {
        // Send verification email
        await user.sendEmailVerification();

        // Save user info in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'createdAt': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Verification email sent! Please check your inbox before logging in.',
            ),
          ),
        );

        // Navigate back to login or verification screen (you choose)
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sign up", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Create an account to get started", style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),

            _buildTextField(_nameController, "Name", Icons.person),
            SizedBox(height: 16),
            _buildTextField(_emailController, "Email Address", Icons.email),
            SizedBox(height: 16),
            _buildTextField(_passwordController, "Create a password", Icons.lock, isPassword: true),
            SizedBox(height: 16),
            _buildTextField(_confirmController, "Confirm password", Icons.lock_outline, isPassword: true),
            SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (val) {
                    setState(() {
                      _agreed = val!;
                    });
                  },
                ),
                Expanded(
                  child: Wrap(
                    children: [
                      Text("I’ve read and agree with the "),
                      Text(
                        "Terms and Conditions",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(" and the "),
                      Text(
                        "Privacy Policy.",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
