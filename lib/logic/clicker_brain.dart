import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/number_abbreviations.dart';

class ClickerBrain extends ChangeNotifier {
  NumberAbbreviations numberAbbreviations;
  ClickerBrain(this.numberAbbreviations);

  Box box = Hive.box<double>(kClickerBrainBox);
  void clearBox() => box.clear();

  // money

  double getMoney() => box.get('money', defaultValue: 0.0) as double;

  void decreaseMoney(amount) => box.put(
      'money',
      double.parse(
        (getMoney() - amount).toStringAsFixed(kHiveDecimals),
      ));

  String getMoneyString() => numberAbbreviations.getNumberString(getMoney());

  void clickIncreaseMoney() {
    if (getMoney() <= kMaxDouble) {
      box.put(
          'money',
          double.parse(
            (getMoney() + getClickAmount()).toStringAsFixed(kHiveDecimals),
          ));
      notifyListeners();
    }
  }

  // main tab flexes

  double listFlex() => box.get('listFlex', defaultValue: 2.0);

  double itemCount() => box.get('itemCount', defaultValue: 2.0);

  void increaseListFlex() {
    if (listFlex() < 3.0) {
      box.put('listFlex', (listFlex() + 1.0));
      box.put('itemCount', (itemCount() + 1.0));
    } else if (listFlex() == 3.0 &&
        itemCount() <= kListOfNamesExceptClick.length) {
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
      numberAbbreviations.getNumberString(getClickAmount());

  double getCost(which) =>
      box.get('${which}Cost', defaultValue: kMapOfDefaultCosts[which]);

  double getCostOne(which) =>
      box.get('${which}CostOne', defaultValue: kMapOfDefaultCosts[which]);

  String getCostString(which) =>
      numberAbbreviations.getNumberString(getCost(which));

  double getIncrement(which) => box.get('${which}Increment', defaultValue: 1.0);

  double getNumber(which) => box.get('${which}Number', defaultValue: 0.0);

  String getNumberString(which) =>
      numberAbbreviations.getNumberString(getNumber(which));

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
    double upgradeIncrement = kMapOfUpgradeCostIncrements[name];

    if (getMoney() >= getCost(name)) {
      decreaseMoney(getCost(name));
      double newCost = double.parse(
        (costOne * pow(upgradeIncrement, increment))
            .toStringAsFixed(kHiveDecimals),
      );
      if (increment == 1.0) {
        box.put('${name}CostOne', newCost);
        box.put('${name}Cost', newCost);
        incrementalCost(name, 0.0, increment, costOne, upgradeIncrement);
        if (name == kClickName) {
          updateNumberClickRow(numberToChange, increment);
        } else {
          updateNumber(name, numberToChange, increment, shouldAnimateRow);
        }
      } else {
        box.put('${name}CostOne', newCost);
        box.put('${name}Cost', newCost);
        incrementalCost(
            name,
            costOne * pow(upgradeIncrement, increment),
            increment,
            costOne * pow(upgradeIncrement, increment),
            upgradeIncrement);
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

  void updateNumberClickRow(numberToChange, increment) => box.put(
      'ClickAmount',
      double.parse(
        (numberToChange * pow(kClickAmountIncreaseIncrement, increment))
            .toStringAsFixed(kHiveDecimals),
      ));

  void updateNumber(name, numberToChange, increment, shouldAnimate) {
    box.put(
        '${name}Number',
        double.parse(
          (numberToChange + increment).toStringAsFixed(kHiveDecimals),
        ));
    if (shouldAnimate == 0.0) {
      box.put('shouldAnimate$name', 1.0);
    }
  }

  void updateIncrement(name) {
    double increment = getIncrement(name);
    double costOne = getCostOne(name);
    double upgradeIncrement = kMapOfUpgradeCostIncrements[name];

    if (increment == 1.0)
      incrementalCost(name, costOne, 10.0, costOne, upgradeIncrement);
    else if (increment == 10.0)
      incrementalCost(name, costOne, 100.0, costOne, upgradeIncrement);
    else if (increment == 100.0) returnToIncrementOne(name, costOne);

    notifyListeners();
  }

  void returnToIncrementOne(name, costOne) {
    box.put('${name}Increment', 1.0);
    box.put('${name}Cost', costOne);
  }

  void incrementalCost(name, newValue, increment, costOne, upgradeIncrement) {
    for (var i = 1; i <= increment; i++) {
      newValue = newValue + costOne * pow(upgradeIncrement, i);
    }
    if (newValue <= kMaxDouble) {
      double newCost = double.parse(
        newValue.toStringAsFixed(kHiveDecimals),
      );
      box.put('${name}Increment', increment);
      box.put('${name}Cost', newCost);
    } else {
      returnToIncrementOne(name, costOne);
    }
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
      if (getNumber(name) <= kMaxDouble) {
        box.put(
            'money',
            double.parse(
              (getMoney() + getNumber(name) * getClickAmount())
                  .toStringAsFixed(kHiveDecimals),
            ));
      }
    } else {
      String previousRowName =
          kListOfNamesExceptClick[(kListOfNamesExceptClick.indexOf(name) - 1)];
      if (getNumber(previousRowName) <= kMaxDouble) {
        box.put('${previousRowName}Number',
            (getNumber(previousRowName) + getNumber(name)));
      }
    }
  }

  Timer autoClickTimer = Timer(Duration(milliseconds: 0), () {});
  Timer workerTimer = Timer(Duration(milliseconds: 0), () {});
  Timer managerTimer = Timer(Duration(milliseconds: 0), () {});
  Timer ceoTimer = Timer(Duration(milliseconds: 0), () {});
  Timer millionaireTimer = Timer(Duration(milliseconds: 0), () {});
  Timer presidentTimer = Timer(Duration(milliseconds: 0), () {});
  Timer jeffreyTimer = Timer(Duration(milliseconds: 0), () {});

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
    kPresidentName: 0,
    kJeffreyName: 0,
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
    presidentTimer.cancel();
    jeffreyTimer.cancel();
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
    } else if (name == kPresidentName) {
      presidentTimer = timerNew(name, controller);
    } else if (name == kJeffreyName) {
      jeffreyTimer = timerNew(name, controller);
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

  bool canDecreaseDuration(which) =>
      getDurationDouble(which) > (kMapOfDefaultDurations[which] / 2);

  void decreaseDuration(name) {
    decreaseMoney(getDecreaseDurationCost(name));
    box.put('${name}DurationMilliseconds',
        (getDurationDouble(name) - kMapOfDecreaseDurationIncrements[name]));
    box.put('${name}DecreaseDurationCost',
        (getDecreaseDurationCost(name) * kDecreaseDurationIncrement));
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  double getDecreaseDurationCost(which) =>
      box.get('${which}DecreaseDurationCost',
          defaultValue: kMapOfDefaultDecreaseDurationCosts[which]);

  String getDecreaseDurationCostString(which) {
    return numberAbbreviations.getNumberString(getDecreaseDurationCost(which));
  }
}
