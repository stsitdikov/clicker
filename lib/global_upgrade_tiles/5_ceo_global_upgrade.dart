import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/global_upgrade_tiles/global_upgrade_tile.dart';

class CeoGlobalUpgrade extends StatelessWidget {
  CeoGlobalUpgrade(this.controller, this.remove);
  final AnimationController controller;
  final remove;

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: GlobalUpgradeTile(
          canUpgradeMore: clickerBrain.canDecreaseDuration(
              kCeoName, kDecreaseCeoDurationBy),
          onTap: () {
            if (clickerBrain.canDecreaseDuration(
                    kCeoName, kDecreaseCeoDurationBy) &&
                clickerBrain.canShowGlobalUpgrade(kCeoName)) {
              clickerBrain.decreaseCeoDuration(controller);
              Phoenix.rebirth(context);
            }
          },
          remove: remove,
          duration: clickerBrain.getDurationString(kCeoName),
          title: kCeoName.toUpperCase(),
          cost: clickerBrain.getDecreaseDurationCost(kCeoName)),
    );
  }
}
