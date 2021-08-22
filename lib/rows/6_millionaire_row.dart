import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/reusable_progress_row.dart';
import 'package:clicker/logic/constants.dart';

class MillionaireRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;

  MillionaireRow(this.animation, this.controller);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return ReusableProgressRow(
      animation: animation,
      title: clickerBrain.getNumber(kMillionaireName) + ' x  $kMillionaireName',
      onUpgradeTap: () {
        clickerBrainListenFalse.buyMillionaire(controller);
      },
      upgradeCost: clickerBrain.getCost(kMillionaireName),
      incrementNumber:
          clickerBrain.getIncrement(kMillionaireName).toStringAsFixed(0),
      onIncrementTap: () {
        clickerBrainListenFalse.updateMillionaireIncrement();
      },
    );
  }
}
