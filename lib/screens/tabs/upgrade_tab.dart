import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/global_upgrade_tiles/global_upgrade_tile.dart';
import 'package:clicker/global_upgrade_tiles/global_upgrade_tile_blocked.dart';

class UpgradeTab extends StatelessWidget {
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
          child: GlobalUpgradeTileBlocked(kAutoClickName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kAutoClickName) == 1.0,
          child: GlobalUpgradeTile(kAutoClickName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked(kWorkerName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kWorkerName) == 1.0,
          child: GlobalUpgradeTile(kWorkerName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked(kManagerName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kManagerName) == 1.0,
          child: GlobalUpgradeTile(kManagerName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kManagerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked(kCeoName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kCeoName) == 1.0,
          child: GlobalUpgradeTile(kCeoName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 0.0 &&
              clickerBrain.showedGlobalUpgrade(kCeoName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kManagerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kWorkerName) != 0.0 &&
              clickerBrain.showedGlobalUpgrade(kAutoClickName) != 0.0,
          child: GlobalUpgradeTileBlocked(kMillionaireName)),
      Visibility(
          visible: clickerBrain.showedGlobalUpgrade(kMillionaireName) == 1.0,
          child: GlobalUpgradeTile(kMillionaireName)),
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
