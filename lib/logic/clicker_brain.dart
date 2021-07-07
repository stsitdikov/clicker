import 'dart:async';

import 'package:flutter/cupertino.dart';

class ClickerBrain extends ChangeNotifier {
  double money = 0.0;
  double mainIncrement = 1.2;
  double upgradeClickCost = 5;

  bool autoClickVisible = false;
  bool autoClickAnimation = false;
  double moneyToShowAutoClick = 10;
  double autoClickCost = 10;
  int autoClickNumber = 0;
  Duration autoClickerDuration = Duration(seconds: 3);

  double clickAmount = 1.0;
  bool clickUpgradeVisible = false;

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
        autoClickAnimation = true;
      }
    }
  }

  void autoClicker() {
    if (autoClickNumber > 0) {
      Timer.periodic(
        autoClickerDuration,
        (timer) {
          money = money + autoClickNumber * clickAmount;
          notifyListeners();
        },
      );
    }
  }

  bool isClickUpgradeVisible() {
    if (clickUpgradeVisible == false && money >= upgradeClickCost) {
      clickUpgradeVisible = true;
    }
    return clickUpgradeVisible;
  }

  bool isAutoClickVisible() {
    if (autoClickVisible == false && money >= moneyToShowAutoClick) {
      autoClickVisible = true;
    }
    return autoClickVisible;
  }
}
