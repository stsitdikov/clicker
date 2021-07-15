import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class WorkerLogic {
  Duration workerDuration = Duration(seconds: 10);

  double workerCost = Hive.box<double>(kClickerBrainBox)
      .get('workerCost', defaultValue: kDefaultWorkerCost) as double;

  double workerCostOne = Hive.box<double>(kClickerBrainBox)
      .get('workerCostOne', defaultValue: kDefaultWorkerCostOne) as double;

  double workerNumber = Hive.box<double>(kClickerBrainBox)
      .get('workerNumber', defaultValue: kDefaultWorkerNumber) as double;

  double workerIncrement = Hive.box<double>(kClickerBrainBox)
      .get('workerIncrement', defaultValue: kDefaultWorkerIncrement) as double;

  double startWorkerAnimation = Hive.box<double>(kClickerBrainBox).get(
      'startWorkerAnimation',
      defaultValue: kDefaultStartWorkerAnimation) as double;

  double workerVisible = Hive.box<double>(kClickerBrainBox)
      .get('workerVisible', defaultValue: kDefaultWorkerVisible) as double;

  double managerNumber = (Hive.box<double>(kClickerBrainBox)
      .get('managerNumber', defaultValue: kDefaultManagerNumber)) as double;

  double autoClickNumber = Hive.box<double>(kClickerBrainBox)
      .get('autoClickNumber', defaultValue: kDefaultAutoClickNumber) as double;

  void workerCostIncrease() {
    double newWorkerCost = workerCostOne;
    Hive.box<double>(kClickerBrainBox).put('workerCost', newWorkerCost);
    incrementalWorkerCost();
  }

  void workerNumberIncrease() {
    double newWorkerNumber = workerNumber + workerIncrement + managerNumber;
    Hive.box<double>(kClickerBrainBox).put('workerNumber', newWorkerNumber);
    if (startWorkerAnimation == 0) {
      Hive.box<double>(kClickerBrainBox).put('startWorkerAnimation', 1);
    }
  }

  bool shouldStartWorkerAnimation() {
    return startWorkerAnimation == 1;
  }

  bool isWorkerVisible() {
    if (workerVisible == 0 && autoClickNumber >= kAutoClickNumberToShowWorker) {
      Hive.box<double>(kClickerBrainBox).put('workerVisible', 1);
    }
    return workerVisible == 1;
  }

  void updateWorkerIncrement() {
    if (workerIncrement == 1) {
      Hive.box<double>(kClickerBrainBox).put('workerIncrement', 10);
      double newWorkerCostOne = workerCost;
      Hive.box<double>(kClickerBrainBox).put('workerCostOne', newWorkerCostOne);
      incrementalWorkerCost();
    } else if (workerIncrement == 10) {
      Hive.box<double>(kClickerBrainBox).put('workerIncrement', 100);
      double newWorkerCost = workerCostOne;
      Hive.box<double>(kClickerBrainBox).put('workerCost', newWorkerCost);
      incrementalWorkerCost();
    } else if (workerIncrement == 100) {
      Hive.box<double>(kClickerBrainBox).put('workerIncrement', 1);
      double newWorkerCost = workerCostOne;
      Hive.box<double>(kClickerBrainBox).put('workerCost', newWorkerCost);
    }
  }

  void incrementalWorkerCost() {
    double newWorkerCost = 0;
    for (var i = 1; i < workerIncrement; i++) {
      newWorkerCost = workerCost + workerCostOne * pow(kMainIncrement, i);
    }
    Hive.box<double>(kClickerBrainBox).put('workerCost', newWorkerCost);
  }

  void updateWorkerCostOne() {
    double newWorkerCostOne =
        workerCostOne * pow(kMainIncrement, workerIncrement);
    Hive.box<double>(kClickerBrainBox).put('workerCostOne', newWorkerCostOne);
  }
}
