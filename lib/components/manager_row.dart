import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_progress_row.dart';

class ManagerRow extends StatelessWidget {
  final Animation<double> animation;

  ManagerRow(this.animation);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return Visibility(
      visible: clickerBrain.isManagerVisible(),
      child: ReusableProgressRow(
        animation: animation,
        title: clickerBrain.getManagerNumber() + ' x  Manager',
        onUpgradeTap: () {
          clickerBrainListenFalse.buyManager();
        },
        upgradeCost: clickerBrain.getManagerCost(),
        incrementNumber: clickerBrain.getManagerIncrement(),
        onIncrementTap: () {
          clickerBrainListenFalse.changeManagerIncrement();
        },
      ),
    );
  }
}
