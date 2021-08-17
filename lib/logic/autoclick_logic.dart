import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class AutoClickLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String autoClickNumberString = 'autoClickNumber';
  String autoClickCostString = 'autoClickCost';
  String autoClickCostOneString = 'autoClickCostOne';
  String autoClickIncrementString = 'autoClickIncrement';
  String shouldAnimateAutoClickString = 'shouldAnimateAutoClick';
  String autoClickVisibleString = 'autoClickVisible';

  // getters

  double autoClickNumber() =>
      box.get(autoClickNumberString, defaultValue: 0.0) as double;

  double autoClickCost() =>
      box.get(autoClickCostString, defaultValue: kDefaultAutoClickCost)
          as double;

  double autoClickCostOne() =>
      box.get(autoClickCostOneString, defaultValue: kDefaultAutoClickCostOne)
          as double;

  double autoClickIncrement() => box.get(autoClickIncrementString,
      defaultValue: kDefaultAutoClickIncrement) as double;

  double autoClickVisible() =>
      box.get(autoClickVisibleString, defaultValue: 0.0) as double;

  double shouldAnimateAutoClick() =>
      box.get(shouldAnimateAutoClickString, defaultValue: 0.0) as double;

  double autoClickDurationMilliseconds() =>
      box.get('autoClickDurationMilliseconds',
          defaultValue: kDefaultAutoClickDurationMilliseconds);

  double autoClickDecreaseDurationCost() =>
      box.get('autoClickDecreaseDurationCost',
          defaultValue: kDefaultAutoClickDecreaseDurationCost);

  // functions

  void workerBuysAutoClicks(workerNumber) =>
      box.put(autoClickNumberString, (autoClickNumber() + workerNumber));

  bool isAutoClickVisible(money) {
    if (autoClickVisible() == 0.0 && money >= kMoneyToShowAutoClick) {
      box.put('autoClickVisible', 1.0);
    }
    return autoClickVisible() == 1.0;
  }

  void decreaseAutoClickDuration() => box.put('autoClickDurationMilliseconds',
      (autoClickDurationMilliseconds() - 1000));

  void increaseAutoClickDecreaseDurationCost() => box.put(
      'autoClickDecreaseDurationCost',
      (autoClickDecreaseDurationCost() * kMainIncrement));
}
