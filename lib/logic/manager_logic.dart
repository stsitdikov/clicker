import 'dart:math';
import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ManagerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  Duration managerDuration = Duration(seconds: 30);

  // getters

  double managerCost() =>
      box.get('managerCost', defaultValue: kDefaultManagerCost) as double;

  double managerCostOne() =>
      box.get('managerCostOne', defaultValue: kDefaultManagerCostOne) as double;

  double managerNumber() =>
      box.get('managerNumber', defaultValue: 0.0) as double;

  double managerIncrement() =>
      box.get('managerIncrement', defaultValue: kDefaultManagerIncrement)
          as double;

  double managerVisible() =>
      box.get('managerVisible', defaultValue: 0.0) as double;

  double shouldAnimateManager() =>
      box.get('shouldAnimateManager', defaultValue: 0.0) as double;

  double initialManagerUpgradeDone() =>
      box.get('initialManagerUpgradeDone', defaultValue: 0.0) as double;

  // functions

  void buyManager() {
    if (initialManagerUpgradeDone() == 1.0) {
      updateManagerCostOne();
    }
    managerCostIncrease();
    managerNumberIncrease();
    if (initialManagerUpgradeDone() == 0.0) {
      box.put('initialManagerUpgradeDone', 1.0);
    }
  }

  void updateManagerCostOne() {
    double newManagerCostOne =
        managerCostOne() * pow(kMainIncrement, managerIncrement());
    box.put('managerCostOne', newManagerCostOne);
  }

  void managerCostIncrease() {
    box.put('managerCost', managerCostOne());
    incrementalManagerCost();
  }

  void managerNumberIncrease() {
    box.put('managerNumber', (managerNumber() + managerIncrement()));
    if (shouldAnimateManager() == 0.0) {
      box.put('shouldAnimateManager', 1.0);
    }
  }

  void ceoBuysManagers(ceoNumber) =>
      box.put('managerNumber', (managerNumber() + ceoNumber));

  bool isManagerVisible(workerNumber) {
    if (managerVisible() == 0.0 && workerNumber >= kWorkerNumberToShowManager) {
      box.put('managerVisible', 1.0);
    }
    return managerVisible() == 1.0;
  }

  void updateManagerIncrement() {
    if (managerIncrement() == 1.0) {
      box.put('managerIncrement', 10.0);
      box.put('managerCostOne', managerCost());
      incrementalManagerCost();
    } else if (managerIncrement() == 10.0) {
      box.put('managerIncrement', 100.0);
      box.put('managerCost', managerCostOne());
      incrementalManagerCost();
    } else if (managerIncrement() == 100.0) {
      box.put('managerIncrement', 1.0);
      box.put('managerCost', managerCostOne());
    }
  }

  void incrementalManagerCost() {
    double newManagerCost = 0;
    for (var i = 1; i <= managerIncrement(); i++) {
      newManagerCost = managerCostOne() * pow(kMainIncrement, i);
    }
    box.put('managerCost', newManagerCost);
  }
}
