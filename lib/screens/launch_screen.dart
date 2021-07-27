import 'package:clicker/logic/constants.dart';
import 'package:flutter/material.dart';
import 'package:clicker/screens/clicker_screen.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'Welcome back! \n\nAre you ready to continue?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ClickerScreen()),
                (Route<dynamic> route) => false,
              ),
              style: ElevatedButton.styleFrom(primary: Colors.teal),
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  'Let\'s go!',
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
