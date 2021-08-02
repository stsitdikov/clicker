import 'package:flutter/material.dart';
import 'package:clicker/components/global_upgrade_tile.dart';

class UpgradeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GlobalUpgradeTile(),
      ],
    );
  }
}
