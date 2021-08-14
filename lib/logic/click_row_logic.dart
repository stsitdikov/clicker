import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickRowLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // getters

  double clickAmount() =>
      box.get('clickAmount', defaultValue: kDefaultClickAmount) as double;

  double clickCost() =>
      box.get('clickCost', defaultValue: kDefaultClickCost) as double;

  double clickCostOne() =>
      box.get('clickCostOne', defaultValue: kDefaultClickCostOne) as double;

  double clickIncrement() =>
      box.get('clickIncrement', defaultValue: kDefaultClickIncrement) as double;

  double initialClickUpgradeDone() =>
      box.get('initialClickUpgradeDone', defaultValue: 0.0) as double;

  // functions

  void clickUpgrade() {
    if (clickIncrement() == 1.0) {
      if (initialClickUpgradeDone() == 1.0) {
        updateClickCostOne();
      }
      clickCostIncrease();
      upgradeClickAmount();
      if (initialClickUpgradeDone() == 0.0) {
        box.put('initialClickUpgradeDone', 1.0);
      }
    } else {
      updateClickCostOne();
      clickCostIncrease();
      upgradeClickAmount();
      if (initialClickUpgradeDone() == 1.0) {
        box.put('initialClickUpgradeDone', 0.0);
      }
    }
  }

  void updateClickCostOne() {
    double newClickCostOne =
        (clickCostOne() * pow(kMainIncrement, clickIncrement()));
    box.put('clickCostOne', newClickCostOne);
  }

  void clickCostIncrease() {
    box.put('clickCost', clickCostOne());
    incrementalClickCost();
  }

  void upgradeClickAmount() {
    double newClickAmount =
        clickAmount() * pow(kMainIncrement, clickIncrement());
    box.put('clickAmount', newClickAmount);
  }

  void updateClickIncrement() {
    if (clickIncrement() == 1.0) {
      box.put('clickIncrement', 10.0);
      box.put('clickCostOne', clickCost());
      incrementalClickCost();
    } else if (clickIncrement() == 10.0) {
      box.put('clickIncrement', 100.0);
      box.put('clickCost', clickCostOne());
      incrementalClickCost();
    } else if (clickIncrement() == 100.0) {
      box.put('clickIncrement', 1.0);
      box.put('clickCost', clickCostOne());
    }
  }

  void incrementalClickCost() {
    double newClickCost = clickCostOne();
    for (var i = 1; i <= clickIncrement(); i++) {
      newClickCost = newClickCost + clickCostOne() * pow(kMainIncrement, i);
    }
    box.put('clickCost', newClickCost);
  }
}
