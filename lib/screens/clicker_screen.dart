import 'package:clicker/components/autoclick_row.dart';
import 'package:clicker/components/click_row.dart';
import 'package:clicker/components/manager_row.dart';
import 'package:clicker/components/worker_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with TickerProviderStateMixin {
  late final AnimationController autoClickController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getAutoClickDuration(),
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController workerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getWorkerDuration(),
    vsync: this,
  );
  late final Animation<double> workerAnimation = CurvedAnimation(
    parent: workerController,
    curve: Curves.linear,
  );

  late final AnimationController managerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getManagerDuration(),
    vsync: this,
  );
  late final Animation<double> managerAnimation = CurvedAnimation(
    parent: managerController,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    super.dispose();
    autoClickController.dispose();
    workerController.dispose();
    managerController.dispose();
  }

  late Box<double> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(kClickerBrainBox);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ClickerBrain>(context)
        .initialAutoClickTimer(autoClickController);

    Provider.of<ClickerBrain>(context).initialWorkerTimer(workerController);

    Provider.of<ClickerBrain>(context).initialManagerTimer(managerController);

    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MoneyDisplay(),
          ),
          Consumer<ClickerBrain>(
            builder: (context, clickerBrain, child) {
              return ListView(
                shrinkWrap: true,
                children: [
                  ManagerRow(managerAnimation, managerController),
                  WorkerRow(workerAnimation, workerController),
                  AutoClickRow(autoClickAnimation, autoClickController),
                  ClickRow(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
