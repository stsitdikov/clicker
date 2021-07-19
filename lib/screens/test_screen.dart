import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';
import 'package:clicker/screens/clicker_screen.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ClickerScreen()),
      );
    });
    return Container(
      color: Colors.white,
    );
  }
}
