import 'package:flutter/material.dart';

class UpgradeContainer extends StatelessWidget {
  final String upgradeCost;
  final Border border;

  UpgradeContainer(this.upgradeCost, this.border);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        border: border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.arrow_upward_outlined),
          Text(upgradeCost),
        ],
      ),
    );
  }
}
