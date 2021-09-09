import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/clicker_brain.dart';

import 'package:clicker/components/upgrade_container.dart';
import 'package:clicker/components/increment_container.dart';

class ReusableProgressRow extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController controller;
  final String name;

  ReusableProgressRow(
      {required this.animation, required this.controller, required this.name});

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
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border(
                      left: BorderSide(color: kBorderColor),
                      top: BorderSide(color: kBorderColor),
                      right: BorderSide(color: kBorderColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      clickerBrain.getNumberString(name) + ' x  $name',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                clickerBrainListenFalse.updateIncrement(name);
              },
              child: IncrementContainer(
                clickerBrain.getIncrement(name).toStringAsFixed(0),
                Border(
                  top: BorderSide(color: kBorderColor),
                  right: BorderSide(color: kBorderColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                clickerBrainListenFalse.upgradeRow(name, controller);
              },
              child: UpgradeContainer(
                clickerBrain.getCostString(name),
                Border(
                  top: BorderSide(color: kBorderColor),
                  right: BorderSide(color: kBorderColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
