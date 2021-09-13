import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Provider.of<ClickerBrain>(context, listen: false).clickIncreaseMoney();
      // },
      onTap: () {
        Provider.of<ClickerBrain>(context, listen: false).clearBox();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
          child: Center(
            child: Text(
              Provider.of<ClickerBrain>(context).getMoneyString() + ' \$',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
      ),
    );
  }
}
