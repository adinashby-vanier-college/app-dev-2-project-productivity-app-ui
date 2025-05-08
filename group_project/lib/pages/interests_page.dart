import 'package:flutter/material.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  final List<String> interests = [
    'Fitness',
    'Study',
    'Health',
    'Time Management',
    'Focus & Concentration',
    'Energy Management',
    'Clarity of Goals'
  ];

  final Set<String> selectedInterests = {};

  void toggleSelection(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: 0.5,
              color: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(height: 30),

            Text('Personalise your needs',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Choose your interests.',
                style: TextStyle(fontSize: 16, color: Colors.grey)),

            SizedBox(height: 30),

            // List of interest options
            Expanded(
              child: ListView(
                children: interests.map((interest) {
                  final bool isSelected = selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () => toggleSelection(interest),
                    child: Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.lightBlue.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            interest,
                            style: TextStyle(fontSize: 16),
                          ),
                          if (isSelected)
                            Icon(Icons.check, color: Colors.blue),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedInterests.isNotEmpty
                    ? () => Navigator.pushNamed(context, '/login')
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
