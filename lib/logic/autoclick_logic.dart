import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class AutoClickLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  Duration autoClickerDuration = Duration(seconds: 3);

  // getters

  double autoClickCost() =>
      box.get('autoClickCost', defaultValue: kDefaultAutoClickCost) as double;

  double autoClickCostOne() =>
      box.get('autoClickCostOne', defaultValue: kDefaultAutoClickCostOne)
          as double;

  double autoClickNumber() =>
      box.get('autoClickNumber', defaultValue: 0.0) as double;

  double autoClickIncrement() =>
      box.get('autoClickIncrement', defaultValue: kDefaultAutoClickIncrement)
          as double;

  double autoClickVisible() =>
      box.get('autoClickVisible', defaultValue: 0.0) as double;

  double shouldAnimateAutoClick() =>
      box.get('shouldAnimateAutoClick', defaultValue: 0.0) as double;

  double initialAutoClickUpgradeDone() =>
      box.get('initialAutoClickUpgradeDone', defaultValue: 0.0) as double;

  // functions

  void buyAutoClicker() {
    if (initialAutoClickUpgradeDone() == 1.0) {
      updateAutoClickCostOne();
    }
    autoClickCostIncrease();
    autoClickNumberIncrease();
    if (initialAutoClickUpgradeDone() == 0.0) {
      box.put('initialAutoClickUpgradeDone', 1.0);
    }
  }

  void updateAutoClickCostOne() {
    double newAutoClickCostOne =
        autoClickCostOne() * pow(kMainIncrement, autoClickIncrement());
    box.put('autoClickCostOne', newAutoClickCostOne);
  }

  void autoClickCostIncrease() {
    box.put('autoClickCost', autoClickCostOne());
    incrementalAutoClickCost();
  }

  void autoClickNumberIncrease() {
    box.put('autoClickNumber', (autoClickNumber() + autoClickIncrement()));
    if (shouldAnimateAutoClick() == 0.0) {
      box.put('shouldAnimateAutoClick', 1.0);
    }
  }

  void workerBuysAutoClicks(workerNumber) =>
      box.put('autoClickNumber', (autoClickNumber() + workerNumber));

  bool isAutoClickVisible(money) {
    if (autoClickVisible() == 0.0 && money >= kMoneyToShowAutoClick) {
      box.put('autoClickVisible', 1.0);
    }
    return autoClickVisible() == 1.0;
  }

  void updateAutoClickIncrement() {
    if (autoClickIncrement() == 1.0) {
      box.put('autoClickIncrement', 10.0);
      box.put('autoClickCostOne', autoClickCost());
      incrementalAutoClickCost();
    } else if (autoClickIncrement() == 10.0) {
      box.put('autoClickIncrement', 100.0);
      box.put('autoClickCost', autoClickCostOne());
      incrementalAutoClickCost();
    } else if (autoClickIncrement() == 100.0) {
      box.put('autoClickIncrement', 1.0);
      box.put('autoClickCost', autoClickCostOne());
    }
  }

  void incrementalAutoClickCost() {
    double newAutoClickCost = 0;
    for (var i = 1; i <= autoClickIncrement(); i++) {
      newAutoClickCost = autoClickCostOne() * pow(kMainIncrement, i);
    }
    box.put('autoClickCost', newAutoClickCost);
  }
}
