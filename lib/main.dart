import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/clicker_screen.dart';
import 'screens/test_screen.dart';
import 'screens/launch_screen.dart';

import 'package:clicker/logic/constants.dart';
import 'logic/clicker_brain.dart';
import 'package:clicker/logic/money_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/worker_logic.dart';
import 'package:clicker/logic/manager_logic.dart';
import 'package:clicker/logic/ceo_logic.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<double>(kClickerBrainBox);
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClickerBrain>(
      create: (_) => ClickerBrain(MoneyLogic(), ClickRowLogic(),
          AutoClickLogic(), WorkerLogic(), ManagerLogic(), CeoLogic()),
      child: MaterialApp(
        theme: ThemeData.dark(),
        title: kAppName,
        // initialRoute: Hive.box<double>(kClickerBrainBox)
        //             .get('money', defaultValue: 0.0) ==
        //         0.0
        //     ? kClickerScreenName
        //     : kLaunchScreenName,
        // initialRoute: kTestScreenName,
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
          kLaunchScreenName: (context) => LaunchScreen(),
        },
      ),
    );
  }
}
