import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ManagerLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String managerNumberString = 'managerNumber';
  String managerCostString = 'managerCost';
  String managerCostOneString = 'managerCostOne';
  String managerIncrementString = 'managerIncrement';
  String shouldAnimateManagerString = 'shouldAnimateManager';

  // getters

  double managerNumber() =>
      box.get(managerNumberString, defaultValue: 0.0) as double;

  double managerCost() =>
      box.get(managerCostString, defaultValue: kDefaultManagerCost) as double;

  double managerCostOne() =>
      box.get(managerCostOneString, defaultValue: kDefaultManagerCostOne)
          as double;

  double managerIncrement() =>
      box.get('managerIncrement', defaultValue: kDefaultManagerIncrement)
          as double;

  double managerVisible() =>
      box.get('managerVisible', defaultValue: 0.0) as double;

  double shouldAnimateManager() =>
      box.get('shouldAnimateManager', defaultValue: 0.0) as double;

  double managerDurationMilliseconds() => box.get('managerDurationMilliseconds',
      defaultValue: kDefaultManagerDurationMilliseconds);

  double managerDecreaseDurationCost() => box.get('managerDecreaseDurationCost',
      defaultValue: kDefaultManagerDecreaseDurationCost);

  // functions

  void ceoBuysManagers(ceoNumber) =>
      box.put('managerNumber', (managerNumber() + ceoNumber));

  bool isManagerVisible(workerNumber) {
    if (managerVisible() == 0.0 && workerNumber >= kWorkerNumberToShowManager) {
      box.put('managerVisible', 1.0);
    }
    return managerVisible() == 1.0;
  }
}
