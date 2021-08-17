import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class WorkerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String workerNumberString = 'workerNumber';
  String workerCostString = 'workerCost';
  String workerCostOneString = 'workerCostOne';
  String workerIncrementString = 'workerIncrement';
  String shouldAnimateWorkerString = 'shouldAnimateWorker';

  // getters

  double workerNumber() =>
      box.get(workerNumberString, defaultValue: 0.0) as double;

  double workerCost() =>
      box.get(workerCostString, defaultValue: kDefaultWorkerCost) as double;

  double workerCostOne() =>
      box.get(workerCostOneString, defaultValue: kDefaultWorkerCostOne)
          as double;

  double workerIncrement() =>
      box.get(workerIncrementString, defaultValue: kDefaultWorkerIncrement)
          as double;

  double workerVisible() =>
      box.get('workerVisible', defaultValue: 0.0) as double;

  double shouldAnimateWorker() =>
      box.get(shouldAnimateWorkerString, defaultValue: 0.0) as double;

  double initialWorkerUpgradeDone() =>
      box.get('initialWorkerUpgradeDone', defaultValue: 0.0) as double;

  double workerDurationMilliseconds() => box.get('workerDurationMilliseconds',
      defaultValue: kDefaultWorkerDurationMilliseconds);

  double workerDecreaseDurationCost() => box.get('workerDecreaseDurationCost',
      defaultValue: kDefaultWorkerDecreaseDurationCost);

  // functions

  void managerBuysWorkers(managerNumber) =>
      box.put('workerNumber', (workerNumber() + managerNumber));

  bool isWorkerVisible(autoClickNumber) {
    if (workerVisible() == 0.0 &&
        autoClickNumber >= kAutoClickNumberToShowWorker) {
      box.put('workerVisible', 1.0);
    }
    return workerVisible() == 1.0;
  }

  void decreaseWorkerDuration() => box.put('workerDurationMilliseconds',
      (workerDurationMilliseconds() - kDecreaseWorkerDurationBy));

  void increaseWorkerDecreaseDurationCost() => box.put(
      'workerDecreaseDurationCost',
      (workerDecreaseDurationCost() * kMainIncrement));
}
