import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class MoneyLogic {
  double getMoney() {
    return Hive.box<double>(kClickerBrainBox)
        .get('money', defaultValue: kDefaultMoney) as double;
  }

  double getClickAmount() {
    return (Hive.box<double>(kClickerBrainBox)
        .get('clickAmount', defaultValue: kDefaultClickAmount)) as double;
  }

  double getAutoClickNumber() {
    return (Hive.box<double>(kClickerBrainBox).get('autoClickNumber',
        defaultValue: kDefaultAutoClickNumber)) as double;
  }

  void clickIncreaseMoney() {
    Hive.box<double>(kClickerBrainBox)
        .put('money', (getMoney() + getClickAmount()));
  }

  bool canUpgrade(cost) {
    return getMoney() >= cost;
  }

  void decreaseMoney(amount) {
    Hive.box<double>(kClickerBrainBox).put('money', (getMoney() - amount));
  }

  void autoClickIncreaseMoney() {
    Hive.box<double>(kClickerBrainBox)
        .put('money', (getMoney() + getAutoClickNumber() * getClickAmount()));
  }
}
