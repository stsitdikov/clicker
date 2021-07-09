import 'package:flutter/material.dart';
import 'package:clicker/custom_widgets/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';

class ReusableProgressRow extends StatelessWidget {
  final Animation<double> animation;
  final String title;
  final onUpgradeTap;
  final String upgradeCost;
  final onIncrementTap;
  final String incrementNumber;

  ReusableProgressRow(
      {required this.animation,
      required this.title,
      required this.onUpgradeTap,
      required this.upgradeCost,
      required this.onIncrementTap,
      required this.incrementNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
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
                      title,
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
              onTap: onIncrementTap,
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
                    'x $incrementNumber',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onUpgradeTap,
              child: UpgradeContainer(
                upgradeCost,
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
