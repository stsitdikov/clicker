import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class MoneyLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  double money() {
    return box.get('money', defaultValue: kDefaultMoney) as double;
  }

  double clickAmount() {
    return box.get('clickAmount', defaultValue: kDefaultClickAmount) as double;
  }

  double autoClickNumber() {
    return box.get('autoClickNumber', defaultValue: kDefaultAutoClickNumber)
        as double;
  }

  void clickIncreaseMoney() {
    box.put('money', (money() + clickAmount()));
  }

  bool canUpgrade(cost) {
    return money() >= cost;
  }

  void decreaseMoney(amount) {
    box.put('money', (money() - amount));
  }

  void autoClickIncreaseMoney() {
    box.put('money', (money() + autoClickNumber() * clickAmount()));
  }
}
