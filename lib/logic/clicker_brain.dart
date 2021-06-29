import 'dart:async';

import 'package:flutter/cupertino.dart';

class ClickerBrain extends ChangeNotifier {
  double money = 0.0;
  double mainIncrement = 1.2;
  double upgradeClickCost = 20;
  double autoClickCost = 10;
  int autoClickNumber = 0;

  double clickAmount = 1.0;

  void clickIncreaseMoney() {
    money = money + clickAmount;
    notifyListeners();
  }

  void clickUpgradeCost() {
    if (money >= upgradeClickCost) {
      money = money - upgradeClickCost;
      upgradeClickCost = upgradeClickCost * mainIncrement;
      clickAmount = clickAmount * mainIncrement;
      notifyListeners();
    }
  }

  void buyAutoClicker() {
    if (money >= autoClickCost) {
      money = money - autoClickCost;
      autoClickCost = autoClickCost * mainIncrement;
      autoClickNumber++;
      notifyListeners();
      if (autoClickNumber == 1) {
        autoClicker();
      }
      ;
    }
  }

  void autoClicker() {
    if (autoClickNumber > 0) {
      Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          money = money + autoClickNumber * clickAmount;
          notifyListeners();
        },
      );
    }
  }
}
