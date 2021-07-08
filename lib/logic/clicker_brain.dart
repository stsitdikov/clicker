import 'dart:async';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/money_logic.dart';
import 'package:flutter/material.dart';

class ClickerBrain extends ChangeNotifier {
  MoneyLogic moneyLogic;
  ClickRowLogic clickRowLogic;
  AutoClickLogic autoClickLogic;

  ClickerBrain(this.moneyLogic, this.clickRowLogic, this.autoClickLogic);

  double getMoney() {
    return moneyLogic.money;
  }

  // click row

  void clickIncreaseMoney() {
    moneyLogic.clickIncreaseMoney(clickRowLogic.clickAmount);
    notifyListeners();
  }

  void clickUpgrade() {
    if (moneyLogic.canUpgradeClick(clickRowLogic.upgradeClickCost)) {
      moneyLogic.decreaseMoney(clickRowLogic.upgradeClickCost);
      clickRowLogic.clickCostIncrease(moneyLogic.mainIncrement);
      clickRowLogic.upgradeClickAmount(moneyLogic.mainIncrement);
      notifyListeners();
    }
  }

  bool isClickUpgradeVisible() {
    return clickRowLogic.isClickUpgradeVisible(moneyLogic.money);
  }

  // autoclicker

  void buyAutoClicker() {
    if (moneyLogic.canUpgradeAutoClick(autoClickLogic.autoClickCost)) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost);
      autoClickLogic.autoClickCostIncrease(moneyLogic.mainIncrement);
      autoClickLogic.autoClickNumberIncrease();
      notifyListeners();
      if (autoClickLogic.shouldStartAutoClickAnimation()) {
        timer(
            duration: autoClickLogic.autoClickerDuration,
            action: () => moneyLogic.autoClickIncreaseMoney(
                autoClickLogic.autoClickNumber, clickRowLogic.clickAmount));
      }
    }
  }

  void timer({duration, action}) {
    Timer.periodic(
      duration,
      (timer) {
        action;
        notifyListeners();
      },
    );
  }

  bool isAutoClickVisible() {
    return autoClickLogic.isAutoClickVisible(moneyLogic.canUpgradeAutoclick);
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
