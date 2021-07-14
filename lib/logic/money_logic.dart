import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

double money = Hive.box<double>(kClickerBrainBox)
    .get('money', defaultValue: kDefaultMoney) as double;

double clickAmount = (Hive.box<double>(kClickerBrainBox)
    .get('clickAmount', defaultValue: kDefaultClickAmount)) as double;

double clickCost = (Hive.box<double>(kClickerBrainBox)
    .get('clickCost', defaultValue: kDefaultClickCost)) as double;

double autoClickCost = (Hive.box<double>(kClickerBrainBox)
    .get('autoClickCost', defaultValue: kDefaultAutoClickCost)) as double;

double autoClickNumber = (Hive.box<double>(kClickerBrainBox)
    .get('autoClickNumber', defaultValue: kDefaultAutoClickNumber)) as double;

double workerCost = (Hive.box<double>(kClickerBrainBox)
    .get('workerCost', defaultValue: kDefaultWorkerCost)) as double;

double managerCost = (Hive.box<double>(kClickerBrainBox)
    .get('managerCost', defaultValue: kDefaultManagerCost)) as double;

class MoneyLogic {
  double newMoney = 0;

  void clickIncreaseMoney() {
    newMoney = money + clickAmount;
    Hive.box<double>(kClickerBrainBox).put('money', newMoney);
  }

  bool canUpgradeClick() {
    return money >= clickCost;
  }

  void decreaseMoney(amount) {
    newMoney = money - amount;

    Hive.box<double>(kClickerBrainBox).put('money', newMoney);
  }

  bool canUpgradeAutoClick() {
    return money >= autoClickCost;
  }

  void autoClickIncreaseMoney() {
    money = money + autoClickNumber * clickAmount;
  }

  bool canUpgradeWorker() {
    return money >= workerCost;
  }

  bool canUpgradeManager() {
    return money >= managerCost;
  }
}
