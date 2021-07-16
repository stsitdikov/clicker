import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'reusable_progress_row.dart';

class AutoClickRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;

  AutoClickRow(this.animation, this.controller);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return Visibility(
      visible: clickerBrain.isAutoClickVisible(),
      child: ReusableProgressRow(
        animation: animation,
        title: clickerBrain.getAutoClickNumber() + ' x  AutoClicker',
        onUpgradeTap: () {
          clickerBrainListenFalse.buyAutoClicker(controller);
        },
        upgradeCost: clickerBrain.getAutoClickCost(),
        incrementNumber:
            clickerBrain.getAutoClickIncrement().toStringAsFixed(0),
        onIncrementTap: () {
          clickerBrainListenFalse.updateAutoClickIncrement();
        },
      ),
    );
  }
}
