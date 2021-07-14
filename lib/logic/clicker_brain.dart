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

  String getMoney() {
    return NumberFormat.compact().format(Hive.box<double>(kClickerBrainBox)
        .get('money', defaultValue: kDefaultMoney));
  }

  // click row

  String getClickAmount() {
    return NumberFormat.compact().format((Hive.box<double>(kClickerBrainBox)
        .get('clickAmount', defaultValue: kDefaultClickAmount)));
  }

  String getClickCost() {
    return NumberFormat.compact().format(Hive.box<double>(kClickerBrainBox)
        .get('clickCost', defaultValue: kDefaultClickCost));
  }

  String getClickIncrement() {
    return clickRowLogic.clickIncrement.toString();
  }

  void clickIncreaseMoney() {
    moneyLogic.clickIncreaseMoney();
    notifyListeners();
  }

  void clickUpgrade() {
    if (moneyLogic.canUpgradeClick()) {
      moneyLogic.decreaseMoney(Hive.box<double>(kClickerBrainBox)
          .get('clickCost', defaultValue: kDefaultClickCost));
      clickRowLogic.updateClickCostOne();
      clickRowLogic.clickCostIncrease();
      clickRowLogic.upgradeClickAmount();
      notifyListeners();
    }
  }

  bool isClickUpgradeVisible() {
    return clickRowLogic.isClickUpgradeVisible();
  }

  void changeClickIncrement() {
    clickRowLogic.updateClickIncrement();
    notifyListeners();
  }

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
    if (moneyLogic.canUpgradeAutoClick()) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost);
      autoClickLogic.updateAutoClickCostOne();
      autoClickLogic.autoClickCostIncrease();
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
        moneyLogic.autoClickIncreaseMoney();
        notifyListeners();
      },
    );
  }

  bool isAutoClickVisible() {
    return autoClickLogic.isAutoClickVisible(money);
  }

  void changeAutoClickIncrement() {
    autoClickLogic.updateAutoClickIncrement(mainIncrement);
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
    if (moneyLogic.canUpgradeWorker()) {
      moneyLogic.decreaseMoney(workerLogic.workerCost);
      workerLogic.updateWorkerCostOne(mainIncrement);
      workerLogic.workerCostIncrease(mainIncrement);
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
    workerLogic.updateWorkerIncrement(mainIncrement);
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
    if (moneyLogic.canUpgradeManager()) {
      moneyLogic.decreaseMoney(managerLogic.managerCost);
      managerLogic.updateManagerCostOne(mainIncrement);
      managerLogic.managerCostIncrease(mainIncrement);
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
    managerLogic.updateManagerIncrement(mainIncrement);
    notifyListeners();
  }
}
