import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/custom_widgets/upgrade_container.dart';
import 'package:clicker/logic/constants.dart';

class AutoclickRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border(
                left: BorderSide(color: kborderColor),
                top: BorderSide(color: kborderColor),
                right: BorderSide(color: kborderColor),
              ),
            ),
            child: Center(
              child: Text(
                '${Provider.of<ClickerBrain>(context).autoClickNumber.toString()}  x  AutoClicker',
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
              Border(
                top: BorderSide(color: kborderColor),
                right: BorderSide(color: kborderColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
