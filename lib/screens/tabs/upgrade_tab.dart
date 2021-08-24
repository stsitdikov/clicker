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

    if (clickerBrain.canShowGlobalUpgrade(kMillionaireName) &&
        clickerBrain.showedGlobalUpgrade(kMillionaireName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kMillionaireName);
    }

    List<Widget> listOfUpgrades = [
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              canUpgradeMore: clickerBrain.canDecreaseDuration(
                  kMillionaireName, kDecreaseMillionaireDurationBy),
              onTap: () {
                if (clickerBrain.canDecreaseDuration(
                        kMillionaireName, kDecreaseMillionaireDurationBy) &&
                    clickerBrain.canShowGlobalUpgrade(kMillionaireName)) {
                  clickerBrain
                      .decreaseMillionaireDuration(animationControllerList[4]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getDurationString(kMillionaireName),
              title: kMillionaireName,
              cost: clickerBrain.getDecreaseDurationCost(kMillionaireName)),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 0.0 &&
            clickerBrain.showedGlobalUpgrade(kCeoName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kManagerName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0 &&
            clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              canUpgradeMore: clickerBrain.canDecreaseDuration(
                  kCeoName, kDecreaseCeoDurationBy),
              onTap: () {
                if (clickerBrain.canDecreaseDuration(
                        kCeoName, kDecreaseCeoDurationBy) &&
                    clickerBrain.canShowGlobalUpgrade(kCeoName)) {
                  clickerBrain.decreaseCeoDuration(animationControllerList[3]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getDurationString(kCeoName),
              title: kCeoName.toUpperCase(),
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
                        kManagerName, kDecreaseManagerDurationBy) &&
                    clickerBrain.canShowGlobalUpgrade(kManagerName)) {
                  clickerBrain
                      .decreaseManagerDuration(animationControllerList[2]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getDurationString(kManagerName),
              title: kManagerName,
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
                      kWorkerName, kDecreaseWorkerDurationBy) &&
                  clickerBrain.canShowGlobalUpgrade(kWorkerName)) {
                clickerBrain.decreaseWorkerDuration(animationControllerList[1]);
                Phoenix.rebirth(context);
              }
            },
            duration: clickerBrain.getDurationString(kWorkerName),
            title: kWorkerName,
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
            remove: () => listOfUpgrades.removeAt(9),
            duration: clickerBrain.getDurationString(kAutoClickName),
            title: kAutoClickName,
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
