import 'dart:async';
import 'package:clicker/logic/autoclick_logic.dart';
import 'package:clicker/logic/ceo_logic.dart';
import 'package:clicker/logic/click_row_logic.dart';
import 'package:clicker/logic/clicker_functions.dart';
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
  ClickerFunctions clickerFunctions;

  ClickerBrain(this.moneyLogic, this.clickerFunctions, this.clickRowLogic,
      this.autoClickLogic, this.workerLogic, this.managerLogic, this.ceoLogic);

  String getMoneyString() => NumberFormat.compact().format(getMoney());

  double getMoney() => moneyLogic.money();

  Box box = Hive.box<double>(kClickerBrainBox);

  void clearBox() => box.clear();

  double listFlex() => box.get('listFlex', defaultValue: 2.0);

  double itemCount() => box.get('itemCount', defaultValue: 2.0);

  void increaseListFlex() {
    if (listFlex() < 3.0) {
      box.put('listFlex', (listFlex() + 1.0));
      box.put('itemCount', (itemCount() + 1.0));
    } else if (listFlex() == 3.0) {
      box.put('itemCount', (itemCount() + 1.0));
    }
  }

  double firstLaunch() => box.get('firstLaunch', defaultValue: 1.0);

  void notFirstLaunch() => box.put('firstLaunch', (firstLaunch() + 1.0));

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

  void cancelTimers() {
    autoClickTimer.cancel();
    workerTimer.cancel();
    managerTimer.cancel();
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
      clickerFunctions.upgradeRow(
        isClickRow: true,
        shouldAnimate: 1.0,
        boxShouldAnimate: 'null',
        increment: getClickIncrement(),
        costOne: clickRowLogic.clickCostOne(),
        numberToChange: clickRowLogic.clickAmount(),
        boxCostOneName: clickRowLogic.clickCostOneString,
        boxCostName: clickRowLogic.clickCostString,
        boxNumberName: clickRowLogic.clickAmountString,
      );
      notifyListeners();
    }
  }

  void changeClickIncrement() {
    clickerFunctions.updateIncrement(
        increment: getClickIncrement(),
        cost: clickRowLogic.clickCost(),
        costOne: clickRowLogic.clickCostOne(),
        boxIncrementName: clickRowLogic.clickIncrementString,
        boxCostName: clickRowLogic.clickCostString,
        boxCostOneName: clickRowLogic.clickCostOneString);
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

  double shouldAnimateAutoClick() => autoClickLogic.shouldAnimateAutoClick();

  double wasAutoClickInitiated = 0;

  Timer autoClickTimer = Timer(Duration(milliseconds: 0), () {});

  void autoClickTimerStart(controller) {
    clickerFunctions.timerStart(
        controller,
        autoClickTimer,
        getAutoClickDuration(),
        () => moneyLogic.autoClickIncreaseMoney(),
        () => notifyListeners());
  }

  void buyAutoClicker(controller) {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getAutoClickIncrement(),
          costOne: autoClickLogic.autoClickCostOne(),
          shouldAnimate: shouldAnimateAutoClick(),
          numberToChange: autoClickLogic.autoClickNumber(),
          boxCostOneName: autoClickLogic.autoClickCostOneString,
          boxCostName: autoClickLogic.autoClickCostString,
          boxNumberName: autoClickLogic.autoClickNumberString,
          boxShouldAnimate: autoClickLogic.shouldAnimateAutoClickString);
      notifyListeners();
      initialAutoClickTimer(controller);
    }
  }

  void initialAutoClickTimer(controller) {
    if (shouldAnimateAutoClick() == 1.0 && wasAutoClickInitiated == 0) {
      wasAutoClickInitiated++;
      controller.forward();
      autoClickTimerStart(controller);
    }
  }

  bool isAutoClickVisible() => autoClickLogic.isAutoClickVisible(getMoney());

  double showedAutoClick() =>
      box.get('showedAutoClick', defaultValue: 0.0) as double;

  void updateShowedAutoClick() {
    box.put('showedAutoClick', 1.0);
  }

  void updateAutoClickIncrement() {
    clickerFunctions.updateIncrement(
        increment: getAutoClickIncrement(),
        cost: autoClickLogic.autoClickCost(),
        costOne: autoClickLogic.autoClickCostOne(),
        boxIncrementName: autoClickLogic.autoClickIncrementString,
        boxCostName: autoClickLogic.autoClickCostString,
        boxCostOneName: autoClickLogic.autoClickCostOneString);
    notifyListeners();
  }

  bool canDecreaseAutoClickDuration() {
    return moneyLogic
        .canUpgrade(autoClickLogic.autoClickDecreaseDurationCost());
  }

  void decreaseAutoClickDuration(controller) {
    moneyLogic.decreaseMoney(autoClickLogic.autoClickDecreaseDurationCost());
    autoClickLogic.decreaseAutoClickDuration();
    autoClickLogic.increaseAutoClickDecreaseDurationCost();
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // worker

  String getWorkerNumber() =>
      NumberFormat.compact().format(workerLogic.workerNumber());

  String getWorkerCost() =>
      NumberFormat.compact().format(workerLogic.workerCost());

  double getWorkerIncrement() => workerLogic.workerIncrement();

  Duration getWorkerDuration() =>
      Duration(milliseconds: workerLogic.workerDurationMilliseconds().toInt());

  String getWorkerDurationString() =>
      (workerLogic.workerDurationMilliseconds() / 1000).toString();

  String getWorkerDecreaseDurationCost() =>
      NumberFormat.compact().format(workerLogic.workerDecreaseDurationCost());

  double shouldAnimateWorker() => workerLogic.shouldAnimateWorker();

  double wasWorkerInitiated = 0;

  Timer workerTimer = Timer(Duration(milliseconds: 0), () {});

  void workerTimerStart(controller) {
    clickerFunctions.timerStart(
        controller,
        workerTimer,
        getWorkerDuration(),
        () => autoClickLogic.workerBuysAutoClicks(workerLogic.workerNumber()),
        () => notifyListeners());
  }

  void buyWorker(controller) {
    if (moneyLogic.canUpgrade(workerLogic.workerCost())) {
      moneyLogic.decreaseMoney(workerLogic.workerCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getWorkerIncrement(),
          costOne: workerLogic.workerCostOne(),
          shouldAnimate: shouldAnimateWorker(),
          numberToChange: workerLogic.workerNumber(),
          boxCostOneName: workerLogic.workerCostOneString,
          boxCostName: workerLogic.workerCostString,
          boxNumberName: workerLogic.workerNumberString,
          boxShouldAnimate: workerLogic.shouldAnimateWorkerString);
      notifyListeners();
      initialWorkerTimer(controller);
    }
  }

  void initialWorkerTimer(controller) {
    if (shouldAnimateWorker() == 1.0 && wasWorkerInitiated == 0) {
      wasWorkerInitiated++;
      controller.forward();
      workerTimerStart(controller);
    }
  }

  bool isWorkerVisible() =>
      workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber());

  double showedWorker() => box.get('showedWorker', defaultValue: 0.0) as double;

  void updateShowedWorker() {
    box.put('showedWorker', 1.0);
  }

  void updateWorkerIncrement() {
    clickerFunctions.updateIncrement(
        increment: getWorkerIncrement(),
        cost: workerLogic.workerCost(),
        costOne: workerLogic.workerCostOne(),
        boxIncrementName: workerLogic.workerIncrementString,
        boxCostName: workerLogic.workerCostString,
        boxCostOneName: workerLogic.workerCostOneString);
    notifyListeners();
  }

  bool canDecreaseWorkerDuration() {
    return moneyLogic.canUpgrade(workerLogic.workerDecreaseDurationCost());
  }

  void decreaseWorkerDuration(controller) {
    moneyLogic.decreaseMoney(workerLogic.workerDecreaseDurationCost());
    workerLogic.decreaseWorkerDuration();
    workerLogic.increaseWorkerDecreaseDurationCost();
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // manager

  String getManagerNumber() =>
      NumberFormat.compact().format(managerLogic.managerNumber());

  String getManagerCost() =>
      NumberFormat.compact().format(managerLogic.managerCost());

  double getManagerIncrement() => managerLogic.managerIncrement();

  Duration getManagerDuration() => Duration(
      milliseconds: managerLogic.managerDurationMilliseconds().toInt());

  String getManagerDurationString() =>
      (managerLogic.managerDurationMilliseconds() / 1000).toString();

  String getManagerDecreaseDurationCost() =>
      NumberFormat.compact().format(managerLogic.managerDecreaseDurationCost());

  double shouldAnimateManager() => managerLogic.shouldAnimateManager();

  double wasManagerInitiated = 0;

  Timer managerTimer = Timer(Duration(milliseconds: 0), () {});

  void managerTimerStart(controller) {
    clickerFunctions.timerStart(
        controller,
        managerTimer,
        getManagerDuration(),
        () => workerLogic.managerBuysWorkers(managerLogic.managerNumber()),
        () => notifyListeners());
  }

  void buyManager(controller) {
    if (moneyLogic.canUpgrade(managerLogic.managerCost())) {
      moneyLogic.decreaseMoney(managerLogic.managerCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getManagerIncrement(),
          costOne: managerLogic.managerCostOne(),
          shouldAnimate: shouldAnimateManager(),
          numberToChange: managerLogic.managerNumber(),
          boxCostOneName: managerLogic.managerCostOneString,
          boxCostName: managerLogic.managerCostString,
          boxNumberName: managerLogic.managerNumberString,
          boxShouldAnimate: managerLogic.shouldAnimateManagerString);
      notifyListeners();
      initialManagerTimer(controller);
    }
  }

  void initialManagerTimer(controller) {
    if (shouldAnimateManager() == 1.0 && wasManagerInitiated == 0) {
      controller.forward();
      managerTimerStart(controller);
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
    clickerFunctions.updateIncrement(
        increment: getManagerIncrement(),
        cost: managerLogic.managerCost(),
        costOne: managerLogic.managerCostOne(),
        boxIncrementName: managerLogic.managerIncrementString,
        boxCostName: managerLogic.managerCostString,
        boxCostOneName: managerLogic.managerCostOneString);
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
