import 'dart:math';

class AutoClickLogic {
  bool autoClickVisible = false;
  bool autoClickAnimation = false;
  int startAutoClickAnimation = 0;
  int autoClickIncrement = 1;
  double autoClickCost = 10;
  double autoClickCostOne = 10;
  num autoClickNumber = 0;
  Duration autoClickerDuration = Duration(seconds: 3);

  double moneyToShowAutoClick = 10;

  void autoClickCostIncrease(mainIncrement) {
    autoClickCost = autoClickCostOne;
    incrementalAutoClickCost(mainIncrement);
  }

  void autoClickNumberIncrease(workerNumber) {
    autoClickNumber = autoClickNumber + autoClickIncrement + workerNumber;
    startAutoClickAnimation++;
  }

  bool shouldStartAutoClickAnimation() {
    return startAutoClickAnimation == 1;
  }

  bool isAutoClickVisible(money) {
    if (autoClickVisible == false && money >= moneyToShowAutoClick) {
      autoClickVisible = true;
    }
    return autoClickVisible;
  }

  void updateAutoClickIncrement(mainIncrement) {
    if (autoClickIncrement == 1) {
      autoClickIncrement = 10;
      autoClickCostOne = autoClickCost;
      incrementalAutoClickCost(mainIncrement);
    } else if (autoClickIncrement == 10) {
      autoClickIncrement = 100;
      autoClickCost = autoClickCostOne;
      incrementalAutoClickCost(mainIncrement);
    } else if (autoClickIncrement == 100) {
      autoClickIncrement = 1;
      autoClickCost = autoClickCostOne;
    }
  }

  void incrementalAutoClickCost(mainIncrement) {
    for (var i = 1; i < autoClickIncrement; i++) {
      autoClickCost = autoClickCost + autoClickCostOne * pow(mainIncrement, i);
    }
  }

  void updateAutoClickCostOne(mainIncrement) {
    autoClickCostOne =
        autoClickCostOne * pow(mainIncrement, autoClickIncrement);
  }
}
