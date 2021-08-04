import 'package:flutter/material.dart';
import 'package:clicker/components/global_upgrade_tile.dart';
import 'package:clicker/screens/clicker_screen.dart';

class UpgradeTab extends StatelessWidget {
  final AnimationController autoClickController;
  UpgradeTab(this.autoClickController);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GlobalUpgradeTile(autoClickController),
      ],
    );
  }
}
