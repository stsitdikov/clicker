import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/clicker_functions.dart';
import 'package:clicker/logic/constants.dart';

class ClickerBrain extends ChangeNotifier {
  ClickerFunctions clickerFunctions;

  ClickerBrain(this.clickerFunctions);

  Box box = Hive.box<double>(kClickerBrainBox);
  void clearBox() => box.clear();

  // money

  double getMoney() => box.get('money', defaultValue: 0.0) as double;

  void decreaseMoney(amount) => box.put('money', (getMoney() - amount));

  String getMoneyString() => NumberFormat.compact().format(getMoney());

  void clickIncreaseMoney() {
    box.put('money', (getMoney() + getClickAmount()));
    notifyListeners();
  }

  // main tab flexes

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

  // launch parameters

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

  // rows

  double getClickAmount() =>
      box.get('ClickAmount', defaultValue: kDefaultClickAmount);

  String getClickAmountString() =>
      NumberFormat.compact().format(getClickAmount());

  double getCost(which) =>
      box.get('${which}Cost', defaultValue: kMapOfDefaultCosts[which]);

  double getCostOne(which) =>
      box.get('${which}CostOne', defaultValue: kMapOfDefaultCosts[which]);

  String getCostString(which) => NumberFormat.compact().format(getCost(which));

  double getIncrement(which) => box.get('${which}Increment', defaultValue: 1.0);

  double getNumber(which) => box.get('${which}Number', defaultValue: 0.0);

  String getNumberString(which) =>
      NumberFormat.compact().format(getNumber(which));

  Duration getDuration(which) =>
      Duration(milliseconds: getDurationDouble(which).toInt());

  String getDurationString(which) =>
      (getDurationDouble(which) / 1000).toString();

  double getDurationDouble(which) => box.get('${which}DurationMilliseconds',
      defaultValue: kMapOfDefaultDurations[which]);

  double shouldAnimate(which) =>
      box.get('shouldAnimate$which', defaultValue: 0.0);

  void upgradeRow(name, controller) {
    if (getMoney() >= getCost(name)) {
      decreaseMoney(getCost(name));
      clickerFunctions.upgradeRow(
          name: name,
          increment: getIncrement(name),
          costOne: getCostOne(name),
          shouldAnimate: name == kClickName ? 1.0 : shouldAnimate(name),
          numberToChange:
              name == kClickName ? getClickAmount() : getNumber(name));
      notifyListeners();
      if (name != kClickName) {
        initiateTimer(name, controller);
      }
    }
  }

  void updateIncrement(name) {
    clickerFunctions.updateIncrement(
        name: name, increment: getIncrement(name), costOne: getCostOne(name));
    notifyListeners();
  }

  // visibility

  double isVisibleDouble(which) =>
      box.get('is${which}Visible', defaultValue: 0.0);

  bool isVisible(which) {
    if (which == kAutoClickName) {
      if (isVisibleDouble(which) == 0.0 &&
          getMoney() >= kMapOfVisibilityRequirements[which]) {
        box.put('is${which}Visible', 1.0);
      }
      return isVisibleDouble(which) == 1.0;
    } else {
      if (isVisibleDouble(which) == 0.0 &&
          getNumber(
                kListOfNamesExceptClick[
                    (kListOfNamesExceptClick.indexOf(which) - 1)],
              ) >=
              kMapOfVisibilityRequirements[which]) {
        box.put('is${which}Visible', 1.0);
      }
      return isVisibleDouble(which) == 1.0;
    }
  }

  double showedRow(which) =>
      box.get('showed$which', defaultValue: 0.0) as double;

  void updateShowedRow(which) => box.put('showed$which', 1.0);

  bool canShowGlobalUpgrade(which) =>
      getMoney() >= getDecreaseDurationCost(which);

  double showedGlobalUpgrade(which) =>
      box.get('showed${which}GlobalUpgrade', defaultValue: 0.0) as double;

  void updateShowedGlobalUpgrade(which, how, shouldNotify) {
    box.put('showed${which}GlobalUpgrade', how);
    if (shouldNotify == true) {
      notifyListeners();
    }
  }

