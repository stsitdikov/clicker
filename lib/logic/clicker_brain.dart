import 'dart:async';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/manager_logic.dart';
import 'package:clicker/logic/money_logic.dart';
import 'package:clicker/logic/worker_logic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickerBrain extends ChangeNotifier {
  MoneyLogic moneyLogic;
  ClickRowLogic clickRowLogic;
  AutoClickLogic autoClickLogic;
  WorkerLogic workerLogic;
  ManagerLogic managerLogic;

  ClickerBrain(this.moneyLogic, this.clickRowLogic, this.autoClickLogic,
      this.workerLogic, this.managerLogic);

  String getMoneyString() {
    return NumberFormat.compact().format(getMoney());
  }

  double getMoney() {
    return moneyLogic.money();
  }

  void clearBox() {
    Box box = Hive.box<double>(kClickerBrainBox);
    box.clear();
  }

  // click row

  String getClickAmount() {
    return NumberFormat.compact().format(clickRowLogic.clickAmount());
  }

  String getClickCost() {
    return NumberFormat.compact().format(clickRowLogic.clickCost());
  }

  double getClickIncrement() {
    return clickRowLogic.clickIncrement();
  }

  void clickIncreaseMoney() {
    moneyLogic.clickIncreaseMoney();
    notifyListeners();
  }

  void clickUpgrade() {
    if (moneyLogic.canUpgrade(clickRowLogic.clickCost())) {
      moneyLogic.decreaseMoney(clickRowLogic.clickCost());
      clickRowLogic.clickUpgrade();
      notifyListeners();
    }
  }

  bool isClickUpgradeVisible() {
    return clickRowLogic.isClickUpgradeVisible(getMoney());
  }

  void changeClickIncrement() {
    clickRowLogic.updateClickIncrement();
    notifyListeners();
  }

  // autoclicker

  String getAutoClickNumber() {
    return NumberFormat.compact().format(autoClickLogic.autoClickNumber());
  }

  String getAutoClickCost() {
    return NumberFormat.compact().format(autoClickLogic.autoClickCost());
  }

  double getAutoClickIncrement() {
    return autoClickLogic.autoClickIncrement();
  }

  Duration getAutoClickDuration() {
    return autoClickLogic.autoClickerDuration;
  }

  bool shouldStartAutoClickAnimation() {
    return autoClickLogic.shouldStartAutoClickAnimation();
  }

  bool shouldAnimateAutoClick() {
    return autoClickLogic.shouldAnimateAutoClick() == 1;
  }

  void buyAutoClicker(controller) {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost());
      autoClickLogic.buyAutoClicker(workerLogic.workerNumber());
      notifyListeners();
      if (shouldStartAutoClickAnimation()) {
        controller.forward();
        autoClickTimer(controller);
      }
    }
  }

  double wasAutoClickInitiated = 0;

  void autoClickTimer(controller) {
    wasAutoClickInitiated++;
    Timer.periodic(
      autoClickLogic.autoClickerDuration,
      (timer) {
        moneyLogic.autoClickIncreaseMoney();
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void initialAutoClickTimer(controller) {
    if (autoClickLogic.shouldAnimateAutoClick() == 1 &&
        wasAutoClickInitiated == 0) {
      autoClickTimer(controller);
      wasAutoClickInitiated++;
    }
  }

  bool isAutoClickVisible() {
    return autoClickLogic.isAutoClickVisible(getMoney());
  }

  void updateAutoClickIncrement() {
    autoClickLogic.updateAutoClickIncrement();
    notifyListeners();
  }

  // worker

  String getWorkerNumber() {
    return NumberFormat.compact().format(workerLogic.workerNumber());
  }

  String getWorkerCost() {
    return NumberFormat.compact().format(workerLogic.workerCost());
  }

  double getWorkerIncrement() {
    return workerLogic.workerIncrement();
  }

  Duration getWorkerDuration() {
    return workerLogic.workerDuration;
  }

  bool shouldStartWorkerAnimation() {
    return workerLogic.shouldStartWorkerAnimation();
  }

  void buyWorker(controller) {
    if (moneyLogic.canUpgrade(workerLogic.workerCost())) {
      moneyLogic.decreaseMoney(workerLogic.workerCost());
      workerLogic.buyWorker(managerLogic.managerNumber);
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
    return workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber());
  }

  void changeWorkerIncrement() {
    workerLogic.updateWorkerIncrement();
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
    return managerLogic.managerIncrement.toStringAsFixed(0);
  }

  Duration getManagerDuration() {
    return managerLogic.managerDuration;
  }

  bool shouldStartManagerAnimation() {
    return managerLogic.shouldStartManagerAnimation();
  }

  void buyManager() {
    if (moneyLogic.canUpgrade(managerLogic.managerCost)) {
      moneyLogic.decreaseMoney(managerLogic.managerCost);
      managerLogic.updateManagerCostOne();
      managerLogic.managerCostIncrease();
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
    return managerLogic.isManagerVisible();
  }

  void changeManagerIncrement() {
    managerLogic.updateManagerIncrement();
    notifyListeners();
  }
}
