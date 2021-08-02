import 'package:flutter/material.dart';
import 'package:clicker/logic/constants.dart';

class AboutTheApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Hello and welcome to $kAppName! \n\nThis is my first app, a simple incremental clicker I\'ve developed on my free time. \n\nThere are no ads and no purchases. \n\nI hope you have fun with the game! \n\nBest wishes, \nStanislav',
          textAlign: TextAlign.center,
          style: kInfoTextStyle,
        ),
      ),
    );
  }
}
