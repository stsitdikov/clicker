import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class WorkerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // getters

  double workerCost() =>
      box.get('workerCost', defaultValue: kDefaultWorkerCost) as double;

  double workerCostOne() =>
      box.get('workerCostOne', defaultValue: kDefaultWorkerCostOne) as double;

  double workerNumber() => box.get('workerNumber', defaultValue: 0.0) as double;

  double workerIncrement() =>
      box.get('workerIncrement', defaultValue: kDefaultWorkerIncrement)
          as double;

  double workerVisible() =>
      box.get('workerVisible', defaultValue: 0.0) as double;

  double shouldAnimateWorker() =>
      box.get('shouldAnimateWorker', defaultValue: 0.0) as double;

  double initialWorkerUpgradeDone() =>
      box.get('initialWorkerUpgradeDone', defaultValue: 0.0) as double;

  double workerDurationMilliseconds() => box.get('workerDurationMilliseconds',
      defaultValue: kDefaultWorkerDurationMilliseconds);

  double workerDecreaseDurationCost() => box.get('workerDecreaseDurationCost',
      defaultValue: kDefaultWorkerDecreaseDurationCost);

  // functions

  void buyWorker() {
    if (workerIncrement() == 1.0) {
      if (initialWorkerUpgradeDone() == 1.0) {
        updateWorkerCostOne();
      }
      workerCostIncrease();
      workerNumberIncrease();
      if (initialWorkerUpgradeDone() == 0.0) {
        box.put('initialWorkerUpgradeDone', 1.0);
      }
    } else {
      updateWorkerCostOne();
      workerCostIncrease();
      workerNumberIncrease();
      if (initialWorkerUpgradeDone() == 1.0) {
        box.put('initialWorkerUpgradeDone', 0.0);
      }
    }
  }

  void updateWorkerCostOne() {
    double newWorkerCostOne =
        workerCostOne() * pow(kMainIncrement, workerIncrement());
    box.put('workerCostOne', newWorkerCostOne);
  }

  void workerCostIncrease() {
    box.put('workerCost', workerCostOne());
    incrementalWorkerCost(0.0);
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
      incrementalWorkerCost(workerCostOne());
    } else if (workerIncrement() == 10.0) {
      box.put('workerIncrement', 100.0);
      box.put('workerCost', workerCostOne());
      incrementalWorkerCost(workerCostOne());
    } else if (workerIncrement() == 100.0) {
      box.put('workerIncrement', 1.0);
      box.put('workerCost', workerCostOne());
    }
  }

  void incrementalWorkerCost(newValue) {
    double newWorkerCost = newValue;
    for (var i = 1; i <= workerIncrement(); i++) {
      newWorkerCost = newWorkerCost + workerCostOne() * pow(kMainIncrement, i);
    }
    box.put('workerCost', newWorkerCost);
  }

  void decreaseWorkerDuration() => box.put(
      'workerDurationMilliseconds', (workerDurationMilliseconds() - 5000));

  void increaseWorkerDecreaseDurationCost() => box.put(
      'workerDecreaseDurationCost',
      (workerDecreaseDurationCost() * kMainIncrement));
}
