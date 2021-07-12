import 'dart:math';

class ClickRowLogic {
  double clickAmount = 300.0;
  bool clickUpgradeVisible = false;
  int clickIncrement = 1;
  double clickCost = 10;
  double clickCostOne = 10;

  void clickCostIncrease(mainIncrement) {
    clickCost = clickCostOne;
    incrementalClickCost(mainIncrement);
  }

  void upgradeClickAmount(mainIncrement) {
    clickAmount = clickAmount * pow(mainIncrement, clickIncrement);
  }

  bool isClickUpgradeVisible(money) {
    if (clickUpgradeVisible == false && money >= clickCost) {
      clickUpgradeVisible = true;
    }
    return clickUpgradeVisible;
  }

  void updateClickIncrement(mainIncrement) {
    if (clickIncrement == 1) {
      clickIncrement = 10;
      clickCostOne = clickCost;
      incrementalClickCost(mainIncrement);
    } else if (clickIncrement == 10) {
      clickIncrement = 100;
      clickCost = clickCostOne;
      incrementalClickCost(mainIncrement);
    } else if (clickIncrement == 100) {
      clickIncrement = 1;
      clickCost = clickCostOne;
    }
  }

  void incrementalClickCost(mainIncrement) {
    for (var i = 1; i < clickIncrement; i++) {
      clickCost = clickCost + clickCostOne * pow(mainIncrement, i);
    }
  }

  void updateClickCostOne(mainIncrement) {
    clickCostOne = clickCostOne * pow(mainIncrement, clickIncrement);
  }
}
