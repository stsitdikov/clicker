import 'dart:async';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/ceo_logic.dart';
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
  CeoLogic ceoLogic;

  ClickerBrain(this.moneyLogic, this.clickRowLogic, this.autoClickLogic,
      this.workerLogic, this.managerLogic, this.ceoLogic);

  String getMoneyString() => NumberFormat.compact().format(getMoney());

  double getMoney() => moneyLogic.money();

  Box box = Hive.box<double>(kClickerBrainBox);

  void clearBox() => box.clear();

  double listFlex() => box.get('listFlex', defaultValue: 1.0);

  double itemCount() => box.get('itemCount', defaultValue: 1.0);

  void increaseListFlex() {
    if (listFlex() < 3.0) {
      box.put('listFlex', (listFlex() + 1.0));
      box.put('itemCount', (itemCount() + 1.0));
    } else if (listFlex() == 3.0) {
      box.put('itemCount', (itemCount() + 1.0));
    }
  }

  double isLaunchFromGlobalUpgrade() =>
      box.get('isLaunchFromGlobalUpgrade', defaultValue: 0.0);

  void launchIsFromGlobalUpgrade() {
    if (isLaunchFromGlobalUpgrade() == 0.0) {
      box.put('isLaunchFromGlobalUpgrade', 1.0);
    }
  }

  void launchIsNormal() {
    if (isLaunchFromGlobalUpgrade() == 1.0) {
      box.put('isLaunchFromGlobalUpgrade', 0.0);
    }
  }

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

  Duration getAutoClickDuration() => Duration(
      milliseconds: autoClickLogic.autoClickDurationMilliseconds().toInt());

  String getAutoClickDurationString() =>
      (autoClickLogic.autoClickDurationMilliseconds() / 1000).toString();

  String getAutoClickDecreaseDurationCost() => NumberFormat.compact()
      .format(autoClickLogic.autoClickDecreaseDurationCost());

  bool shouldAnimateAutoClick() => autoClickLogic.shouldAnimateAutoClick() == 1;

  void buyAutoClicker(controller) {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost());
      autoClickLogic.buyAutoClicker();
      notifyListeners();
      if (shouldAnimateAutoClick() && wasAutoClickInitiated == 0) {
        controller.forward();
        autoClickTimerFunction(controller);
      }
    }
  }

  double wasAutoClickInitiated = 0;

  // void autoClickTimerFunction(controller) {
  //   wasAutoClickInitiated++;
  //   Timer.periodic(
  //     Duration(
  //         milliseconds: autoClickLogic.autoClickDurationMilliseconds().toInt()),
  //     (timer) {
  //       moneyLogic.autoClickIncreaseMoney();
  //       controller.reset();
  //       controller.forward();
  //       notifyListeners();
  //     },
  //   );
  // }

  void autoClickTimerFunction(controller) {
    wasAutoClickInitiated++;
    Timer.periodic(
      Duration(
          milliseconds: autoClickLogic.autoClickDurationMilliseconds().toInt()),
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
      controller.forward();
      autoClickTimerFunction(controller);
    }
  }

  bool isAutoClickVisible() => autoClickLogic.isAutoClickVisible(getMoney());

  double showedAutoClick() =>
      box.get('showedAutoClick', defaultValue: 0.0) as double;

  void updateShowedAutoClick() {
    box.put('showedAutoClick', 1.0);
  }

  void updateAutoClickIncrement() {
    autoClickLogic.updateAutoClickIncrement();
    notifyListeners();
  }

  void decreaseAutoClickDuration() {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickDecreaseDurationCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickDecreaseDurationCost());
      autoClickLogic.decreaseAutoClickDuration();
      autoClickLogic.increaseAutoClickDecreaseDurationCost();
      notifyListeners();
    }
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
      controller.forward();
      workerTimer(controller);
    }
  }

  bool isWorkerVisible() =>
      workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber());

  double showedWorker() => box.get('showedWorker', defaultValue: 0.0) as double;

  void updateShowedWorker() {
    box.put('showedWorker', 1.0);
  }

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
      controller.forward();
      managerTimer(controller);
    }
  }

  bool isManagerVisible() =>
      managerLogic.isManagerVisible(workerLogic.workerNumber());

  double showedManager() =>
      box.get('showedManager', defaultValue: 0.0) as double;

  void updateShowedManager() {
    box.put('showedManager', 1.0);
  }

  void updateManagerIncrement() {
    managerLogic.updateManagerIncrement();
    notifyListeners();
  }

  // ceo

  String getCeoNumber() => NumberFormat.compact().format(ceoLogic.ceoNumber());

  String getCeoCost() => NumberFormat.compact().format(ceoLogic.ceoCost());

  double getCeoIncrement() => ceoLogic.ceoIncrement();

  Duration getCeoDuration() => ceoLogic.ceoDuration;

  bool shouldAnimateCeo() => ceoLogic.shouldAnimateCeo() == 1;

  void buyCeo(controller) {
    if (moneyLogic.canUpgrade(ceoLogic.ceoCost())) {
      moneyLogic.decreaseMoney(ceoLogic.ceoCost());
      ceoLogic.buyCeo();
      notifyListeners();
      if (shouldAnimateCeo() && wasCeoInitiated == 0) {
        controller.forward();
        ceoTimer(controller);
      }
    }
  }

  double wasCeoInitiated = 0;

  void ceoTimer(controller) {
    wasCeoInitiated++;
    Timer.periodic(
      ceoLogic.ceoDuration,
      (timer) {
        managerLogic.ceoBuysManagers(ceoLogic.ceoNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void initialCeoTimer(controller) {
    if (shouldAnimateCeo() && wasCeoInitiated == 0) {
      controller.forward();
      ceoTimer(controller);
    }
  }

  bool isCeoVisible() => ceoLogic.isCeoVisible(managerLogic.managerNumber());

  double showedCeo() => box.get('showedCeo', defaultValue: 0.0) as double;

  void updateShowedCeo() {
    box.put('showedCeo', 1.0);
  }

  void updateCeoIncrement() {
    ceoLogic.updateCeoIncrement();
    notifyListeners();
  }
}
