import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/money_logic.dart';
import 'package:clicker/logic/clicker_functions.dart';
import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/1_click_row_logic.dart';
import 'package:clicker/logic/2_autoclick_logic.dart';
import 'package:clicker/logic/3_worker_logic.dart';
import 'package:clicker/logic/4_manager_logic.dart';
import 'package:clicker/logic/5_ceo_logic.dart';
import 'package:clicker/logic/6_millionaire_row_logic.dart';

class ClickerBrain extends ChangeNotifier {
  MoneyLogic moneyLogic;
  ClickerFunctions clickerFunctions;
  ClickRowLogic clickRowLogic;
  AutoClickLogic autoClickLogic;
  WorkerLogic workerLogic;
  ManagerLogic managerLogic;
  CeoLogic ceoLogic;
  MillionaireLogic millionaireLogic;

  ClickerBrain(
      this.moneyLogic,
      this.clickerFunctions,
      this.clickRowLogic,
      this.autoClickLogic,
      this.workerLogic,
      this.managerLogic,
      this.ceoLogic,
      this.millionaireLogic);

  Box box = Hive.box<double>(kClickerBrainBox);

  double getMoney() => moneyLogic.money();

  String getMoneyString() => NumberFormat.compact().format(getMoney());

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

  // double firstLaunch() => box.get('firstLaunch', defaultValue: 1.0);
  //
  // void notFirstLaunch() => box.put('firstLaunch', (firstLaunch() + 1.0));

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

  void initialTimers(animationControllerList) {
    initialAutoClickTimer(animationControllerList[0]);
    initialWorkerTimer(animationControllerList[1]);
    initialManagerTimer(animationControllerList[2]);
    initialCeoTimer(animationControllerList[3]);
    initialMillionaireTimer(animationControllerList[4]);
  }

  void cancelTimers() {
    autoClickTimer.cancel();
    workerTimer.cancel();
    managerTimer.cancel();
    ceoTimer.cancel();
    millionaireTimer.cancel();
  }

  String getCost(which) {
    return NumberFormat.compact().format(whichCost(which));
  }

  double whichCost(which) {
    if (which == kClickName) {
      return clickRowLogic.clickCost();
    } else if (which == kAutoClickName) {
      return autoClickLogic.autoClickCost();
    } else if (which == kWorkerName) {
      return workerLogic.workerCost();
    } else if (which == kManagerName) {
      return managerLogic.managerCost();
    } else if (which == kCeoName) {
      return ceoLogic.ceoCost();
    } else if (which == kMillionaireName) {
      return millionaireLogic.millionaireCost();
    } else {
      return 0.0;
    }
  }

  double getIncrement(which) {
    if (which == kClickName) {
      return clickRowLogic.clickIncrement();
    } else if (which == kAutoClickName) {
      return autoClickLogic.autoClickIncrement();
    } else if (which == kWorkerName) {
      return workerLogic.workerIncrement();
    } else if (which == kManagerName) {
      return managerLogic.managerIncrement();
    } else if (which == kCeoName) {
      return ceoLogic.ceoIncrement();
    } else if (which == kMillionaireName) {
      return millionaireLogic.millionaireIncrement();
    } else {
      return 0.0;
    }
  }

  String getNumber(which) {
    return NumberFormat.compact().format(whichNumber(which));
  }

  double whichNumber(which) {
    if (which == kAutoClickName) {
      return autoClickLogic.autoClickNumber();
    } else if (which == kWorkerName) {
      return workerLogic.workerNumber();
    } else if (which == kManagerName) {
      return managerLogic.managerNumber();
    } else if (which == kCeoName) {
      return ceoLogic.ceoNumber();
    } else if (which == kMillionaireName) {
      return millionaireLogic.millionaireNumber();
    } else {
      return 0.0;
    }
  }

  Duration getDuration(which) =>
      Duration(milliseconds: whichDuration(which).toInt());

  String getDurationString(which) => (whichDuration(which) / 1000).toString();

  bool canDecreaseDuration(which, decreaseConstant) =>
      whichDuration(which) > decreaseConstant;

