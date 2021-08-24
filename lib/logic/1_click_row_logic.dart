import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickRowLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String clickAmountString = 'clickAmount';
  String clickCostString = 'clickCost';
  String clickCostOneString = 'clickCostOne';
  String clickIncrementString = 'clickIncrement';

  // getters

  double clickAmount() =>
      box.get(clickAmountString, defaultValue: kDefaultClickAmount) as double;

  double clickCost() =>
      box.get(clickCostString, defaultValue: kDefaultClickCost) as double;

  double clickCostOne() =>
      box.get(clickCostOneString, defaultValue: kDefaultClickCostOne) as double;

  double clickIncrement() =>
      box.get(clickIncrementString, defaultValue: kDefaultClickIncrement)
          as double;
}
