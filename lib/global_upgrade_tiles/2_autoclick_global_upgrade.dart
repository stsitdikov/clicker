import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/global_upgrade_tiles/global_upgrade_tile.dart';

class AutoClickGlobalUpgrade extends StatelessWidget {
  AutoClickGlobalUpgrade(this.controller);
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: GlobalUpgradeTile(
        canUpgradeMore: clickerBrain.canDecreaseDuration(
            kAutoClickName, kDecreaseAutoClickDurationBy),
        onTap: () {
          if (clickerBrain.canDecreaseDuration(
                  kAutoClickName, kDecreaseAutoClickDurationBy) &&
              clickerBrain.canShowGlobalUpgrade(kAutoClickName)) {
            clickerBrain.decreaseAutoClickDuration(controller);
            Phoenix.rebirth(context);
          }
        },
        duration: clickerBrain.getDurationString(kAutoClickName),
        title: kAutoClickName,
        cost: clickerBrain.getDecreaseDurationCost(kAutoClickName),
      ),
    );
  }
}
