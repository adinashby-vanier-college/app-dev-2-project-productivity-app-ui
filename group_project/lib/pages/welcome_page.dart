import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image size
              Image.asset('assets/image/welcome.png', height: 270),

              // space between image and text
              SizedBox(height: 80),

              Text('Track your tasks easily', style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold)),

              SizedBox(height: 20),

              // 3. Customized button: 70% width, blue background, white text
              SizedBox(
                width: screenWidth * 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/interests');
                  },
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
