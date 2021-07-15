import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class AutoClickLogic {
  Duration autoClickerDuration = Duration(seconds: 3);

  // getters

  double getAutoClickCost() {
    return Hive.box<double>(kClickerBrainBox)
        .get('autoClickCost', defaultValue: kDefaultAutoClickCost) as double;
  }

  double getAutoClickCostOne() {
    return Hive.box<double>(kClickerBrainBox).get('autoClickCostOne',
        defaultValue: kDefaultAutoClickCostOne) as double;
  }

  double getAutoClickNumber() {
    return Hive.box<double>(kClickerBrainBox).get('autoClickNumber',
        defaultValue: kDefaultAutoClickNumber) as double;
  }

  double getAutoClickIncrement() {
    return Hive.box<double>(kClickerBrainBox).get('autoClickIncrement',
        defaultValue: kDefaultAutoClickIncrement) as double;
  }

  double getStartAutoClickAnimation() {
    return Hive.box<double>(kClickerBrainBox).get('startAutoClickAnimation',
        defaultValue: kDefaultStartAutoClickAnimation) as double;
  }

  double getAutoClickVisible() {
    return Hive.box<double>(kClickerBrainBox).get('autoClickVisible',
        defaultValue: kDefaultAutoClickVisible) as double;
  }

  double shouldAnimateAutoClick() {
    return Hive.box<double>(kClickerBrainBox)
        .get('shouldAnimateAutoClick', defaultValue: 0) as double;
  }

  // functions

  void autoClickCostIncrease() {
    Hive.box<double>(kClickerBrainBox)
        .put('autoClickCost', getAutoClickCostOne());
    incrementalAutoClickCost();
  }

  void autoClickNumberIncrease(workerNumber) {
    Hive.box<double>(kClickerBrainBox).put('autoClickNumber',
        (getAutoClickNumber() + getAutoClickIncrement() + workerNumber));
    Hive.box<double>(kClickerBrainBox)
        .put('startAutoClickAnimation', (getStartAutoClickAnimation() + 1));
    if (shouldAnimateAutoClick() == 0) {
      Hive.box<double>(kClickerBrainBox).put('shouldAnimateAutoClick', 1);
    }
  }

  bool shouldStartAutoClickAnimation() {
    return getStartAutoClickAnimation() == 1;
  }

  bool isAutoClickVisible(money) {
    if (getAutoClickVisible() == 0 && money >= kMoneyToShowAutoClick) {
      Hive.box<double>(kClickerBrainBox).put('autoClickVisible', 1);
    }
    return getAutoClickVisible() == 1;
  }

  void updateAutoClickIncrement() {
    if (getAutoClickIncrement() == 1) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 10);
      Hive.box<double>(kClickerBrainBox)
          .put('autoClickCostOne', getAutoClickCost());
      incrementalAutoClickCost();
    } else if (getAutoClickIncrement() == 10) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 100);
      Hive.box<double>(kClickerBrainBox)
          .put('autoClickCost', getAutoClickCostOne());
      incrementalAutoClickCost();
    } else if (getAutoClickIncrement() == 100) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 1);
      Hive.box<double>(kClickerBrainBox)
          .put('autoClickCost', getAutoClickCostOne());
    }
  }

  void incrementalAutoClickCost() {
    double autoClickCost = 0;
    for (var i = 1; i <= getAutoClickIncrement(); i++) {
      autoClickCost = getAutoClickCostOne() * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('autoClickCost', autoClickCost);
  }

  void updateAutoClickCostOne() {
    double newAutoClickCostOne =
        (getAutoClickCostOne() * pow(kMainIncrement, getAutoClickIncrement()));
    Hive.box<double>(kClickerBrainBox)
        .put('autoClickCostOne', newAutoClickCostOne);
  }
}
