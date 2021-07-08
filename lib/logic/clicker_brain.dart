import 'dart:async';
import 'package:flutter/material.dart';

class ClickerBrain extends ChangeNotifier {
  // main
  double money = 0.0;
  double mainIncrement = 1.2;
  double upgradeClickCost = 5;

  // click row
  double clickAmount = 300.0;
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

  bool isClickUpgradeVisible() {
    if (clickUpgradeVisible == false && money >= upgradeClickCost) {
      clickUpgradeVisible = true;
    }
    return clickUpgradeVisible;
  }

  // autoclicker
  bool autoClickVisible = false;
  bool autoClickAnimation = false;
  int startAutoClickAnimation = 0;
  double moneyToShowAutoClick = 10;
  int autoClickIncrement = 1;
  double autoClickCost = 10;
  double autoClickCostOne = 0;
  int autoClickNumber = 0;
  Duration autoClickerDuration = Duration(seconds: 3);

  void buyAutoClicker() {
    if (money >= autoClickCost) {
      money = money - autoClickCost;
      autoClickCost = autoClickCost * mainIncrement;
      autoClickNumber = autoClickNumber + autoClickIncrement;
      startAutoClickAnimation++;
      notifyListeners();
      if (startAutoClickAnimation == 1) {
        autoClicker();
      }
    }
  }

  void autoClicker() {
    Timer.periodic(
      autoClickerDuration,
      (timer) {
        money = money + autoClickNumber * clickAmount;
        notifyListeners();
      },
    );
  }

  bool isAutoClickVisible() {
    if (autoClickVisible == false && money >= moneyToShowAutoClick) {
      autoClickVisible = true;
    }
    return autoClickVisible;
  }

  void changeAutoClickIncrement() {
    updateAutoClickIncrement();
    notifyListeners();
  }

  void updateAutoClickIncrement() {
    if (autoClickIncrement == 1) {
      autoClickIncrement = 10;
      autoClickCostOne = autoClickCost;
      updateAutoClickCost();
    } else if (autoClickIncrement == 10) {
      autoClickIncrement = 100;
      updateAutoClickCost();
    } else if (autoClickIncrement == 100) {
      autoClickIncrement = 1;
      autoClickCost = autoClickCostOne;
    }
  }

  void updateAutoClickCost() {
    for (var i = autoClickIncrement; i > 0; i--) {
      autoClickCost = autoClickCost * mainIncrement;
    }
  }

  // worker
  bool workerVisible = false;
  bool workerAnimation = false;
  double autoClickNumberToShowWorker = 5;
  double workerCost = 10;
  int workerNumber = 0;
  Duration workerDuration = Duration(seconds: 10);

  void buyWorker() {
    if (money >= workerCost) {
      money = money - workerCost;
      workerCost = workerCost * mainIncrement;
      workerNumber++;
      notifyListeners();
      if (workerNumber == 1) {
        worker();
        workerAnimation = true;
      }
    }
  }

  void worker() {
    if (workerNumber > 0) {
      Timer.periodic(
        workerDuration,
        (timer) {
          autoClickNumber = autoClickNumber + workerNumber;
          notifyListeners();
        },
      );
    }
  }

  bool isWorkerVisible() {
    if (workerVisible == false &&
        autoClickNumber >= autoClickNumberToShowWorker) {
      workerVisible = true;
    }
    return workerVisible;
  }

  // worker
  bool managerVisible = false;
  bool managerAnimation = false;
  double workerNumberToShowManager = 5;
  double managerCost = 10;
  int managerNumber = 0;
  Duration managerDuration = Duration(seconds: 30);

  void buyManager() {
    if (money >= managerCost) {
      money = money - managerCost;
      managerCost = managerCost * mainIncrement;
      managerNumber++;
      notifyListeners();
      if (managerNumber == 1) {
        manager();
        managerAnimation = true;
      }
    }
  }

  void manager() {
    if (managerNumber > 0) {
      Timer.periodic(
        managerDuration,
        (timer) {
          workerNumber = workerNumber + managerNumber;
          notifyListeners();
        },
      );
    }
  }

  bool isManagerVisible() {
    if (managerVisible == false && workerNumber >= workerNumberToShowManager) {
      managerVisible = true;
    }
    return managerVisible;
  }
}
