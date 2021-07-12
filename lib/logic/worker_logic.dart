import 'dart:math';

class WorkerLogic {
  bool workerVisible = false;
  int startWorkerAnimation = 0;
  double workerCost = 10;
  double workerCostOne = 0;
  num workerNumber = 0;
  int workerIncrement = 1;
  Duration workerDuration = Duration(seconds: 10);

  double autoClickNumberToShowWorker = 5;

  void workerCostIncrease(mainIncrement) {
    workerCost = workerCostOne;
    incrementalWorkerCost(mainIncrement);
  }

  void workerNumberIncrease(managerNumber) {
    workerNumber = workerNumber + workerIncrement + managerNumber;
    startWorkerAnimation++;
  }

  bool shouldStartWorkerAnimation() {
    return startWorkerAnimation == 1;
  }

  bool isWorkerVisible(autoClickNumber) {
    if (workerVisible == false &&
        autoClickNumber >= autoClickNumberToShowWorker) {
      workerVisible = true;
    }
    return workerVisible;
  }

  void updateWorkerIncrement(mainIncrement) {
    if (workerIncrement == 1) {
      workerIncrement = 10;
      workerCostOne = workerCost;
      incrementalWorkerCost(mainIncrement);
    } else if (workerIncrement == 10) {
      workerIncrement = 100;
      workerCost = workerCostOne;
      incrementalWorkerCost(mainIncrement);
    } else if (workerIncrement == 100) {
      workerIncrement = 1;
      workerCost = workerCostOne;
    }
  }

  void incrementalWorkerCost(mainIncrement) {
    for (var i = 1; i < workerIncrement; i++) {
      workerCost = workerCost + workerCostOne * pow(mainIncrement, i);
    }
  }

  void updateWorkerCostOne(mainIncrement) {
    workerCostOne = workerCostOne * pow(mainIncrement, workerIncrement);
  }
}
