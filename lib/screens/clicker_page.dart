import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/logic/clicker_brain.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen> {
  ClickerBrain clickerBrain = ClickerBrain();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: MoneyDisplay(clickerBrain.money),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        clickerBrain.clickIncreaseMoney();
                      });
                    },
                    child: Container(
                      color: Colors.blueGrey,
                      child: Center(
                        child: Text(
                          'Click (${clickerBrain.clickAmount.toStringAsFixed(1)} \$)',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        clickerBrain.clickUpgradeCost();
                      });
                    },
                    child: Container(
                      color: Colors.blueGrey[700],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.arrow_upward_outlined),
                          Text(
                              clickerBrain.upgradeClickCost.toStringAsFixed(1)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
