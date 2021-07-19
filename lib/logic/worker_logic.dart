import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class WorkerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  Duration workerDuration = Duration(seconds: 10);

  // getters

  double workerCost() {
    return box.get('workerCost', defaultValue: kDefaultWorkerCost) as double;
  }

  double workerCostOne() {
    return box.get('workerCostOne', defaultValue: kDefaultWorkerCostOne)
        as double;
  }

  double workerNumber() {
    return box.get('workerNumber', defaultValue: kDefaultWorkerNumber)
        as double;
  }

  double workerIncrement() {
    return box.get('workerIncrement', defaultValue: kDefaultWorkerIncrement)
        as double;
  }

  double startWorkerAnimation() {
    return box.get('startWorkerAnimation',
        defaultValue: kDefaultStartWorkerAnimation) as double;
  }

  double workerVisible() {
    return box.get('workerVisible', defaultValue: kDefaultWorkerVisible)
        as double;
  }

  double shouldAnimateWorker() {
    return box.get('shouldAnimateWorker', defaultValue: 0.0) as double;
  }

  double initialWorkerUpgradeDone() {
    return box.get('initialWorkerUpgradeDone', defaultValue: 0.0) as double;
  }

  // functions

  void buyWorker(managerNumber) {
    if (initialWorkerUpgradeDone() == 1.0) {
      updateWorkerCostOne();
    }
    workerCostIncrease();
    workerNumberIncrease(managerNumber);
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
    double newWorkerCost = workerCostOne();
    box.put('workerCost', newWorkerCost);
    incrementalWorkerCost();
  }

  void workerNumberIncrease(managerNumber) {
    double newWorkerNumber = workerNumber() + workerIncrement() + managerNumber;
    box.put('workerNumber', newWorkerNumber);
    if (startWorkerAnimation() == 0.0) {
      box.put('startWorkerAnimation', 1.0);
    }
  }

  bool shouldStartWorkerAnimation() {
    return startWorkerAnimation() == 1.0;
  }

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
    for (var i = 1; i < workerIncrement(); i++) {
      newWorkerCost = workerCost() + workerCostOne() * pow(kMainIncrement, i);
    }
    box.put('workerCost', newWorkerCost);
  }
}