  double whichDuration(which) {
    if (which == kAutoClickName) {
      return autoClickLogic.autoClickDurationMilliseconds();
    } else if (which == kWorkerName) {
      return workerLogic.workerDurationMilliseconds();
    } else if (which == kManagerName) {
      return managerLogic.managerDurationMilliseconds();
    } else if (which == kCeoName) {
      return ceoLogic.ceoDurationMilliseconds();
    } else if (which == kMillionaireName) {
      return millionaireLogic.millionaireDurationMilliseconds();
    } else {
      return 0.0;
    }
  }

  String getDecreaseDurationCost(which) {
    return NumberFormat.compact().format(whichDecreaseDurationCost(which));
  }

  bool canShowGlobalUpgrade(which) =>
      moneyLogic.canUpgrade(whichDecreaseDurationCost(which));

  double whichDecreaseDurationCost(which) {
    if (which == kAutoClickName) {
      return autoClickLogic.autoClickDecreaseDurationCost();
    } else if (which == kWorkerName) {
      return workerLogic.workerDecreaseDurationCost();
    } else if (which == kManagerName) {
      return managerLogic.managerDecreaseDurationCost();
    } else if (which == kCeoName) {
      return ceoLogic.ceoDecreaseDurationCost();
    } else if (which == kMillionaireName) {
      return millionaireLogic.millionaireDecreaseDurationCost();
    } else {
      return 0.0;
    }
  }

  double shouldAnimate(which) {
    if (which == kAutoClickName) {
      return autoClickLogic.shouldAnimateAutoClick();
    } else if (which == kWorkerName) {
      return workerLogic.shouldAnimateWorker();
    } else if (which == kManagerName) {
      return managerLogic.shouldAnimateManager();
    } else if (which == kCeoName) {
      return ceoLogic.shouldAnimateCeo();
    } else if (which == kMillionaireName) {
      return millionaireLogic.shouldAnimateMillionaire();
    } else {
      return 0.0;
    }
  }

  bool isVisible(which) {
    if (which == kAutoClickName) {
      return autoClickLogic.isAutoClickVisible(getMoney());
    } else if (which == kWorkerName) {
      return workerLogic.isWorkerVisible(autoClickLogic.autoClickNumber());
    } else if (which == kManagerName) {
      return managerLogic.isManagerVisible(workerLogic.workerNumber());
    } else if (which == kCeoName) {
      return ceoLogic.isCeoVisible(managerLogic.managerNumber());
    } else if (which == kMillionaireName) {
      return millionaireLogic.isMillionaireVisible(ceoLogic.ceoNumber());
    } else {
      return false;
    }
  }

  double showedRow(which) =>
      box.get('showed$which', defaultValue: 0.0) as double;

  void updateShowedRow(which) => box.put('showed$which', 1.0);

  double showedGlobalUpgrade(which) =>
      box.get('showed${which}GlobalUpgrade', defaultValue: 0.0) as double;

  void updateShowedGlobalUpgrade(which, how, shouldNotify) {
    box.put('showed${which}GlobalUpgrade', how);
    if (shouldNotify == true) {
      notifyListeners();
    }
  }

  // click row

