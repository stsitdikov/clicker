import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class AutoClickLogic {
  Duration autoClickerDuration = Duration(seconds: 3);

  double money = Hive.box<double>(kClickerBrainBox)
      .get('money', defaultValue: kDefaultMoney) as double;

  double autoClickCost = Hive.box<double>(kClickerBrainBox)
      .get('autoClickCost', defaultValue: kDefaultAutoClickCost) as double;

  double autoClickCostOne = Hive.box<double>(kClickerBrainBox)
          .get('autoClickCostOne', defaultValue: kDefaultAutoClickCostOne)
      as double;

  double autoClickNumber = Hive.box<double>(kClickerBrainBox)
      .get('autoClickNumber', defaultValue: kDefaultAutoClickNumber) as double;

  double autoClickIncrement = Hive.box<double>(kClickerBrainBox)
          .get('autoClickIncrement', defaultValue: kDefaultAutoClickIncrement)
      as double;

  double startAutoClickAnimation = Hive.box<double>(kClickerBrainBox).get(
      'startAutoClickAnimation',
      defaultValue: kDefaultStartAutoClickAnimation) as double;

  double autoClickVisible = (Hive.box<double>(kClickerBrainBox))
          .get('autoClickVisible', defaultValue: kDefaultAutoClickVisible)
      as double;

  double workerNumber = (Hive.box<double>(kClickerBrainBox)
      .get('workerNumber', defaultValue: kDefaultWorkerNumber)) as double;

  void autoClickCostIncrease() {
    double newAutoClickCost = autoClickCostOne;
    Hive.box<double>(kClickerBrainBox).put('autoClickCost', newAutoClickCost);
    incrementalAutoClickCost();
  }

  void autoClickNumberIncrease() {
    double newAutoClickNumber =
        autoClickNumber + autoClickIncrement + workerNumber;
    Hive.box<double>(kClickerBrainBox)
        .put('autoClickNumber', newAutoClickNumber);
    if (startAutoClickAnimation == 0) {
      Hive.box<double>(kClickerBrainBox).put('startAutoClickAnimation', 1);
    }
  }

  bool shouldStartAutoClickAnimation() {
    return startAutoClickAnimation == 1;
  }

  bool isAutoClickVisible() {
    if (autoClickVisible == 0 && money >= kMoneyToShowAutoClick) {
      Hive.box<double>(kClickerBrainBox).put('autoClickVisible', 1);
    }
    return autoClickVisible == 1;
  }

  void updateAutoClickIncrement() {
    if (autoClickIncrement == 1) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 10);
      double newAutoClickCostOne = autoClickCost;
      Hive.box<double>(kClickerBrainBox)
          .put('autoClickCostOne', newAutoClickCostOne);
      incrementalAutoClickCost();
    } else if (autoClickIncrement == 10) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 100);
      double newAutoClickCost = autoClickCostOne;
      Hive.box<double>(kClickerBrainBox).put('autoClickCost', newAutoClickCost);
      incrementalAutoClickCost();
    } else if (autoClickIncrement == 100) {
      Hive.box<double>(kClickerBrainBox).put('autoClickIncrement', 1);
      double newAutoClickCost = autoClickCostOne;
      Hive.box<double>(kClickerBrainBox).put('autoClickCost', newAutoClickCost);
    }
  }

  void incrementalAutoClickCost() {
    double newAutoClickCost = 0;
    for (var i = 1; i < autoClickIncrement; i++) {
      newAutoClickCost =
          autoClickCost + autoClickCostOne * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('autoClickCost', newAutoClickCost);
  }

  void updateAutoClickCostOne() {
    double newAutoClickCostOne =
        autoClickCostOne * pow(kMainIncrement, autoClickIncrement);
    Hive.box<double>(kClickerBrainBox)
        .put('autoClickCostOne', newAutoClickCostOne);
  }
}
