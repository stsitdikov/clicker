import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class MoneyLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  double money() => box.get('money', defaultValue: 0.0) as double;

  double clickAmount() =>
      box.get('clickAmount', defaultValue: kDefaultClickAmount) as double;

  double autoClickNumber() =>
      box.get('autoClickNumber', defaultValue: 0.0) as double;

  void clickIncreaseMoney() => box.put('money', (money() + clickAmount()));

  bool canUpgrade(cost) => money() >= cost;

  void decreaseMoney(amount) => box.put('money', (money() - amount));

  void autoClickIncreaseMoney() =>
      box.put('money', (money() + autoClickNumber() * clickAmount()));
}
