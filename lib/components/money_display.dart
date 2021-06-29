import 'package:flutter/material.dart';
import 'package:clicker/logic/clicker_brain.dart';

class MoneyDisplay extends StatelessWidget {
  final double money;

  MoneyDisplay(this.money);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueGrey,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green[500],
        ),
        child: Center(
          child: Text(
            '${money.toStringAsFixed(1)} \$',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
