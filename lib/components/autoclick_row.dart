import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/elements/upgrade_container.dart';

class AutoclickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                Provider.of<ClickerBrain>(context).autoClickNumber.toString(),
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'AutoClicker',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Provider.of<ClickerBrain>(context, listen: false)
                  .buyAutoClicker();
            },
            child: UpgradeContainer(
              Provider.of<ClickerBrain>(context)
                  .autoClickCost
                  .toStringAsFixed(1),
            ),
          ),
        ),
      ],
    );
  }
}
