import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CeoLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  // box names

  String ceoNumberString = 'ceoNumber';
  String ceoCostString = 'ceoCost';
  String ceoCostOneString = 'ceoCostOne';
  String ceoIncrementString = 'ceoIncrement';
  String shouldAnimateCeoString = 'shouldAnimateCeo';

  // getters

  double ceoNumber() => box.get(ceoNumberString, defaultValue: 0.0) as double;

  double ceoCost() =>
      box.get(ceoCostString, defaultValue: kDefaultCeoCost) as double;

  double ceoCostOne() =>
      box.get(ceoCostOneString, defaultValue: kDefaultCeoCostOne) as double;

  double ceoIncrement() =>
      box.get(ceoIncrementString, defaultValue: kDefaultCeoIncrement) as double;

  double ceoVisible() => box.get('ceoVisible', defaultValue: 0.0) as double;

  double shouldAnimateCeo() =>
      box.get(shouldAnimateCeoString, defaultValue: 0.0) as double;

  double ceoDurationMilliseconds() => box.get('ceoDurationMilliseconds',
      defaultValue: kDefaultCeoDurationMilliseconds);

  double ceoDecreaseDurationCost() => box.get('ceoDecreaseDurationCost',
      defaultValue: kDefaultCeoDecreaseDurationCost);

  // functions

  void millionaireBuysCeos(millionaireNumber) {
    box.put('ceoNumber', ceoNumber() + millionaireNumber);
  }

  bool isCeoVisible(managerNumber) {
    if (ceoVisible() == 0.0 && managerNumber >= kManagerNumberToShowCeo) {
      box.put('ceoVisible', 1.0);
    }
    return ceoVisible() == 1.0;
  }

  void decreaseCeoDuration() => box.put('ceoDurationMilliseconds',
      (ceoDurationMilliseconds() - kDecreaseCeoDurationBy));

  void increaseCeoDecreaseDurationCost() => box.put(
      'ceoDecreaseDurationCost', (ceoDecreaseDurationCost() * kMainIncrement));
}
