import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';

import 'package:clicker/components/global_upgrade_tile.dart';

class UpgradeTab extends StatelessWidget {
  final List<AnimationController> animationControllerList;
  UpgradeTab(this.animationControllerList);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    List<GlobalUpgradeTile> listOfUpgrades = [
      GlobalUpgradeTile(
          onTap: () {
            if (clickerBrain.canDecreaseCeoDuration()) {
              clickerBrain.decreaseCeoDuration(animationControllerList[3]);
              Phoenix.rebirth(context);
            }
          },
          duration: clickerBrain.getCeoDurationString(),
          title: 'Ceo',
          cost: clickerBrain.getCeoDecreaseDurationCost()),
      GlobalUpgradeTile(
          onTap: () {
            if (clickerBrain.canDecreaseManagerDuration()) {
              clickerBrain.decreaseManagerDuration(animationControllerList[2]);
              Phoenix.rebirth(context);
            }
          },
          duration: clickerBrain.getManagerDurationString(),
          title: 'Manager',
          cost: clickerBrain.getManagerDecreaseDurationCost()),
      GlobalUpgradeTile(
        onTap: () {
          if (clickerBrain.canDecreaseWorkerDuration()) {
            clickerBrain.decreaseWorkerDuration(animationControllerList[1]);
            Phoenix.rebirth(context);
          }
        },
        duration: clickerBrain.getWorkerDurationString(),
        title: 'Worker',
        cost: clickerBrain.getWorkerDecreaseDurationCost(),
      ),
      GlobalUpgradeTile(
        onTap: () {
          if (clickerBrain.canDecreaseAutoClickDuration()) {
            clickerBrain.decreaseAutoClickDuration(animationControllerList[0]);
            Phoenix.rebirth(context);
          }
        },
        duration: clickerBrain.getAutoClickDurationString(),
        title: 'AutoClicker',
        cost: clickerBrain.getAutoClickDecreaseDurationCost(),
      ),
    ];

    return Align(
      alignment: Alignment.bottomLeft,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: listOfUpgrades,
        ),
      ),
    );
  }
}
