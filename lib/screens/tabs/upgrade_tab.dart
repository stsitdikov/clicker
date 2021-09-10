import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/global_upgrade_tile.dart';

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

    List<Widget> listOfUpgrades = [];

    List<String> listOfNames = [];

    for (String name in kListOfNamesExceptClick) {
      bool showedPreviousRows = true;
      for (String entry in listOfNames) {
        if (clickerBrain.showedGlobalUpgrade(entry) == 0.0) {
          showedPreviousRows = false;
        }
      }
      listOfUpgrades.add(Visibility(
          visible: clickerBrain.showedGlobalUpgrade(name) == 0.0 &&
              showedPreviousRows == true,
          child: GlobalUpgradeTile(name, true)));
      listOfUpgrades.add(Visibility(
          visible: clickerBrain.showedGlobalUpgrade(name) == 1.0,
          child: GlobalUpgradeTile(name, false)));
      listOfNames.add(name);
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: SingleChildScrollView(
        reverse: true,
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
