import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_progress_row.dart';

class WorkerRow extends StatelessWidget {
  final Animation<double> animation;

  WorkerRow(this.animation);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return Visibility(
      visible: clickerBrain.isWorkerVisible(),
      child: ReusableProgressRow(
        animation: animation,
        title: clickerBrain.getWorkerNumber() + ' x  Worker',
        onUpgradeTap: () {
          clickerBrainListenFalse.buyWorker();
        },
        upgradeCost: clickerBrain.getWorkerCost(),
        incrementNumber: clickerBrain.getWorkerIncrement().toStringAsFixed(0),
        onIncrementTap: () {
          clickerBrainListenFalse.changeWorkerIncrement();
        },
      ),
    );
  }
}
