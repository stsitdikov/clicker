import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class WorkerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  Duration workerDuration = Duration(seconds: 10);

  // getters

  double workerCost() =>
      box.get('workerCost', defaultValue: kDefaultWorkerCost) as double;

  double workerCostOne() =>
      box.get('workerCostOne', defaultValue: kDefaultWorkerCostOne) as double;

  double workerNumber() =>
      box.get('workerNumber', defaultValue: kDefaultWorkerNumber) as double;

  double workerIncrement() =>
      box.get('workerIncrement', defaultValue: kDefaultWorkerIncrement)
          as double;

  double workerVisible() =>
      box.get('workerVisible', defaultValue: kDefaultWorkerVisible) as double;

  double shouldAnimateWorker() =>
      box.get('shouldAnimateWorker', defaultValue: 0.0) as double;

  double initialWorkerUpgradeDone() =>
      box.get('initialWorkerUpgradeDone', defaultValue: 0.0) as double;

  // functions

  void buyWorker() {
    if (initialWorkerUpgradeDone() == 1.0) {
      updateWorkerCostOne();
    }
    workerCostIncrease();
    workerNumberIncrease();
    if (initialWorkerUpgradeDone() == 0.0) {
      box.put('initialWorkerUpgradeDone', 1.0);
    }
  }

  void updateWorkerCostOne() {
    double newWorkerCostOne =
        workerCostOne() * pow(kMainIncrement, workerIncrement());
    box.put('workerCostOne', newWorkerCostOne);
  }

  void workerCostIncrease() {
    box.put('workerCost', workerCostOne());
    incrementalWorkerCost();
  }

  void workerNumberIncrease() {
    box.put('workerNumber', (workerNumber() + workerIncrement()));
    if (shouldAnimateWorker() == 0.0) {
      box.put('shouldAnimateWorker', 1.0);
    }
  }

  void managerBuysWorkers(managerNumber) =>
      box.put('workerNumber', (workerNumber() + managerNumber));

  bool isWorkerVisible(autoClickNumber) {
    if (workerVisible() == 0.0 &&
        autoClickNumber >= kAutoClickNumberToShowWorker) {
      box.put('workerVisible', 1.0);
    }
    return workerVisible() == 1.0;
  }

  void updateWorkerIncrement() {
    if (workerIncrement() == 1.0) {
      box.put('workerIncrement', 10.0);
      box.put('workerCostOne', workerCost());
      incrementalWorkerCost();
    } else if (workerIncrement() == 10.0) {
      box.put('workerIncrement', 100.0);
      box.put('workerCost', workerCostOne());
      incrementalWorkerCost();
    } else if (workerIncrement() == 100.0) {
      box.put('workerIncrement', 1.0);
      box.put('workerCost', workerCostOne());
    }
  }

  void incrementalWorkerCost() {
    double newWorkerCost = 0;
    for (var i = 1; i <= workerIncrement(); i++) {
      newWorkerCost = workerCostOne() * pow(kMainIncrement, i);
    }
    box.put('workerCost', newWorkerCost);
  }
}
