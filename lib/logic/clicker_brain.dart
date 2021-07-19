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

  String getMoneyString() => NumberFormat.compact().format(getMoney());

  double getMoney() => moneyLogic.money();

  void clearBox() => Hive.box<double>(kClickerBrainBox).clear();

  // click row

  String getClickAmount() =>
      NumberFormat.compact().format(clickRowLogic.clickAmount());

  String getClickCost() =>
      NumberFormat.compact().format(clickRowLogic.clickCost());

  double getClickIncrement() => clickRowLogic.clickIncrement();

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

  bool isClickUpgradeVisible() =>
      clickRowLogic.isClickUpgradeVisible(getMoney());

  void changeClickIncrement() {
    clickRowLogic.updateClickIncrement();
    notifyListeners();
  }

  // autoclicker

  String getAutoClickNumber() =>
      NumberFormat.compact().format(autoClickLogic.autoClickNumber());

  String getAutoClickCost() =>
      NumberFormat.compact().format(autoClickLogic.autoClickCost());

  double getAutoClickIncrement() => autoClickLogic.autoClickIncrement();

  Duration getAutoClickDuration() => autoClickLogic.autoClickerDuration;

  bool shouldAnimateAutoClick() => autoClickLogic.shouldAnimateAutoClick() == 1;

  void buyAutoClicker(controller) {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost());
      autoClickLogic.buyAutoClicker();
      notifyListeners();
      if (shouldAnimateAutoClick() && wasAutoClickInitiated == 0) {
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
    }
  }

  bool isAutoClickVisible() => autoClickLogic.isAutoClickVisible(getMoney());

  void updateAutoClickIncrement() {
    autoClickLogic.updateAutoClickIncrement();
    notifyListeners();
  }

  // worker

  String getWorkerNumber() =>
      NumberFormat.compact().format(workerLogic.workerNumber());

  String getWorkerCost() =>
      NumberFormat.compact().format(workerLogic.workerCost());

  double getWorkerIncrement() => workerLogic.workerIncrement();

  Duration getWorkerDuration() => workerLogic.workerDuration;

  bool shouldAnimateWorker() => workerLogic.shouldAnimateWorker() == 1;

  void buyWorker(controller) {
    if (moneyLogic.canUpgrade(workerLogic.workerCost())) {
      moneyLogic.decreaseMoney(workerLogic.workerCost());
      workerLogic.buyWorker();
      notifyListeners();
      if (shouldAnimateWorker() && wasWorkerInitiated == 0) {
        controller.forward();
        workerTimer(controller);
      }
    }
  }

  double wasWorkerInitiated = 0;

  void workerTimer(controller) {
    wasWorkerInitiated++;
    Timer.periodic(
      workerLogic.workerDuration,
      (timer) {
        autoClickLogic.workerBuysAutoClicks(workerLogic.workerNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void initialWorkerTimer(controller) {
    if (shouldAnimateWorker() && wasWorkerInitiated == 0) {
      workerTimer(controller);
    }
  }

  bool isWorkerVisible() =>
      workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber());

  void updateWorkerIncrement() {
    workerLogic.updateWorkerIncrement();
    notifyListeners();
  }

  // manager

  String getManagerNumber() =>
      NumberFormat.compact().format(managerLogic.managerNumber());

  String getManagerCost() =>
      NumberFormat.compact().format(managerLogic.managerCost());

  double getManagerIncrement() => managerLogic.managerIncrement();

  Duration getManagerDuration() => managerLogic.managerDuration;

  bool shouldAnimateManager() => managerLogic.shouldAnimateManager() == 1;

  void buyManager(controller) {
    if (moneyLogic.canUpgrade(managerLogic.managerCost())) {
      moneyLogic.decreaseMoney(managerLogic.managerCost());
      managerLogic.buyManager();
      notifyListeners();
      if (shouldAnimateManager() && wasManagerInitiated == 0) {
        controller.forward();
        managerTimer(controller);
      }
    }
  }

  double wasManagerInitiated = 0;

  void managerTimer(controller) {
    wasManagerInitiated++;
    Timer.periodic(
      managerLogic.managerDuration,
      (timer) {
        workerLogic.managerBuysWorkers(managerLogic.managerNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void initialManagerTimer(controller) {
    if (shouldAnimateManager() && wasManagerInitiated == 0) {
      managerTimer(controller);
    }
  }

  bool isManagerVisible() =>
      managerLogic.isManagerVisible(workerLogic.workerNumber());

  void updateManagerIncrement() {
    managerLogic.updateManagerIncrement();
    notifyListeners();
  }
}
