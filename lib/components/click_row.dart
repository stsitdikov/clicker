import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: () {
              Provider.of<ClickerBrain>(context, listen: false)
                  .clickIncreaseMoney();
            },
            child: Container(
              color: Colors.blueGrey,
              child: Center(
                child: Text(
                  'Click (${Provider.of<ClickerBrain>(context).clickAmount.toStringAsFixed(1)} \$)',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Provider.of<ClickerBrain>(context, listen: false)
                  .clickUpgradeCost();
            },
            child: Container(
              color: Colors.blueGrey[700],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.arrow_upward_outlined),
                  Text(Provider.of<ClickerBrain>(context)
                      .upgradeClickCost
                      .toStringAsFixed(1)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
