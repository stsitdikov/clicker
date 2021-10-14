import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/clicker_screen.dart';
import 'screens/test_screen.dart';

import 'package:clicker/logic/constants.dart';
import 'logic/clicker_brain.dart';
import 'package:clicker/logic/number_abbreviations.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<double>(kClickerBrainBox);
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClickerBrain>(
      create: (_) => ClickerBrain(NumberAbbreviations()),
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: kAppName,
        initialRoute: kClickerScreenName,
        routes: {
          kClickerScreenName: (context) => ClickerScreen(
                Hive.box<double>(kClickerBrainBox).get(
                            'isLaunchFromGlobalUpgrade',
                            defaultValue: 0.0) ==
                        0.0
                    ? 0
                    : 1,
              ),
          kTestScreenName: (context) => TestScreen(),
        },
      ),
    );
  }
}
