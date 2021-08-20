import 'package:clicker/components/global_upgrade_tile.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:clicker/logic/constants.dart';

class GlobalUpgradeTileBlocked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: Container(
        height: kGlobalUpgradeTileHeight,
        child: Stack(
          children: [
            GlobalUpgradeTile(
                onTap: () {},
                duration: '30',
                title: 'AutoClicker',
                cost: 'cost'),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
              child: Container(
                height: kGlobalUpgradeTileHeight,
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
      ),
    );
  }
}
