import 'package:clicker/rows/autoclick_row.dart';
import 'package:clicker/rows/ceo_row.dart';
import 'package:clicker/rows/click_row.dart';
import 'package:clicker/rows/manager_row.dart';
import 'package:clicker/rows/worker_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/screens/clicker_screen.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';
import 'dart:async';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back! \n\nAre you ready to continue?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0),
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
  }
}
