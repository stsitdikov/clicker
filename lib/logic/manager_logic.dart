import 'dart:math';
import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ManagerLogic {
  Duration managerDuration = Duration(seconds: 30);

  double managerCost = Hive.box<double>(kClickerBrainBox)
      .get('managerCost', defaultValue: kDefaultManagerCost) as double;

  double managerCostOne = Hive.box<double>(kClickerBrainBox)
      .get('managerCostOne', defaultValue: kDefaultManagerCostOne) as double;

  double managerNumber = Hive.box<double>(kClickerBrainBox)
      .get('managerNumber', defaultValue: kDefaultManagerNumber) as double;

  double managerIncrement = Hive.box<double>(kClickerBrainBox)
          .get('managerIncrement', defaultValue: kDefaultManagerIncrement)
      as double;

  double startManagerAnimation = Hive.box<double>(kClickerBrainBox).get(
      'startManagerAnimation',
      defaultValue: kDefaultStartManagerAnimation) as double;

  double managerVisible = Hive.box<double>(kClickerBrainBox)
      .get('managerVisible', defaultValue: kDefaultManagerVisible) as double;

  double workerNumber = Hive.box<double>(kClickerBrainBox)
      .get('workerNumber', defaultValue: kDefaultWorkerNumber) as double;

  void managerCostIncrease() {
    double newManagerCost = managerCostOne;
    Hive.box<double>(kClickerBrainBox).put('managerCost', newManagerCost);
    incrementalManagerCost();
  }

  void managerNumberIncrease() {
    double newManagerNumber = managerNumber + managerIncrement;
    Hive.box<double>(kClickerBrainBox).put('managerNumber', newManagerNumber);
    if (startManagerAnimation == 0) {
      Hive.box<double>(kClickerBrainBox).put('startManagerAnimation', 1);
    }
  }

  bool shouldStartManagerAnimation() {
    return startManagerAnimation == 1;
  }

  bool isManagerVisible() {
    if (managerVisible == 0 && workerNumber >= kWorkerNumberToShowManager) {
      Hive.box<double>(kClickerBrainBox).put('managerVisible', 1);
    }
    return managerVisible == 1;
  }

  void updateManagerIncrement() {
    if (managerIncrement == 1) {
      Hive.box<double>(kClickerBrainBox).put('managerIncrement', 10);
      double newManagerCostOne = managerCost;
      Hive.box<double>(kClickerBrainBox)
          .put('managerCostOne', newManagerCostOne);
      incrementalManagerCost();
    } else if (managerIncrement == 10) {
      Hive.box<double>(kClickerBrainBox).put('managerIncrement', 100);
      double newManagerCost = managerCostOne;
      Hive.box<double>(kClickerBrainBox).put('managerCost', newManagerCost);
      incrementalManagerCost();
    } else if (managerIncrement == 100) {
      Hive.box<double>(kClickerBrainBox).put('managerIncrement', 1);
      double newManagerCost = managerCostOne;
      Hive.box<double>(kClickerBrainBox).put('managerCost', newManagerCost);
    }
  }

  void incrementalManagerCost() {
    double newManagerCost = 0;
    for (var i = 1; i < managerIncrement; i++) {
      newManagerCost = managerCost + managerCostOne * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('managerCost', newManagerCost);
  }

  void updateManagerCostOne() {
    double newManagerCostOne =
        managerCostOne * pow(kMainIncrement, managerIncrement);
    Hive.box<double>(kClickerBrainBox).put('managerCostOne', newManagerCostOne);
  }
}
