import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_progress_row.dart';
import 'package:clicker/logic/constants.dart';

class CeoRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;

  CeoRow(this.animation, this.controller);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return ReusableProgressRow(
      animation: animation,
      title: clickerBrain.getNumber(kCeoName) + ' x  ${kCeoName.toUpperCase()}',
      onUpgradeTap: () {
        clickerBrainListenFalse.buyCeo(controller);
      },
      upgradeCost: clickerBrain.getCost(kCeoName),
      incrementNumber: clickerBrain.getIncrement(kCeoName).toStringAsFixed(0),
      onIncrementTap: () {
        clickerBrainListenFalse.updateCeoIncrement();
      },
    );
  }
}
