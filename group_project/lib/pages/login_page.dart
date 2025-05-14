import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SizedBox(height: 30),
            Image.asset('assets/image/login.png', height: 250), // placeholder image
            SizedBox(height: 20),
            Text('Nice to See You!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),


              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot password?', style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // next page after login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  foregroundColor: Colors.white, // white text
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Not a member? ',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Register now',
                      style: TextStyle(color: Color(0xFF007BFF)), // blue color
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signup');
                        },
                    ),
                  ],
                ),
              ),
            )
            ,
            SizedBox(height: 20),
            Center(child: Text('Or continue with')),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red, // background color
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.g_mobiledata, size: 28, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(Icons.facebook, size: 36,color: Colors.blue),
                SizedBox(width: 20),
                Icon(Icons.apple, size: 36, color: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