  String getClickAmount() =>
      NumberFormat.compact().format(clickRowLogic.clickAmount());

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
        increment: getIncrement(kClickName),
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
        increment: getIncrement(kClickName),
        cost: clickRowLogic.clickCost(),
        costOne: clickRowLogic.clickCostOne(),
        boxIncrementName: clickRowLogic.clickIncrementString,
        boxCostName: clickRowLogic.clickCostString,
        boxCostOneName: clickRowLogic.clickCostOneString);
    notifyListeners();
  }

  // autoclicker

  double wasAutoClickInitiated = 0;

  Timer autoClickTimer = Timer(Duration(milliseconds: 0), () {});

  void autoClickTimerStart(controller) {
    autoClickTimer = Timer.periodic(
      getDuration(kAutoClickName),
      (timer) {
        moneyLogic.autoClickIncreaseMoney();
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void buyAutoClicker(controller) {
    if (moneyLogic.canUpgrade(autoClickLogic.autoClickCost())) {
      moneyLogic.decreaseMoney(autoClickLogic.autoClickCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getIncrement(kAutoClickName),
          costOne: autoClickLogic.autoClickCostOne(),
          shouldAnimate: shouldAnimate(kAutoClickName),
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
    if (shouldAnimate(kAutoClickName) == 1.0 && wasAutoClickInitiated == 0) {
      wasAutoClickInitiated++;
      controller.forward();
      autoClickTimerStart(controller);
    }
  }

  void updateAutoClickIncrement() {
    clickerFunctions.updateIncrement(
        increment: getIncrement(kAutoClickName),
        cost: autoClickLogic.autoClickCost(),
        costOne: autoClickLogic.autoClickCostOne(),
        boxIncrementName: autoClickLogic.autoClickIncrementString,
        boxCostName: autoClickLogic.autoClickCostString,
        boxCostOneName: autoClickLogic.autoClickCostOneString);
    notifyListeners();
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

  double wasWorkerInitiated = 0;

  Timer workerTimer = Timer(Duration(milliseconds: 0), () {});

  void workerTimerStart(controller) {
    workerTimer = Timer.periodic(
      getDuration(kWorkerName),
      (timer) {
        autoClickLogic.workerBuysAutoClicks(workerLogic.workerNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void buyWorker(controller) {
    if (moneyLogic.canUpgrade(workerLogic.workerCost())) {
      moneyLogic.decreaseMoney(workerLogic.workerCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getIncrement(kWorkerName),
          costOne: workerLogic.workerCostOne(),
          shouldAnimate: shouldAnimate(kWorkerName),
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
    if (shouldAnimate(kWorkerName) == 1.0 && wasWorkerInitiated == 0) {
      wasWorkerInitiated++;
      controller.forward();
      workerTimerStart(controller);
    }
  }

  void updateWorkerIncrement() {
    clickerFunctions.updateIncrement(
        increment: getIncrement(kWorkerName),
        cost: workerLogic.workerCost(),
        costOne: workerLogic.workerCostOne(),
        boxIncrementName: workerLogic.workerIncrementString,
        boxCostName: workerLogic.workerCostString,
        boxCostOneName: workerLogic.workerCostOneString);
    notifyListeners();
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

  double wasManagerInitiated = 0;

  Timer managerTimer = Timer(Duration(milliseconds: 0), () {});

  void managerTimerStart(controller) {
    managerTimer = Timer.periodic(
      getDuration(kManagerName),
      (timer) {
        workerLogic.managerBuysWorkers(managerLogic.managerNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void buyManager(controller) {
    if (moneyLogic.canUpgrade(managerLogic.managerCost())) {
      moneyLogic.decreaseMoney(managerLogic.managerCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getIncrement(kManagerName),
          costOne: managerLogic.managerCostOne(),
          shouldAnimate: shouldAnimate(kManagerName),
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
    if (shouldAnimate(kManagerName) == 1.0 && wasManagerInitiated == 0) {
      wasManagerInitiated++;
      controller.forward();
      managerTimerStart(controller);
    }
  }

  void updateManagerIncrement() {
    clickerFunctions.updateIncrement(
        increment: getIncrement(kManagerName),
        cost: managerLogic.managerCost(),
        costOne: managerLogic.managerCostOne(),
        boxIncrementName: managerLogic.managerIncrementString,
        boxCostName: managerLogic.managerCostString,
        boxCostOneName: managerLogic.managerCostOneString);
    notifyListeners();
  }

  void decreaseManagerDuration(controller) {
    moneyLogic.decreaseMoney(managerLogic.managerDecreaseDurationCost());
    managerLogic.decreaseManagerDuration();
    managerLogic.increaseManagerDecreaseDurationCost();
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // ceo

  double wasCeoInitiated = 0;

  Timer ceoTimer = Timer(Duration(milliseconds: 0), () {});

  void ceoTimerStart(controller) {
    ceoTimer = Timer.periodic(
      getDuration(kCeoName),
      (timer) {
        managerLogic.ceoBuysManagers(ceoLogic.ceoNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void buyCeo(controller) {
    if (moneyLogic.canUpgrade(ceoLogic.ceoCost())) {
      moneyLogic.decreaseMoney(ceoLogic.ceoCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getIncrement(kCeoName),
          costOne: ceoLogic.ceoCostOne(),
          shouldAnimate: ceoLogic.shouldAnimateCeo(),
          numberToChange: ceoLogic.ceoNumber(),
          boxCostOneName: ceoLogic.ceoCostOneString,
          boxCostName: ceoLogic.ceoCostString,
          boxNumberName: ceoLogic.ceoNumberString,
          boxShouldAnimate: ceoLogic.shouldAnimateCeoString);
      notifyListeners();
      initialCeoTimer(controller);
    }
  }

  void initialCeoTimer(controller) {
    if (shouldAnimate(kCeoName) == 1.0 && wasCeoInitiated == 0) {
      wasCeoInitiated++;
      controller.forward();
      ceoTimerStart(controller);
    }
  }

  void updateCeoIncrement() {
    clickerFunctions.updateIncrement(
        increment: getIncrement(kCeoName),
        cost: ceoLogic.ceoCost(),
        costOne: ceoLogic.ceoCostOne(),
        boxIncrementName: ceoLogic.ceoIncrementString,
        boxCostName: ceoLogic.ceoCostString,
        boxCostOneName: ceoLogic.ceoCostOneString);
    notifyListeners();
  }

  void decreaseCeoDuration(controller) {
    moneyLogic.decreaseMoney(ceoLogic.ceoDecreaseDurationCost());
    ceoLogic.decreaseCeoDuration();
    ceoLogic.increaseCeoDecreaseDurationCost();
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // millionaire

  double wasMillionaireInitiated = 0;

  Timer millionaireTimer = Timer(Duration(milliseconds: 0), () {});

  void millionaireTimerStart(controller) {
    millionaireTimer = Timer.periodic(
      getDuration(kMillionaireName),
      (timer) {
        ceoLogic.millionaireBuysCeos(millionaireLogic.millionaireNumber());
        controller.reset();
        controller.forward();
        notifyListeners();
      },
    );
  }

  void buyMillionaire(controller) {
    if (moneyLogic.canUpgrade(millionaireLogic.millionaireCost())) {
      moneyLogic.decreaseMoney(millionaireLogic.millionaireCost());
      clickerFunctions.upgradeRow(
          isClickRow: false,
          increment: getIncrement(kMillionaireName),
          costOne: millionaireLogic.millionaireCostOne(),
          shouldAnimate: millionaireLogic.shouldAnimateMillionaire(),
          numberToChange: millionaireLogic.millionaireNumber(),
          boxCostOneName: millionaireLogic.millionaireCostOneString,
          boxCostName: millionaireLogic.millionaireCostString,
          boxNumberName: millionaireLogic.millionaireNumberString,
          boxShouldAnimate: millionaireLogic.shouldAnimateMillionaireString);
      notifyListeners();
      initialMillionaireTimer(controller);
    }
  }

  void initialMillionaireTimer(controller) {
    if (shouldAnimate(kMillionaireName) == 1.0 &&
        wasMillionaireInitiated == 0) {
      wasMillionaireInitiated++;
      controller.forward();
      millionaireTimerStart(controller);
    }
  }

  void updateMillionaireIncrement() {
    clickerFunctions.updateIncrement(
        increment: getIncrement(kMillionaireName),
        cost: millionaireLogic.millionaireCost(),
        costOne: millionaireLogic.millionaireCostOne(),
        boxIncrementName: millionaireLogic.millionaireIncrementString,
        boxCostName: millionaireLogic.millionaireCostString,
        boxCostOneName: millionaireLogic.millionaireCostOneString);
    notifyListeners();
  }

  void decreaseMillionaireDuration(controller) {
    moneyLogic
        .decreaseMoney(millionaireLogic.millionaireDecreaseDurationCost());
    millionaireLogic.decreaseMillionaireDuration();
    millionaireLogic.increaseMillionaireDecreaseDurationCost();
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }
}
