import 'dart:async';

class MoneyLogic {
  double money = 0.0;
  double mainIncrement = 1.2;

  double moneyToShowAutoClick = 10;

  void clickIncreaseMoney(clickAmount) {
    money = money + clickAmount;
  }

  bool canUpgradeClick(upgradeClickCost) {
    return money >= upgradeClickCost;
  }

  void decreaseMoney(amount) {
    money = money - amount;
  }

  bool canUpgradeAutoClick(autoClickCost) {
    return money >= autoClickCost;
  }

  void autoClickIncreaseMoney(autoClickNumber, clickAmount) {
    money = money + autoClickNumber * clickAmount;
  }

  bool canUpgradeAutoclick() {
    return money >= moneyToShowAutoClick;
  }
}
