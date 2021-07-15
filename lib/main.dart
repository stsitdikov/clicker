import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/manager_logic.dart';
import 'package:clicker/logic/money_logic.dart';
import 'package:clicker/logic/worker_logic.dart';
import 'package:flutter/material.dart';
import 'screens/clicker_screen.dart';
import 'package:provider/provider.dart';
import 'logic/clicker_brain.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/test_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<double>(kClickerBrainBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClickerBrain>(
      create: (_) => ClickerBrain(MoneyLogic(), ClickRowLogic(),
          AutoClickLogic(), WorkerLogic(), ManagerLogic()),
      child: MaterialApp(
        // theme: ThemeData.dark(),
        home: TestScreen(),
      ),
    );
  }
}
