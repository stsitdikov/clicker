import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/clicker_brain.dart';

class GlobalUpgradeTile extends StatelessWidget {
  final List<AnimationController> animationControllerList;
  GlobalUpgradeTile(this.animationControllerList);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: GestureDetector(
        onTap: () {
          clickerBrain.decreaseAutoClickDuration(animationControllerList[0]);
          Phoenix.rebirth(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15),
            ),
          ),
          height: 100.0,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '${clickerBrain.getAutoClickDurationString()}\n\nsec',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      border: Border.symmetric(vertical: BorderSide())),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'AutoClicker',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Upgrade to reduce the duration?',
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(clickerBrain.getAutoClickDecreaseDurationCost()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
