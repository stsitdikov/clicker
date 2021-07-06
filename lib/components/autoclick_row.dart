import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/custom_widgets/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';

class AutoclickRow extends StatelessWidget {
  final Animation<double> animation;

  AutoclickRow(this.animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        children: [
          Expanded(
            flex: 4,
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
                      '${Provider.of<ClickerBrain>(context).autoClickNumber.toString()}  x  AutoClicker',
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
                Provider.of<ClickerBrain>(context, listen: false)
                    .buyAutoClicker();
              },
              child: UpgradeContainer(
                Provider.of<ClickerBrain>(context)
                    .autoClickCost
                    .toStringAsFixed(1),
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
