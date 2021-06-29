import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyDisplay extends StatelessWidget {
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
            '${Provider.of<ClickerBrain>(context).money.toStringAsFixed(1)} \$',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
