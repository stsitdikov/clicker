import 'package:flutter/cupertino.dart';

class ClickerBrain extends ChangeNotifier {
  double money = 0.0;
  double mainIncrement = 1.2;
  double upgradeClickCost = 20;

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
}
