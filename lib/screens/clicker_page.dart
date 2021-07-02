import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/autoclick_row.dart';
import 'package:provider/provider.dart';

class ClickerScreen extends StatelessWidget {
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
            child: MoneyDisplay(),
          ),
          Visibility(
            visible: Provider.of<ClickerBrain>(context).isAutoClickVisible(),
            child: Expanded(
              child: AutoclickRow(),
            ),
          ),
          Expanded(
            child: ClickRow(),
          ),
        ],
      ),
    );
  }
}
