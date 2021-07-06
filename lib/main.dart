import 'package:clicker/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'screens/clicker_page.dart';
import 'package:provider/provider.dart';
import 'logic/clicker_brain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClickerBrain>(
      create: (_) => ClickerBrain(),
      child: MaterialApp(
        // theme: ThemeData.dark(),
        home: TestScreen(),
      ),
    );
  }
}