  // timers

  void timerFunction(name) {
    if (name == kAutoClickName) {
      box.put('money', (getMoney() + getNumber(name) * getClickAmount()));
    } else {
      String previousRowName =
          kListOfNamesExceptClick[(kListOfNamesExceptClick.indexOf(name) - 1)];
      box.put('${previousRowName}Number',
          (getNumber(previousRowName) + getNumber(name)));
    }
  }

  Timer autoClickTimer = Timer(Duration(milliseconds: 0), () {});
  Timer workerTimer = Timer(Duration(milliseconds: 0), () {});
  Timer managerTimer = Timer(Duration(milliseconds: 0), () {});
  Timer ceoTimer = Timer(Duration(milliseconds: 0), () {});
  Timer millionaireTimer = Timer(Duration(milliseconds: 0), () {});

  void initialTimers(animationControllerList) {
    int i = 0;
    for (String name in kListOfNamesExceptClick) {
      initiateTimer(name, animationControllerList[i]);
      i++;
    }
  }

  Map wasInitiated = {
    kAutoClickName: 0,
    kWorkerName: 0,
    kManagerName: 0,
    kCeoName: 0,
    kMillionaireName: 0,
  };

  void initiateTimer(name, controller) {
    if (shouldAnimate(name) == 1.0 && wasInitiated[name] == 0) {
      wasInitiated[name]++;
      controller.forward();
      timerStart(name, controller);
    }
  }

  void cancelTimers() {
    autoClickTimer.cancel();
    workerTimer.cancel();
    managerTimer.cancel();
    ceoTimer.cancel();
    millionaireTimer.cancel();
  }

  void timerStart(name, controller) {
    if (name == kAutoClickName) {
      autoClickTimer = timerNew(name, controller);
    } else if (name == kWorkerName) {
      workerTimer = timerNew(name, controller);
    } else if (name == kManagerName) {
      managerTimer = timerNew(name, controller);
    } else if (name == kCeoName) {
      ceoTimer = timerNew(name, controller);
    } else if (name == kMillionaireName) {
      millionaireTimer = timerNew(name, controller);
    }
  }

  Timer timerNew(name, controller) => Timer.periodic(
        getDuration(name),
        (timer) {
          timerFunction(name);
          controller.reset();
          controller.forward();
          notifyListeners();
        },
      );

  // global upgrades

  bool canDecreaseDuration(which, decreaseConstant) =>
      getDurationDouble(which) > decreaseConstant;

  void decreaseDuration(which) => box.put('${which}DurationMilliseconds',
      (getDurationDouble(which) - kMapOfDecreaseDurationIncrements[which]));

  double getDecreaseDurationCost(which) =>
      box.get('${which}DecreaseDurationCost',
          defaultValue: kMapOfDefaultDecreaseDurationCosts[which]);

  String getDecreaseDurationCostString(which) {
    return NumberFormat.compact().format(getDecreaseDurationCost(which));
  }

  void increaseDecreaseDurationCost(which) => box.put(
      '${which}DecreaseDurationCost',
      (getDecreaseDurationCost(which) * kMainIncrement));

  // autoclicker

  void decreaseAutoClickDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kAutoClickName));
    decreaseDuration(kAutoClickName);
    increaseDecreaseDurationCost(kAutoClickName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // worker

  void decreaseWorkerDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kWorkerName));
    decreaseDuration(kWorkerName);
    increaseDecreaseDurationCost(kWorkerName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // manager

  void decreaseManagerDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kManagerName));
    decreaseDuration(kManagerName);
    increaseDecreaseDurationCost(kManagerName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // ceo

  void decreaseCeoDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kCeoName));
    decreaseDuration(kCeoName);
    increaseDecreaseDurationCost(kCeoName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // millionaire

  void decreaseMillionaireDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kMillionaireName));
    decreaseDuration(kMillionaireName);
    increaseDecreaseDurationCost(kMillionaireName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }
}
