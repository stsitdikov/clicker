import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/increment_container.dart';
import 'package:clicker/components/upgrade_container.dart';

class BlockedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        '0 x Unavailable',
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
                    '100',
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
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.lock),
                    Text(
                      'Need more money to unlock',
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
