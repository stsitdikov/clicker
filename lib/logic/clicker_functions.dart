import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:clicker/logic/constants.dart';

class ClickerFunctions {
  Box box = Hive.box<double>(kClickerBrainBox);

  void upgradeRow({
    required String name,
    required double increment,
    required double costOne,
    required double shouldAnimate,
    required double numberToChange,
  }) {
    if (increment == 1.0) {
      box.put('${name}CostOne', costOne * pow(kMainIncrement, increment));
      box.put('${name}Cost', costOne * pow(kMainIncrement, increment));
      incrementalCost(name, 0.0, increment, costOne);
      if (name == kClickName) {
        updateNumberClickRow(numberToChange, increment);
      } else {
        updateNumber(name, numberToChange, increment, shouldAnimate);
      }
    } else {
      box.put('${name}CostOne', costOne * pow(kMainIncrement, increment));
      box.put('${name}Cost', costOne * pow(kMainIncrement, increment));
      incrementalCost(name, costOne * pow(kMainIncrement, increment), increment,
          costOne * pow(kMainIncrement, increment));
      if (name == kClickName) {
        updateNumberClickRow(numberToChange, increment);
      } else {
        updateNumber(name, numberToChange, increment, shouldAnimate);
      }
    }
  }

  void updateNumberClickRow(numberToChange, increment) =>
      box.put('ClickAmount', numberToChange * pow(kMainIncrement, increment));

  void updateNumber(name, numberToChange, increment, shouldAnimate) {
    box.put('${name}Number', numberToChange + increment);
    if (shouldAnimate == 0.0) {
      box.put('shouldAnimate$name', 1.0);
    }
  }

  void updateIncrement({
    required String name,
    required double increment,
    required double costOne,
  }) {
    if (increment == 1.0) {
      box.put('${name}Increment', 10.0);
      box.put('${name}Cost', costOne);
      incrementalCost(name, costOne, 10.0, costOne);
    } else if (increment == 10.0) {
      box.put('${name}Increment', 100.0);
      box.put('${name}Cost', costOne);
      incrementalCost(name, costOne, 100.0, costOne);
    } else if (increment == 100.0) {
      box.put('${name}Increment', 1.0);
      box.put('${name}Cost', costOne);
    }
  }

  void incrementalCost(name, newValue, increment, costOne) {
    double newCost = newValue;
    for (var i = 1; i <= increment; i++) {
      newCost = newCost + costOne * pow(kMainIncrement, i);
    }
    box.put('${name}Cost', newCost);
  }
}
