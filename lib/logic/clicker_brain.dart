import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/constants.dart';

class ClickerBrain extends ChangeNotifier {
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

  // rows getters

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

  // rows functions

  void upgradeRow(name, controller) {
    double increment = getIncrement(name);
    double costOne = getCostOne(name);
    double shouldAnimateRow = name == kClickName ? 1.0 : shouldAnimate(name);
    double numberToChange =
        name == kClickName ? getClickAmount() : getNumber(name);

    if (getMoney() >= getCost(name)) {
      decreaseMoney(getCost(name));
      if (increment == 1.0) {
        box.put('${name}CostOne', costOne * pow(kMainIncrement, increment));
        box.put('${name}Cost', costOne * pow(kMainIncrement, increment));
        incrementalCost(name, 0.0, increment, costOne);
        if (name == kClickName) {
          updateNumberClickRow(numberToChange, increment);
        } else {
          updateNumber(name, numberToChange, increment, shouldAnimateRow);
        }
      } else {
        box.put('${name}CostOne', costOne * pow(kMainIncrement, increment));
        box.put('${name}Cost', costOne * pow(kMainIncrement, increment));
        incrementalCost(name, costOne * pow(kMainIncrement, increment),
            increment, costOne * pow(kMainIncrement, increment));
        if (name == kClickName) {
          updateNumberClickRow(numberToChange, increment);
        } else {
          updateNumber(name, numberToChange, increment, shouldAnimateRow);
        }
      }
      notifyListeners();
      if (name != kClickName) {
        initiateTimer(name, controller);
      }
    }
  }

  void updateNumberClickRow(numberToChange, increment) =>
      box.put('ClickAmount', numberToChange * pow(kMainIncrement, increment));

  void updateNumber(name, numberToChange, increment, shouldAnimate) {
    box.put('${name}Number', numberToChange + increment);
    if (shouldAnimate == 0.0) {
      box.put('shouldAnimate$name', 1.0);
    }
  }

  void updateIncrement(name) {
    double increment = getIncrement(name);
    double costOne = getCostOne(name);

    if (increment == 1.0) {
      box.put('${name}Increment', 10.0);
      box.put('${name}Cost', costOne);
      incrementalCost(name, costOne, 10.0, costOne);
    } else if (increment == 10.0) {
      box.put('${name}Increment', 100.0);
      box.put('${name}Cost', costOne);
      incrementalCost(name, costOne, 100.0, costOne);
    } else if (increment == 100.0) {
      box.put('${name}Increment', 1.0);
      box.put('${name}Cost', costOne);
    }
    notifyListeners();
  }

  void incrementalCost(name, newValue, increment, costOne) {
    double newCost = newValue;
    for (var i = 1; i <= increment; i++) {
      newCost = newCost + costOne * pow(kMainIncrement, i);
    }
    box.put('${name}Cost', newCost);
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

  void initialTimers(animationControllerMap) {
    for (String name in kListOfNamesExceptClick) {
      initiateTimer(name, animationControllerMap[name]);
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

  void decreaseDuration(name) {
    decreaseMoney(getDecreaseDurationCost(name));
    box.put('${name}DurationMilliseconds',
        (getDurationDouble(name) - kMapOfDecreaseDurationIncrements[name]));
    box.put('${name}DecreaseDurationCost',
        (getDecreaseDurationCost(name) * kMainIncrement));
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  double getDecreaseDurationCost(which) =>
      box.get('${which}DecreaseDurationCost',
          defaultValue: kMapOfDefaultDecreaseDurationCosts[which]);

  String getDecreaseDurationCostString(which) {
    return NumberFormat.compact().format(getDecreaseDurationCost(which));
  }
}
