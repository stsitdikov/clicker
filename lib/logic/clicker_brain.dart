import 'package:flutter/material.dart';

class ClickerBrain {
  double money = 0.0;
  double mainIncrement = 1.2;
  double upgradeClickCost = 20;

  double clickAmount = 1.0;

  void clickIncreaseMoney() {
    money = money = money + clickAmount;
  }

  void clickUpgradeCost() {
    if (money >= upgradeClickCost) {
      money = money - upgradeClickCost;
      upgradeClickCost = upgradeClickCost * mainIncrement;
      clickAmount = clickAmount * mainIncrement;
    }
  }
}
