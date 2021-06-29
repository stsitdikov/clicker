import 'package:flutter/material.dart';

class UpgradeContainer extends StatelessWidget {
  final String upgradeCost;

  UpgradeContainer(this.upgradeCost);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        border: Border.all(color: Colors.black),
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
