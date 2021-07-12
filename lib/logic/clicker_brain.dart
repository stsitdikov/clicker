import 'dart:async';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/manager_logic.dart';
import 'package:clicker/logic/money_logic.dart';
import 'package:clicker/logic/worker_logic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClickerBrain extends ChangeNotifier {
  MoneyLogic moneyLogic;
  ClickRowLogic clickRowLogic;
  AutoClickLogic autoClickLogic;
  WorkerLogic workerLogic;
  ManagerLogic managerLogic;

  ClickerBrain(this.moneyLogic, this.clickRowLogic, this.autoClickLogic,
      this.workerLogic, this.managerLogic);

  String getMoney() {
    return NumberFormat.compact().format(moneyLogic.money);
  }

  // click row

  String getClickAmount() {
    return NumberFormat.compact().format(clickRowLogic.clickAmount);
  }

  String getUpgradeClickCost() {
    return NumberFormat.compact().format(clickRowLogic.upgradeClickCost);
  }

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

  // bool isClickIncrementVisible() {
  //   return clickRowLogic.
  // }

  // autoclicker

  String getAutoClickNumber() {
    return NumberFormat.compact().format(autoClickLogic.autoClickNumber);
  }

  String getAutoClickCost() {
    return NumberFormat.compact().format(autoClickLogic.autoClickCost);
  }

  String getAutoClickIncrement() {
    return autoClickLogic.autoClickIncrement.toString();
  }

  Duration getAutoClickDuration() {
    return autoClickLogic.autoClickerDuration;
  }

  bool shouldStartAutoClickAnimation() {
    return autoClickLogic.shouldStartAutoClickAnimation();
  }

  void buyAutoClicker() {
    if (moneyLogic.canUpgradeAutoClick(autoClickLogic.autoClickCost)) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost);
      autoClickLogic.updateAutoClickCostOne(moneyLogic.mainIncrement);
      autoClickLogic.autoClickCostIncrease(moneyLogic.mainIncrement);
      autoClickLogic.autoClickNumberIncrease(0);
      notifyListeners();
      if (shouldStartAutoClickAnimation()) {
        autoClickTimer();
      }
    }
  }

  void autoClickTimer() {
    Timer.periodic(
      autoClickLogic.autoClickerDuration,
      (timer) {
        moneyLogic.autoClickIncreaseMoney(
            autoClickLogic.autoClickNumber, clickRowLogic.clickAmount);
        notifyListeners();
      },
    );
  }

  bool isAutoClickVisible() {
    return autoClickLogic.isAutoClickVisible(moneyLogic.money);
  }

  void changeAutoClickIncrement() {
    autoClickLogic.updateAutoClickIncrement(moneyLogic.mainIncrement);
    notifyListeners();
  }

  // worker

  String getWorkerNumber() {
    return NumberFormat.compact().format(workerLogic.workerNumber);
  }

  String getWorkerCost() {
    return NumberFormat.compact().format(workerLogic.workerCost);
  }

  String getWorkerIncrement() {
    return workerLogic.workerIncrement.toString();
  }

  Duration getWorkerDuration() {
    return workerLogic.workerDuration;
  }

  bool shouldStartWorkerAnimation() {
    return workerLogic.shouldStartWorkerAnimation();
  }

  void buyWorker() {
    if (moneyLogic.canUpgradeWorker(workerLogic.workerCost)) {
      moneyLogic.decreaseMoney(workerLogic.workerCost);
      workerLogic.updateWorkerCostOne(moneyLogic.mainIncrement);
      workerLogic.workerCostIncrease(moneyLogic.mainIncrement);
      workerLogic.workerNumberIncrease(0);
      notifyListeners();
      if (shouldStartWorkerAnimation()) {
        workerTimer();
      }
    }
  }

  void workerTimer() {
    Timer.periodic(
      workerLogic.workerDuration,
      (timer) {
        autoClickLogic.autoClickNumberIncrease(workerLogic.workerNumber);
        notifyListeners();
      },
    );
  }

  bool isWorkerVisible() {
    return workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber);
  }

  void changeWorkerIncrement() {
    workerLogic.updateWorkerIncrement(moneyLogic.mainIncrement);
    notifyListeners();
  }

  // manager

  String getManagerNumber() {
    return NumberFormat.compact().format(managerLogic.managerNumber);
  }

  String getManagerCost() {
    return NumberFormat.compact().format(managerLogic.managerCost);
  }

  String getManagerIncrement() {
    return managerLogic.managerIncrement.toString();
  }

  Duration getManagerDuration() {
    return managerLogic.managerDuration;
  }

  bool shouldStartManagerAnimation() {
    return managerLogic.shouldStartManagerAnimation();
  }

  void buyManager() {
    if (moneyLogic.canUpgradeManager(managerLogic.managerCost)) {
      moneyLogic.decreaseMoney(managerLogic.managerCost);
      managerLogic.updateManagerCostOne(moneyLogic.mainIncrement);
      managerLogic.managerCostIncrease(moneyLogic.mainIncrement);
      managerLogic.managerNumberIncrease();
      notifyListeners();
      if (shouldStartManagerAnimation()) {
        managerTimer();
      }
    }
  }

  void managerTimer() {
    Timer.periodic(
      managerLogic.managerDuration,
      (timer) {
        workerLogic.workerNumberIncrease(managerLogic.managerNumber);
        notifyListeners();
      },
    );
  }

  bool isManagerVisible() {
    return managerLogic.isManagerVisible(workerLogic.workerNumber);
  }

  void changeManagerIncrement() {
    managerLogic.updateManagerIncrement(moneyLogic.mainIncrement);
    notifyListeners();
  }
}
