import 'dart:async';

class AutoClickLogic {
  bool autoClickVisible = false;
  bool autoClickAnimation = false;
  int startAutoClickAnimation = 0;
  int autoClickIncrement = 1;
  double autoClickCost = 10;
  double autoClickCostOne = 0;
  int autoClickNumber = 0;
  Duration autoClickerDuration = Duration(seconds: 3);

  void autoClickCostIncrease(mainIncrement) {
    autoClickCost = autoClickCost * mainIncrement;
  }

  void autoClickNumberIncrease() {
    autoClickNumber = autoClickNumber + autoClickIncrement;
  }

  bool shouldStartAutoClickAnimation() {
    startAutoClickAnimation++;
    return startAutoClickAnimation == 1;
  }

  bool isAutoClickVisible(canUpgradeAutoclick) {
    if (autoClickVisible == false && canUpgradeAutoclick) {
      autoClickVisible = true;
    }
    return autoClickVisible;
  }
}
