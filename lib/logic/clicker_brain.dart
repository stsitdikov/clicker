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

  double getMoney() => box.get('money', defaultValue: 0.0) as double;

  void decreaseMoney(amount) => box.put('money', (getMoney() - amount));

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

  double getCost(which) =>
      box.get('${which}Cost', defaultValue: kMapOfDefaultCosts[which]);

  double getCostOne(which) =>
      box.get('${which}CostOne', defaultValue: kMapOfDefaultCosts[which]);

  String getCostString(which) => NumberFormat.compact().format(getCost(which));

  double getIncrement(which) => box.get('${which}Increment', defaultValue: 1.0);

  double getNumber(which) => box.get('${which}Number', defaultValue: 0.0);

  String getNumberString(which) {
    return NumberFormat.compact().format(getNumber(which));
  }

  Duration getDuration(which) =>
      Duration(milliseconds: getDurationDouble(which).toInt());

  String getDurationString(which) =>
      (getDurationDouble(which) / 1000).toString();

  double getDurationDouble(which) => box.get('${which}DurationMilliseconds',
      defaultValue: kMapOfDefaultDurations[which]);

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

  bool canShowGlobalUpgrade(which) =>
      getMoney() >= getDecreaseDurationCost(which);

  void increaseDecreaseDurationCost(which) => box.put(
      '${which}DecreaseDurationCost',
      (getDecreaseDurationCost(which) * kMainIncrement));

  double shouldAnimate(which) =>
      box.get('shouldAnimate$which', defaultValue: 0.0);

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

  double showedGlobalUpgrade(which) =>
      box.get('showed${which}GlobalUpgrade', defaultValue: 0.0) as double;

  void updateShowedGlobalUpgrade(which, how, shouldNotify) {
    box.put('showed${which}GlobalUpgrade', how);
    if (shouldNotify == true) {
      notifyListeners();
    }
  }

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

  // click row

  double getClickAmount() =>
      box.get('ClickAmount', defaultValue: kDefaultClickAmount);

  String getClickAmountString() =>
      NumberFormat.compact().format(getClickAmount());

  void clickIncreaseMoney() {
    box.put('money', (getMoney() + getClickAmount()));
    notifyListeners();
  }

  void clickUpgrade() {
    if (getMoney() >= getCost(kClickName)) {
      decreaseMoney(getCost(kClickName));
      clickerFunctions.upgradeRow(
          name: kClickName,
          increment: getIncrement(kClickName),
          costOne: getCostOne(kClickName),
          shouldAnimate: 1.0,
          numberToChange: getClickAmount());
      notifyListeners();
    }
  }

  void changeClickIncrement() {
    clickerFunctions.updateIncrement(
        name: kClickName,
        increment: getIncrement(kClickName),
        costOne: getCostOne(kClickName));
    notifyListeners();
  }

  // autoclicker

  double wasAutoClickInitiated = 0;

  void buyAutoClicker(controller) {
    if (getMoney() >= getCost(kAutoClickName)) {
      decreaseMoney(getCost(kAutoClickName));
      clickerFunctions.upgradeRow(
          name: kAutoClickName,
          increment: getIncrement(kAutoClickName),
          costOne: getCostOne(kAutoClickName),
          shouldAnimate: shouldAnimate(kAutoClickName),
          numberToChange: getNumber(kAutoClickName));
      notifyListeners();
      initialAutoClickTimer(controller);
    }
  }

  void initialAutoClickTimer(controller) {
    if (shouldAnimate(kAutoClickName) == 1.0 && wasAutoClickInitiated == 0) {
      wasAutoClickInitiated++;
      controller.forward();
      timerStart(kAutoClickName, controller);
    }
  }

  void updateAutoClickIncrement() {
    clickerFunctions.updateIncrement(
        name: kAutoClickName,
        increment: getIncrement(kAutoClickName),
        costOne: getCostOne(kAutoClickName));
    notifyListeners();
  }

  void decreaseAutoClickDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kAutoClickName));
    decreaseDuration(kAutoClickName);
    increaseDecreaseDurationCost(kAutoClickName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // worker

  double wasWorkerInitiated = 0;

  void buyWorker(controller) {
    if (getMoney() >= getCost(kWorkerName)) {
      decreaseMoney(getCost(kWorkerName));
      clickerFunctions.upgradeRow(
          name: kWorkerName,
          increment: getIncrement(kWorkerName),
          costOne: getCostOne(kWorkerName),
          shouldAnimate: shouldAnimate(kWorkerName),
          numberToChange: getNumber(kWorkerName));
      notifyListeners();
      initialWorkerTimer(controller);
    }
  }

  void initialWorkerTimer(controller) {
    if (shouldAnimate(kWorkerName) == 1.0 && wasWorkerInitiated == 0) {
      wasWorkerInitiated++;
      controller.forward();
      timerStart(kWorkerName, controller);
    }
  }

  void updateWorkerIncrement() {
    clickerFunctions.updateIncrement(
        name: kWorkerName,
        increment: getIncrement(kWorkerName),
        costOne: getCostOne(kWorkerName));
    notifyListeners();
  }

  void decreaseWorkerDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kWorkerName));
    decreaseDuration(kWorkerName);
    increaseDecreaseDurationCost(kWorkerName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // manager

  double wasManagerInitiated = 0;

  void buyManager(controller) {
    if (getMoney() >= getCost(kManagerName)) {
      decreaseMoney(getCost(kManagerName));
      clickerFunctions.upgradeRow(
          name: kManagerName,
          increment: getIncrement(kManagerName),
          costOne: getCostOne(kManagerName),
          shouldAnimate: shouldAnimate(kManagerName),
          numberToChange: getNumber(kManagerName));
      notifyListeners();
      initialManagerTimer(controller);
    }
  }

  void initialManagerTimer(controller) {
    if (shouldAnimate(kManagerName) == 1.0 && wasManagerInitiated == 0) {
      wasManagerInitiated++;
      controller.forward();
      timerStart(kManagerName, controller);
    }
  }

  void updateManagerIncrement() {
    clickerFunctions.updateIncrement(
        name: kManagerName,
        increment: getIncrement(kManagerName),
        costOne: getCostOne(kManagerName));
    notifyListeners();
  }

  void decreaseManagerDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kManagerName));
    decreaseDuration(kManagerName);
    increaseDecreaseDurationCost(kManagerName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // ceo

  double wasCeoInitiated = 0;

  void buyCeo(controller) {
    if (getMoney() >= getCost(kCeoName)) {
      decreaseMoney(getCost(kCeoName));
      clickerFunctions.upgradeRow(
          name: kCeoName,
          increment: getIncrement(kCeoName),
          costOne: getCostOne(kCeoName),
          shouldAnimate: shouldAnimate(kCeoName),
          numberToChange: getNumber(kCeoName));
      notifyListeners();
      initialCeoTimer(controller);
    }
  }

  void initialCeoTimer(controller) {
    if (shouldAnimate(kCeoName) == 1.0 && wasCeoInitiated == 0) {
      wasCeoInitiated++;
      controller.forward();
      timerStart(kCeoName, controller);
    }
  }

  void updateCeoIncrement() {
    clickerFunctions.updateIncrement(
        name: kCeoName,
        increment: getIncrement(kCeoName),
        costOne: getCostOne(kCeoName));
    notifyListeners();
  }

  void decreaseCeoDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kCeoName));
    decreaseDuration(kCeoName);
    increaseDecreaseDurationCost(kCeoName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }

  // millionaire

  double wasMillionaireInitiated = 0;

  void buyMillionaire(controller) {
    if (getMoney() >= getCost(kMillionaireName)) {
      decreaseMoney(getCost(kMillionaireName));
      clickerFunctions.upgradeRow(
          name: kMillionaireName,
          increment: getIncrement(kMillionaireName),
          costOne: getCostOne(kMillionaireName),
          shouldAnimate: shouldAnimate(kMillionaireName),
          numberToChange: getNumber(kMillionaireName));
      notifyListeners();
      initialMillionaireTimer(controller);
    }
  }

  void initialMillionaireTimer(controller) {
    if (shouldAnimate(kMillionaireName) == 1.0 &&
        wasMillionaireInitiated == 0) {
      wasMillionaireInitiated++;
      controller.forward();
      timerStart(kMillionaireName, controller);
    }
  }

  void updateMillionaireIncrement() {
    clickerFunctions.updateIncrement(
        name: kMillionaireName,
        increment: getIncrement(kMillionaireName),
        costOne: getCostOne(kMillionaireName));
    notifyListeners();
  }

  void decreaseMillionaireDuration(controller) {
    decreaseMoney(getDecreaseDurationCost(kMillionaireName));
    decreaseDuration(kMillionaireName);
    increaseDecreaseDurationCost(kMillionaireName);
    launchIsFromGlobalUpgrade();
    cancelTimers();
    notifyListeners();
  }
}
