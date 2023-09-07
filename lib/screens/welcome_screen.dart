import 'package:flutter/material.dart';
import 'package:gosurvey/screens/question1_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to GoSurvey'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the satisfaction survey!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Question1Screen()),
                );
              },
              child: Text('Start Survey'),
            ),
          ],
        ),
      ),
    );
  }
}
