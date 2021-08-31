import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/global_upgrade_tiles/global_upgrade_tile_blocked.dart';
import 'package:clicker/global_upgrade_tiles/2_autoclick_global_upgrade.dart';
import 'package:clicker/global_upgrade_tiles/3_worker_global_upgrade.dart';
import 'package:clicker/global_upgrade_tiles/4_manager_global_upgrade.dart';
import 'package:clicker/global_upgrade_tiles/5_ceo_global_upgrade.dart';
import 'package:clicker/global_upgrade_tiles/6_millionaire_global_upgrade.dart';

List<Widget> listOfUpgrades = [
  GlobalUpgradeTileBlocked(),
];

class UpgradeTab extends StatelessWidget {
  final List<AnimationController> animationControllerList;
  UpgradeTab(this.animationControllerList);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    if (clickerBrain.canShowGlobalUpgrade(kAutoClickName) &&
        clickerBrain.showedGlobalUpgrade(kAutoClickName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kAutoClickName);
      listOfUpgrades.insert(
        listOfUpgrades.length - 1,
        AutoClickGlobalUpgrade(
            animationControllerList[0], () => listOfUpgrades.removeAt(0)),
      );
    }

    if (clickerBrain.canShowGlobalUpgrade(kWorkerName) &&
        clickerBrain.showedGlobalUpgrade(kWorkerName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kWorkerName);
      listOfUpgrades.insert(
        listOfUpgrades.length - 1,
        WorkerGlobalUpgrade(
            animationControllerList[1], () => listOfUpgrades.removeAt(1)),
      );
    }

    if (clickerBrain.canShowGlobalUpgrade(kManagerName) &&
        clickerBrain.showedGlobalUpgrade(kManagerName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kManagerName);
      listOfUpgrades.insert(
        listOfUpgrades.length - 1,
        ManagerGlobalUpgrade(
            animationControllerList[2], () => listOfUpgrades.removeAt(2)),
      );
    }

    if (clickerBrain.canShowGlobalUpgrade(kCeoName) &&
        clickerBrain.showedGlobalUpgrade(kCeoName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kCeoName);
      listOfUpgrades.insert(
        listOfUpgrades.length - 1,
        CeoGlobalUpgrade(
            animationControllerList[3], () => listOfUpgrades.removeAt(3)),
      );
    }

    if (clickerBrain.canShowGlobalUpgrade(kMillionaireName) &&
        clickerBrain.showedGlobalUpgrade(kMillionaireName) == 0.0) {
      clickerBrain.updateShowedGlobalUpgrade(kMillionaireName);
      listOfUpgrades.insert(
        listOfUpgrades.length - 1,
        MillionaireGlobalUpgrade(
            animationControllerList[4], () => listOfUpgrades.removeAt(4)),
      );
      listOfUpgrades.removeAt(5);
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          verticalDirection: VerticalDirection.up,
          mainAxisAlignment: MainAxisAlignment.start,
          children: listOfUpgrades,
        ),
      ),
    );
  }
}
