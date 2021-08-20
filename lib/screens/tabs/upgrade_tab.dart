import 'package:clicker/components/global_upgrade_tile_blocked.dart';
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

    if (clickerBrain.canShowAutoClickGlobalUpgrade() &&
        clickerBrain.showedAutoClickGlobalUpgrade() == 0.0) {
      clickerBrain.updateShowedAutoClickGlobalUpgrade();
    }

    if (clickerBrain.canShowWorkerGlobalUpgrade() &&
        clickerBrain.showedWorkerGlobalUpgrade() == 0.0) {
      clickerBrain.updateShowedWorkerGlobalUpgrade();
    }

    if (clickerBrain.canShowManagerGlobalUpgrade() &&
        clickerBrain.showedManagerGlobalUpgrade() == 0.0) {
      clickerBrain.updateShowedManagerGlobalUpgrade();
    }

    if (clickerBrain.canShowCeoGlobalUpgrade() &&
        clickerBrain.showedCeoGlobalUpgrade() == 0.0) {
      clickerBrain.updateShowedCeoGlobalUpgrade();
    }

    List<Widget> listOfUpgrades = [
      Visibility(
        visible: clickerBrain.showedCeoGlobalUpgrade() == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              onTap: () {
                if (clickerBrain.canDecreaseCeoDuration()) {
                  clickerBrain.decreaseCeoDuration(animationControllerList[3]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getCeoDurationString(),
              title: 'Ceo',
              cost: clickerBrain.getCeoDecreaseDurationCost()),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedCeoGlobalUpgrade() == 0.0 &&
            clickerBrain.showedManagerGlobalUpgrade() == 1.0 &&
            clickerBrain.showedWorkerGlobalUpgrade() == 1.0 &&
            clickerBrain.showedAutoClickGlobalUpgrade() == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedManagerGlobalUpgrade() == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
              onTap: () {
                if (clickerBrain.canDecreaseManagerDuration()) {
                  clickerBrain
                      .decreaseManagerDuration(animationControllerList[2]);
                  Phoenix.rebirth(context);
                }
              },
              duration: clickerBrain.getManagerDurationString(),
              title: 'Manager',
              cost: clickerBrain.getManagerDecreaseDurationCost()),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedManagerGlobalUpgrade() == 0.0 &&
            clickerBrain.showedWorkerGlobalUpgrade() == 1.0 &&
            clickerBrain.showedAutoClickGlobalUpgrade() == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedWorkerGlobalUpgrade() == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
            onTap: () {
              if (clickerBrain.canDecreaseWorkerDuration()) {
                clickerBrain.decreaseWorkerDuration(animationControllerList[1]);
                Phoenix.rebirth(context);
              }
            },
            duration: clickerBrain.getWorkerDurationString(),
            title: 'Worker',
            cost: clickerBrain.getWorkerDecreaseDurationCost(),
          ),
        ),
      ),
      Visibility(
        visible: clickerBrain.showedWorkerGlobalUpgrade() == 0.0 &&
            clickerBrain.showedAutoClickGlobalUpgrade() == 1.0,
        child: GlobalUpgradeTileBlocked(),
      ),
      Visibility(
        visible: clickerBrain.showedAutoClickGlobalUpgrade() == 1.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
          child: GlobalUpgradeTile(
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
        ),
      ),
      Visibility(
        visible: clickerBrain.showedAutoClickGlobalUpgrade() == 0.0,
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
