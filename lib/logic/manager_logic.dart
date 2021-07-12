import 'dart:math';

class ManagerLogic {
  bool managerVisible = false;
  int startManagerAnimation = 0;
  double managerCost = 10;
  double managerCostOne = 10;
  double managerNumber = 0;
  int managerIncrement = 1;
  Duration managerDuration = Duration(seconds: 30);

  double workerNumberToShowManager = 5;

  void managerCostIncrease(mainIncrement) {
    managerCost = managerCostOne;
    incrementalManagerCost(mainIncrement);
  }

  void managerNumberIncrease() {
    managerNumber = managerNumber + managerIncrement;
    startManagerAnimation++;
  }

  bool shouldStartManagerAnimation() {
    return startManagerAnimation == 1;
  }

  bool isManagerVisible(workerNumber) {
    if (managerVisible == false && workerNumber >= workerNumberToShowManager) {
      managerVisible = true;
    }
    return managerVisible;
  }

  void updateManagerIncrement(mainIncrement) {
    if (managerIncrement == 1) {
      managerIncrement = 10;
      managerCostOne = managerCost;
      incrementalManagerCost(mainIncrement);
    } else if (managerIncrement == 10) {
      managerIncrement = 100;
      managerCost = managerCostOne;
      incrementalManagerCost(mainIncrement);
    } else if (managerIncrement == 100) {
      managerIncrement = 1;
      managerCost = managerCostOne;
    }
  }

  void incrementalManagerCost(mainIncrement) {
    for (var i = 1; i < managerIncrement; i++) {
      managerCost = managerCost + managerCostOne * pow(mainIncrement, i);
    }
  }

  void updateManagerCostOne(mainIncrement) {
    managerCostOne = managerCostOne * pow(mainIncrement, managerIncrement);
  }
}
