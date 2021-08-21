import 'package:clicker/components/increment_container.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/components/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';

class ClickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);
    var clickerBrainListenFalse =
        Provider.of<ClickerBrain>(context, listen: false);

    return Container(
      height: kRowHeight,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                clickerBrainListenFalse.clickIncreaseMoney();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    'Click (${clickerBrain.getClickAmount()} \$)',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => clickerBrainListenFalse.changeClickIncrement(),
              child: IncrementContainer(
                clickerBrain.getIncrement(kClickName).toStringAsFixed(0),
                Border(
                  top: BorderSide(color: kBorderColor),
                  right: BorderSide(color: kBorderColor),
                  bottom: BorderSide(color: kBorderColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                clickerBrainListenFalse.clickUpgrade();
              },
              child: UpgradeContainer(
                clickerBrain.getCost(kClickName),
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
