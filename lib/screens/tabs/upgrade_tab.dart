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

class UpgradeTab extends StatelessWidget {
  final List<AnimationController> animationControllerList;
  UpgradeTab(this.animationControllerList);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    for (String name in kListOfNamesExceptClick) {
      if (clickerBrain.canShowGlobalUpgrade(name) &&
          clickerBrain.showedGlobalUpgrade(name) == 0.0) {
        clickerBrain.updateShowedGlobalUpgrade(name, 1.0, false);
      }
    }

    List<Widget> listOfUpgrades = [
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kAutoClickName) == 0.0,
          child: GlobalUpgradeTileBlocked()),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
          child: AutoClickGlobalUpgrade(animationControllerList[0])),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked()),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0,
          child: WorkerGlobalUpgrade(animationControllerList[1])),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked()),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 1.0,
          child: ManagerGlobalUpgrade(animationControllerList[2])),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kManagerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked()),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 1.0,
          child: CeoGlobalUpgrade(animationControllerList[3])),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kCeoName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kManagerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked()),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 1.0,
          child: MillionaireGlobalUpgrade(animationControllerList[4])),
    ];

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
