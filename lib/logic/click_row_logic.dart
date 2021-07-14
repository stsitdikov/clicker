import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickRowLogic {
  double money = Hive.box<double>(kClickerBrainBox)
      .get('money', defaultValue: kDefaultMoney) as double;

  double clickAmount = (Hive.box<double>(kClickerBrainBox)
      .get('clickAmount', defaultValue: kDefaultClickAmount)) as double;

  double clickCost = (Hive.box<double>(kClickerBrainBox)
      .get('clickCost', defaultValue: kDefaultClickCost)) as double;

  double clickCostOne = (Hive.box<double>(kClickerBrainBox)
      .get('clickCostOne', defaultValue: kDefaultClickCostOne)) as double;

  double clickIncrement = (Hive.box<double>(kClickerBrainBox)
      .get('clickIncrement', defaultValue: kDefaultClickIncrement)) as double;

  double clickUpgradeVisible = (Hive.box<double>(kClickerBrainBox).get(
      'clickUpgradeVisible',
      defaultValue: kDefaultClickUpgradeVisible)) as double;

  double newClickCost = 0;
  double newClickCostOne = 0;
  double newClickAmount = 0;

  void clickCostIncrease() {
    newClickCost = clickCostOne;
    Hive.box<double>(kClickerBrainBox).put('clickCost', newClickCost);
    incrementalClickCost();
  }

  void upgradeClickAmount() {
    newClickAmount = clickAmount * pow(kMainIncrement, clickIncrement);
    Hive.box<double>(kClickerBrainBox).put('clickAmount', newClickAmount);
  }

  bool isClickUpgradeVisible() {
    if (clickUpgradeVisible == 0 && money >= clickCost) {
      Hive.box<double>(kClickerBrainBox).put('clickUpgradeVisible', 1);
    }
    return clickUpgradeVisible == 1 ? true : false;
  }

  void updateClickIncrement() {
    if (clickIncrement == 1) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 10);
      newClickCostOne = clickCost;
      Hive.box<double>(kClickerBrainBox).put('clickCostOne', newClickCostOne);
      incrementalClickCost();
    } else if (clickIncrement == 10) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 100);
      newClickCost = clickCostOne;
      Hive.box<double>(kClickerBrainBox).put('clickCost', newClickCost);
      incrementalClickCost();
    } else if (clickIncrement == 100) {
      Hive.box<double>(kClickerBrainBox).put('clickIncrement', 1);
      newClickCost = clickCostOne;
      Hive.box<double>(kClickerBrainBox).put('clickCost', newClickCost);
    }
  }

  void incrementalClickCost() {
    for (var i = 1; i < clickIncrement; i++) {
      newClickCost = clickCost + clickCostOne * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('clickCost', newClickCost);
  }

  void updateClickCostOne() {
    newClickCostOne = clickCostOne * pow(kMainIncrement, clickIncrement);
    Hive.box<double>(kClickerBrainBox).put('clickCostOne', newClickCostOne);
  }
}
