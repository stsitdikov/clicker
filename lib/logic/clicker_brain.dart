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
    return moneyLogic.getMoney();
  }

  void clearBox() {
    Box box = Hive.box<double>(kClickerBrainBox);
    box.clear();
  }

  // click row

  String getClickAmount() {
    return NumberFormat.compact().format(clickRowLogic.getClickAmount());
  }

  String getClickCost() {
    return NumberFormat.compact().format(clickRowLogic.getClickCost());
  }

  double getClickIncrement() {
    return clickRowLogic.getClickIncrement();
  }

  void clickIncreaseMoney() {
    moneyLogic.clickIncreaseMoney();
    notifyListeners();
  }

  void clickUpgrade() {
    if (moneyLogic.canUpgrade(clickRowLogic.getClickCost())) {
      moneyLogic.decreaseMoney(clickRowLogic.getClickCost());
      clickRowLogic.updateClickCostOne();
      clickRowLogic.clickCostIncrease();
      clickRowLogic.upgradeClickAmount();
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
    return NumberFormat.compact().format(autoClickLogic.getAutoClickNumber());
  }

  String getAutoClickCost() {
    return NumberFormat.compact().format(autoClickLogic.getAutoClickCost());
  }

  double getAutoClickIncrement() {
    return autoClickLogic.getAutoClickIncrement();
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

  void buyAutoClicker() {
    if (moneyLogic.canUpgrade(autoClickLogic.getAutoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.getAutoClickCost());
      autoClickLogic.updateAutoClickCostOne();
      autoClickLogic.autoClickCostIncrease();
      autoClickLogic.autoClickNumberIncrease(workerLogic.workerNumber);
      notifyListeners();
      if (shouldStartAutoClickAnimation()) {
        autoClickTimer();
      }
    }
  }

  void autoClickTimer() {
    wasAutoClickInitiated++;
    Timer.periodic(
      autoClickLogic.autoClickerDuration,
      (timer) {
        moneyLogic.autoClickIncreaseMoney();
        notifyListeners();
      },
    );
  }

  double wasAutoClickInitiated = 0;

  void initialAutoClickTimer() {
    if (autoClickLogic.shouldAnimateAutoClick() == 1 &&
        wasAutoClickInitiated == 0) {
      autoClickTimer();
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
    return NumberFormat.compact().format(Hive.box<double>(kClickerBrainBox)
        .get('workerNumber', defaultValue: kDefaultWorkerNumber));
  }

  String getWorkerCost() {
    return NumberFormat.compact().format(Hive.box<double>(kClickerBrainBox)
        .get('workerCost', defaultValue: kDefaultWorkerCost));
  }

  double getWorkerIncrement() {
    return Hive.box<double>(kClickerBrainBox).get('workerIncrement',
        defaultValue: kDefaultWorkerIncrement) as double;
  }

  Duration getWorkerDuration() {
    return workerLogic.workerDuration;
  }

  bool shouldStartWorkerAnimation() {
    return workerLogic.shouldStartWorkerAnimation();
  }

  void buyWorker() {
    if (moneyLogic.canUpgrade(Hive.box<double>(kClickerBrainBox)
        .get('workerCost', defaultValue: kDefaultWorkerCost))) {
      moneyLogic.decreaseMoney(Hive.box<double>(kClickerBrainBox)
          .get('workerCost', defaultValue: kDefaultWorkerCost));
      workerLogic.updateWorkerCostOne();
      workerLogic.workerCostIncrease();
      workerLogic.workerNumberIncrease();
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
    return workerLogic.isWorkerVisible();
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
        workerLogic.workerNumberIncrease();
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
