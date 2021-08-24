import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MillionaireLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String millionaireNumberString = 'millionaireNumber';
  String millionaireCostString = 'millionaireCost';
  String millionaireCostOneString = 'millionaireCostOne';
  String millionaireIncrementString = 'millionaireIncrement';
  String shouldAnimateMillionaireString = 'shouldAnimateMillionaire';

  // getters

  double millionaireNumber() =>
      box.get(millionaireNumberString, defaultValue: 0.0) as double;

  double millionaireCost() =>
      box.get(millionaireCostString, defaultValue: kDefaultMillionaireCost)
          as double;

  double millionaireCostOne() => box.get(millionaireCostOneString,
      defaultValue: kDefaultMillionaireCostOne) as double;

  double millionaireIncrement() => box.get(millionaireIncrementString,
      defaultValue: kDefaultMillionaireIncrement) as double;

  double millionaireVisible() =>
      box.get('millionaireVisible', defaultValue: 0.0) as double;

  double shouldAnimateMillionaire() =>
      box.get(shouldAnimateMillionaireString, defaultValue: 0.0) as double;

  double millionaireDurationMilliseconds() =>
      box.get('millionaireDurationMilliseconds',
          defaultValue: kDefaultMillionaireDurationMilliseconds);

  double millionaireDecreaseDurationCost() =>
      box.get('millionaireDecreaseDurationCost',
          defaultValue: kDefaultMillionaireDecreaseDurationCost);

  // functions

  // void billionaireBuysMillionaires(millionaireNumber) {
  //
  // }

  bool isMillionaireVisible(ceoNumber) {
    if (millionaireVisible() == 0.0 &&
        ceoNumber >= kCeoNumberToShowMillionaire) {
      box.put('millionaireVisible', 1.0);
    }
    return millionaireVisible() == 1.0;
  }

  void decreaseMillionaireDuration() => box.put(
      'millionaireDurationMilliseconds',
      (millionaireDurationMilliseconds() - kDecreaseMillionaireDurationBy));

  void increaseMillionaireDecreaseDurationCost() => box.put(
      'millionaireDecreaseDurationCost',
      (millionaireDecreaseDurationCost() * kMainIncrement));
}
