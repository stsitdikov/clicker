import 'package:clicker/components/global_upgrade_tile_blocked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/global_upgrade_tile.dart';

class UpgradeTab extends StatelessWidget {
  final List<AnimationController> animationControllerList;
  UpgradeTab(this.animationControllerList);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    if (clickerBrain.canShowGlobalUpgrade(kAutoClickName) &&
        clickerBrain.showedGlobalUpgrade(kAutoClickName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kAutoClickName);
    }

    if (clickerBrain.canShowGlobalUpgrade(kWorkerName) &&
        clickerBrain.showedGlobalUpgrade(kWorkerName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kWorkerName);
    }

    if (clickerBrain.canShowGlobalUpgrade(kManagerName) &&
        clickerBrain.showedGlobalUpgrade(kManagerName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kManagerName);
    }

    if (clickerBrain.canShowGlobalUpgrade(kCeoName) &&
        clickerBrain.showedGlobalUpgrade(kCeoName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kCeoName);
    }

    List<Widget> listOfUpgrades = [
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              canUpgradeMore: clickerBrain.canDecreaseDuration(
                  kCeoName, kDecreaseCeoDurationBy),
              onTap: () {
                if (clickerBrain.canDecreaseDuration(
                    kCeoName, kDecreaseCeoDurationBy)) {
                  clickerBrain.decreaseCeoDuration(animationControllerList[3]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getDurationString(kCeoName),
              title: 'Ceo',
              cost: clickerBrain.getDecreaseDurationCost(kCeoName)),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 0.0 &&
            clickerBrain.showedGlobalUpgrade(kManagerName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              canUpgradeMore: clickerBrain.canDecreaseDuration(
                  kManagerName, kDecreaseManagerDurationBy),
              onTap: () {
                if (clickerBrain.canDecreaseDuration(
                    kManagerName, kDecreaseManagerDurationBy)) {
                  clickerBrain
                      .decreaseManagerDuration(animationControllerList[2]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getDurationString(kManagerName),
              title: 'Manager',
              cost: clickerBrain.getDecreaseDurationCost(kManagerName)),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 0.0 &&
            clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
            canUpgradeMore: clickerBrain.canDecreaseDuration(
                kWorkerName, kDecreaseWorkerDurationBy),
            onTap: () {
              if (clickerBrain.canDecreaseDuration(
                  kWorkerName, kDecreaseWorkerDurationBy)) {
                clickerBrain.decreaseWorkerDuration(animationControllerList[1]);
                Phoenix.rebirth(context);
              }
            },
            duration: clickerBrain.getDurationString(kWorkerName),
            title: 'Worker',
            cost: clickerBrain.getDecreaseDurationCost(kWorkerName),
          ),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 0.0 &&
            clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
            canUpgradeMore: clickerBrain.canDecreaseDuration(
                kAutoClickName, kDecreaseAutoClickDurationBy),
            onTap: () {
              if (clickerBrain.canDecreaseDuration(
                      kAutoClickName, kDecreaseAutoClickDurationBy) &&
                  clickerBrain.canShowGlobalUpgrade(kAutoClickName)) {
                clickerBrain
                    .decreaseAutoClickDuration(animationControllerList[0]);
                Phoenix.rebirth(context);
              }
            },
            duration: clickerBrain.getDurationString(kAutoClickName),
            title: 'AutoClicker',
            cost: clickerBrain.getDecreaseDurationCost(kAutoClickName),
          ),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kAutoClickName) == 0.0,
        child: GlobalUpgradeTileBlocked(),
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
