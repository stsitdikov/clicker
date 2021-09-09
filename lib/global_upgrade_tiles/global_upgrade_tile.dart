import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

class GlobalUpgradeTile extends StatelessWidget {
  final String name;

  GlobalUpgradeTile(this.name);

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    bool canUpgradeMore = clickerBrain.canDecreaseDuration(
        name, kMapOfDecreaseDurationIncrements[name]);

    void onTap() {
      if (clickerBrain.canDecreaseDuration(
              name, kMapOfDecreaseDurationIncrements[name]) &&
          clickerBrain.canShowGlobalUpgrade(name)) {
        clickerBrain.decreaseDuration(name);
        Phoenix.rebirth(context);
      }
    }

    String duration = clickerBrain.getDurationString(name);

    String cost = clickerBrain.getDecreaseDurationCostString(name);

    String textOfUpgrade = '';

    if (canUpgradeMore == true) {
      textOfUpgrade = 'Upgrade to reduce the duration?';
    } else {
      textOfUpgrade = 'Fully upgraded';
    }

    void removeGlobalUpgradeTile() {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Remove this button?'),
                content: Text((name == kCeoName ? name.toUpperCase() : name) +
                    ' is fully upgraded, do you want to remove this button?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'No'),
                    child: Text(
                      'No',
                      style: kDialogButtonTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Yes');
                      clickerBrain.updateShowedGlobalUpgrade(name, 2.0, true);
                    },
                    child: Text(
                      'Yes',
                      style: kDialogButtonTextStyle,
                    ),
                  ),
                ],
              ));
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: GestureDetector(
        onTap: canUpgradeMore ? onTap : removeGlobalUpgradeTile,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          height: kGlobalUpgradeTileHeight,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    '$duration\n\nsec',
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
                        name == kCeoName ? name.toUpperCase() : name,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          textOfUpgrade,
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
                  child:
                      canUpgradeMore ? Text(cost) : Icon(Icons.all_inclusive),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
