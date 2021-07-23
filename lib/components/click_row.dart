import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/custom_widgets/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';

class ClickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Provider.of<ClickerBrain>(context, listen: false)
                    .clickIncreaseMoney();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    'Click (${Provider.of<ClickerBrain>(context).getClickAmount()} \$)',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Provider.of<ClickerBrain>(context, listen: false)
                  .changeClickIncrement(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border(
                    top: BorderSide(color: kBorderColor),
                    right: BorderSide(color: kBorderColor),
                  ),
                ),
                child: Center(
                  child: Text(
                    'x ' +
                        Provider.of<ClickerBrain>(context)
                            .getClickIncrement()
                            .toStringAsFixed(0),
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
                    .clickUpgrade();
              },
              child: UpgradeContainer(
                Provider.of<ClickerBrain>(context).getClickCost(),
                Border(
                  top: BorderSide(color: kBorderColor),
                  right: BorderSide(color: kBorderColor),
                  bottom: BorderSide(color: kBorderColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
