import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickRowLogic {
  double getClickAmount() {
    return (Hive.box<double>(kClickerBrainBox)
        .get('clickAmount', defaultValue: kDefaultClickAmount)) as double;
  }

  double getClickCost() {
    return (Hive.box<double>(kClickerBrainBox)
        .get('clickCost', defaultValue: kDefaultClickCost)) as double;
  }

  double getClickCostOne() {
    return (Hive.box<double>(kClickerBrainBox)
        .get('clickCostOne', defaultValue: kDefaultClickCostOne)) as double;
  }

  double getClickIncrement() {
    return (Hive.box<double>(kClickerBrainBox)
        .get('clickIncrement', defaultValue: kDefaultClickIncrement)) as double;
  }

  double getClickUpgradeVisible() {
    return (Hive.box<double>(kClickerBrainBox).get('clickUpgradeVisible',
        defaultValue: kDefaultClickUpgradeVisible)) as double;
  }

  void clickCostIncrease() {
    Hive.box<double>(kClickerBrainBox).put('clickCost', getClickCostOne());
    incrementalClickCost();
  }

  void upgradeClickAmount() {
    double clickAmount =
        getClickAmount() * pow(kMainIncrement, getClickIncrement());
    Hive.box<double>(kClickerBrainBox).put('clickAmount', clickAmount);
  }

  bool isClickUpgradeVisible(money) {
    if (getClickUpgradeVisible() == 0 && money >= getClickCost()) {
      Hive.box<double>(kClickerBrainBox).put('clickUpgradeVisible', 1);
    }
    return getClickUpgradeVisible() == 1;
  }

  void updateClickIncrement() {
    if (getClickIncrement() == 1) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 10);
      Hive.box<double>(kClickerBrainBox).put('clickCostOne', getClickCost());
      incrementalClickCost();
    } else if (getClickIncrement() == 10) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 100);
      Hive.box<double>(kClickerBrainBox).put('clickCost', getClickCostOne());
      incrementalClickCost();
    } else if (getClickIncrement() == 100) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 1);
      Hive.box<double>(kClickerBrainBox).put('clickCost', getClickCostOne());
    }
  }

  void incrementalClickCost() {
    double clickCost = 0;
    for (var i = 1; i <= getClickIncrement(); i++) {
      clickCost = getClickCostOne() * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('clickCost', clickCost);
  }

  void updateClickCostOne() {
    double clickCostOne =
        getClickCostOne() * pow(kMainIncrement, getClickIncrement());
    Hive.box<double>(kClickerBrainBox).put('clickCostOne', clickCostOne);
  }
}
