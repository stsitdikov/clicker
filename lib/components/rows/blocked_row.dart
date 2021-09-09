import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/clicker_brain.dart';

import 'package:clicker/components/increment_container.dart';
import 'package:clicker/components/upgrade_container.dart';

class BlockedRow extends StatelessWidget {
  final String name;

  BlockedRow(this.name);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    return Container(
      height: kRowHeight,
      child: Stack(
        children: [
          Container(
            height: kRowHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
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
                        '0 x $name',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IncrementContainer(
                    '1',
                    Border(
                      top: BorderSide(color: kBorderColor),
                      right: BorderSide(color: kBorderColor),
                    ),
                  ),
                ),
                Expanded(
                  child: UpgradeContainer(
                    clickerBrain.getCostString(name),
                    Border(
                      top: BorderSide(color: kBorderColor),
                      right: BorderSide(color: kBorderColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.lock),
                    Text(
                      'Need to progress further',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
