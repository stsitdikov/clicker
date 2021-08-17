import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/constants.dart';

class ClickerFunctions {
  Box box = Hive.box<double>(kClickerBrainBox);

  void upgradeRow({
    required double increment,
    required double costOne,
    required double numberToChange,
    required String boxCostOneName,
    required String boxCostName,
    required String boxNumberName,
  }) {
    if (increment == 1.0) {
      updateCostOne(boxCostOneName, costOne, increment);
      costIncrease(boxCostName, (costOne * increment));
      incrementalCost(0.0, increment, costOne, boxCostName);
      updateNumber(boxNumberName, numberToChange, increment);
    } else {
      updateCostOne(boxCostOneName, costOne, increment);
      costIncrease(boxCostName, costOne);
      incrementalCost(0.0, increment, costOne, boxCostName);
      updateNumber(boxNumberName, numberToChange, increment);
    }
  }

  void updateCostOne(boxCostOneName, costOne, increment) =>
      box.put(boxCostOneName, costOne * pow(kMainIncrement, increment));

  void costIncrease(boxCostName, costOne) => box.put(boxCostName, costOne);

  void updateNumber(boxNumberName, numberToChange, increment) =>
      box.put(boxNumberName, numberToChange * pow(kMainIncrement, increment));

  void updateIncrement({
    required double increment,
    required double cost,
    required double costOne,
    required String boxIncrementName,
    required String boxCostName,
    required String boxCostOneName,
  }) {
    if (increment == 1.0) {
      box.put(boxIncrementName, 10.0);
      box.put(boxCostName, costOne);
      incrementalCost(costOne, 10.0, costOne, boxCostName);
    } else if (increment == 10.0) {
      box.put(boxIncrementName, 100.0);
      box.put(boxCostName, costOne);
      incrementalCost(costOne, 100.0, costOne, boxCostName);
    } else if (increment == 100.0) {
      box.put(boxIncrementName, 1.0);
      box.put(boxCostName, costOne);
    }
  }

  void incrementalCost(newValue, increment, costOne, boxCostName) {
    double newCost = newValue;
    for (var i = 1; i <= increment; i++) {
      newCost = newCost + costOne * pow(kMainIncrement, i);
    }
    box.put(boxCostName, newCost);
  }
}
