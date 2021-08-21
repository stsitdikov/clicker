import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_progress_row.dart';

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
      title: clickerBrain.getCeoNumber() + ' x  CEO',
      onUpgradeTap: () {
        clickerBrainListenFalse.buyCeo(controller);
      },
      upgradeCost: clickerBrain.getCeoCost(),
      incrementNumber: clickerBrain.getCeoIncrement().toStringAsFixed(0),
      onIncrementTap: () {
        clickerBrainListenFalse.updateCeoIncrement();
      },
    );
  }
}
