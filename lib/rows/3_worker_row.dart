import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_progress_row.dart';
import 'package:clicker/logic/constants.dart';

class WorkerRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;

  WorkerRow(this.animation, this.controller);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return ReusableProgressRow(
      animation: animation,
      title: clickerBrain.getNumberString(kWorkerName) + ' x  $kWorkerName',
      onUpgradeTap: () {
        clickerBrainListenFalse.upgradeRow(kWorkerName, controller);
      },
      upgradeCost: clickerBrain.getCostString(kWorkerName),
      incrementNumber:
          clickerBrain.getIncrement(kWorkerName).toStringAsFixed(0),
      onIncrementTap: () {
        clickerBrainListenFalse.updateWorkerIncrement();
      },
    );
  }
}
