import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/global_upgrade_tiles/global_upgrade_tile.dart';

class ManagerGlobalUpgrade extends StatelessWidget {
  ManagerGlobalUpgrade(this.controller, this.remove);
  final AnimationController controller;
  final remove;

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: GlobalUpgradeTile(
          canUpgradeMore: clickerBrain.canDecreaseDuration(
              kManagerName, kDecreaseManagerDurationBy),
          onTap: () {
            if (clickerBrain.canDecreaseDuration(
                    kManagerName, kDecreaseManagerDurationBy) &&
                clickerBrain.canShowGlobalUpgrade(kManagerName)) {
              clickerBrain.decreaseManagerDuration(controller);
              Phoenix.rebirth(context);
            }
          },
          remove: remove,
          duration: clickerBrain.getDurationString(kManagerName),
          title: kManagerName,
          cost: clickerBrain.getDecreaseDurationCost(kManagerName)),
    );
  }
}
