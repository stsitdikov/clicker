class MoneyLogic {
  double money = 0.0;
  double mainIncrement = 1.2;

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

  bool canUpgradeWorker(workerCost) {
    return money >= workerCost;
  }

  bool canUpgradeManager(managerCost) {
    return money >= managerCost;
  }
}
