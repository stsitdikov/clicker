class ClickRowLogic {
  double clickAmount = 300.0;
  bool clickUpgradeVisible = false;
  double upgradeClickCost = 5;

  void clickCostIncrease(mainIncrement) {
    upgradeClickCost = upgradeClickCost * mainIncrement;
  }

  void upgradeClickAmount(mainIncrement) {
    clickAmount = clickAmount * mainIncrement;
  }

  bool isClickUpgradeVisible(money) {
    if (clickUpgradeVisible == false && money >= upgradeClickCost) {
      clickUpgradeVisible = true;
    }
    return clickUpgradeVisible;
  }
}
