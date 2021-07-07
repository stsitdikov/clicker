import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/custom_widgets/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';
import 'package:intl/intl.dart';

class ClickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        children: [
          Expanded(
            flex: 4,
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
                    'Click (${NumberFormat.compact().format(Provider.of<ClickerBrain>(context).clickAmount)} \$)',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: Provider.of<ClickerBrain>(context).isClickUpgradeVisible(),
            child: Expanded(
              child: GestureDetector(
                onTap: () {
                  Provider.of<ClickerBrain>(context, listen: false)
                      .clickUpgradeCost();
                },
                child: UpgradeContainer(
                  NumberFormat.compact().format(
                      Provider.of<ClickerBrain>(context).upgradeClickCost),
                  Border(
                    top: BorderSide(color: kBorderColor),
                    right: BorderSide(color: kBorderColor),
                    bottom: BorderSide(color: kBorderColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
