import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_progress_row.dart';
import 'package:clicker/logic/constants.dart';

class AutoClickRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;

  AutoClickRow(this.animation, this.controller);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return ReusableProgressRow(
      animation: animation,
      title:
          clickerBrain.getNumberString(kAutoClickName) + ' x  $kAutoClickName',
      onUpgradeTap: () {
        clickerBrainListenFalse.buyAutoClicker(controller);
      },
      upgradeCost: clickerBrain.getCostString(kAutoClickName),
      incrementNumber:
          clickerBrain.getIncrement(kAutoClickName).toStringAsFixed(0),
      onIncrementTap: () {
        clickerBrainListenFalse.updateAutoClickIncrement();
      },
    );
  }
}
