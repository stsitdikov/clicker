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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GlobalUpgradeTile(
          onTap: () {
            if (clickerBrain.canDecreaseAutoClickDuration()) {
              clickerBrain
                  .decreaseAutoClickDuration(animationControllerList[0]);
              Phoenix.rebirth(context);
            }
          },
          duration: clickerBrain.getAutoClickDurationString(),
          title: 'AutoClicker',
          cost: clickerBrain.getAutoClickDecreaseDurationCost(),
        ),
      ],
    );
  }
}
