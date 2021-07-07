import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with TickerProviderStateMixin {
  late final AnimationController autoClickController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).autoClickerDuration,
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController workerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).workerDuration,
    vsync: this,
  );
  late final Animation<double> workerAnimation = CurvedAnimation(
    parent: workerController,
    curve: Curves.linear,
  );

  late final AnimationController managerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).managerDuration,
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

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ClickerBrain>(context).autoClickAnimation == true) {
      autoClickController.repeat();
    }

    if (Provider.of<ClickerBrain>(context).workerAnimation == true) {
      workerController.repeat();
    }

    if (Provider.of<ClickerBrain>(context).managerAnimation == true) {
      managerController.repeat();
    }

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
                  // manager

                  Visibility(
                    visible: clickerBrain.isManagerVisible(),
                    child: ReusableProgressRow(
                      animation: managerAnimation,
                      title:
                          '${NumberFormat.compact().format(clickerBrain.managerNumber)}  x  Manager',
                      onUpgradeTap: () {
                        Provider.of<ClickerBrain>(context, listen: false)
                            .buyManager();
                      },
                      upgradeCost: NumberFormat.compact()
                          .format(clickerBrain.managerCost),
                    ),
                  ),

                  // worker

                  Visibility(
                    visible: clickerBrain.isWorkerVisible(),
                    child: ReusableProgressRow(
                      animation: workerAnimation,
                      title:
                          '${NumberFormat.compact().format(clickerBrain.workerNumber)}  x  Worker',
                      onUpgradeTap: () {
                        Provider.of<ClickerBrain>(context, listen: false)
                            .buyWorker();
                      },
                      upgradeCost: NumberFormat.compact()
                          .format(clickerBrain.workerCost),
                    ),
                  ),

                  // Autoclicker

                  Visibility(
                    visible: clickerBrain.isAutoClickVisible(),
                    child: ReusableProgressRow(
                      animation: autoClickAnimation,
                      title:
                          '${NumberFormat.compact().format(clickerBrain.autoClickNumber)}  x  AutoClicker',
                      onUpgradeTap: () {
                        Provider.of<ClickerBrain>(context, listen: false)
                            .buyAutoClicker();
                      },
                      upgradeCost: NumberFormat.compact()
                          .format(clickerBrain.autoClickCost),
                    ),
                  ),

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
