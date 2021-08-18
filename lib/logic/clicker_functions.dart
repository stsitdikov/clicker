import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/constants.dart';

class ClickerFunctions {
  Box box = Hive.box<double>(kClickerBrainBox);

  void upgradeRow({
    required bool isClickRow,
    required double increment,
    required double costOne,
    required double shouldAnimate,
    required double numberToChange,
    required String boxCostOneName,
    required String boxCostName,
    required String boxNumberName,
    required String boxShouldAnimate,
  }) {
    if (increment == 1.0) {
      box.put(boxCostOneName, costOne * pow(kMainIncrement, increment));
      box.put(boxCostName, costOne * pow(kMainIncrement, increment));
      incrementalCost(0.0, increment, costOne, boxCostName);
      if (isClickRow == true) {
        updateNumberClickRow(boxNumberName, numberToChange, increment);
      } else {
        updateNumber(boxNumberName, numberToChange, increment, shouldAnimate,
            boxShouldAnimate);
      }
    } else {
      box.put(boxCostOneName, costOne * pow(kMainIncrement, increment));
      box.put(boxCostName, costOne * pow(kMainIncrement, increment));
      incrementalCost(costOne * pow(kMainIncrement, increment), increment,
          costOne * pow(kMainIncrement, increment), boxCostName);
      if (isClickRow == true) {
        updateNumberClickRow(boxNumberName, numberToChange, increment);
      } else {
        updateNumber(boxNumberName, numberToChange, increment, shouldAnimate,
            boxShouldAnimate);
      }
    }
  }

  void updateNumberClickRow(boxNumberName, numberToChange, increment) =>
      box.put(boxNumberName, numberToChange * pow(kMainIncrement, increment));

  void updateNumber(boxNumberName, numberToChange, increment, shouldAnimate,
      boxShouldAnimate) {
    box.put(boxNumberName, numberToChange + increment);
    if (shouldAnimate == 0.0) {
      box.put(boxShouldAnimate, 1.0);
    }
  }

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
