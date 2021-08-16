import 'dart:math';
import 'package:clicker/logic/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CeoLogic {
  Box box = Hive.box<double>(kClickerBrainBox);

  Duration ceoDuration = Duration(minutes: 1);

  // getters

  double ceoCost() =>
      box.get('ceoCost', defaultValue: kDefaultCeoCost) as double;

  double ceoCostOne() =>
      box.get('ceoCostOne', defaultValue: kDefaultCeoCostOne) as double;

  double ceoNumber() => box.get('ceoNumber', defaultValue: 0.0) as double;

  double ceoIncrement() =>
      box.get('ceoIncrement', defaultValue: kDefaultCeoIncrement) as double;

  double ceoVisible() => box.get('ceoVisible', defaultValue: 0.0) as double;

  double shouldAnimateCeo() =>
      box.get('shouldAnimateCeo', defaultValue: 0.0) as double;

  double initialCeoUpgradeDone() =>
      box.get('initialCeoUpgradeDone', defaultValue: 0.0) as double;

  // functions

  void buyCeo() {
    if (ceoIncrement() == 1.0) {
      if (initialCeoUpgradeDone() == 1.0) {
        updateCeoCostOne();
      }
      ceoCostIncrease();
      ceoNumberIncrease();
      if (initialCeoUpgradeDone() == 0.0) {
        box.put('initialCeoUpgradeDone', 1.0);
      }
    } else {
      updateCeoCostOne();
      ceoCostIncrease();
      ceoNumberIncrease();
      if (initialCeoUpgradeDone() == 1.0) {
        box.put('initialCeoUpgradeDone', 0.0);
      }
    }
  }

  void updateCeoCostOne() {
    double newCeoCostOne = ceoCostOne() * pow(kMainIncrement, ceoIncrement());
    box.put('ceoCostOne', newCeoCostOne);
  }

  void ceoCostIncrease() {
    box.put('ceoCost', ceoCostOne());
    incrementalCeoCost(0.0);
  }

  void ceoNumberIncrease() {
    box.put('ceoNumber', (ceoNumber() + ceoIncrement()));
    if (shouldAnimateCeo() == 0.0) {
      box.put('shouldAnimateCeo', 1.0);
    }
  }

  // void billionaireBuysCeos(ceoNumber) {
  //
  // }

  bool isCeoVisible(managerNumber) {
    if (ceoVisible() == 0.0 && managerNumber >= kManagerNumberToShowCeo) {
      box.put('ceoVisible', 1.0);
    }
    return ceoVisible() == 1.0;
  }

  void updateCeoIncrement() {
    if (ceoIncrement() == 1.0) {
      box.put('ceoIncrement', 10.0);
      box.put('ceoCostOne', ceoCost());
      incrementalCeoCost(ceoCostOne());
    } else if (ceoIncrement() == 10.0) {
      box.put('ceoIncrement', 100.0);
      box.put('ceoCost', ceoCostOne());
      incrementalCeoCost(ceoCostOne());
    } else if (ceoIncrement() == 100.0) {
      box.put('ceoIncrement', 1.0);
      box.put('ceoCost', ceoCostOne());
    }
  }

  void incrementalCeoCost(newValue) {
    double newCeoCost = newValue;
    for (var i = 1; i <= ceoIncrement(); i++) {
      newCeoCost = newCeoCost + ceoCostOne() * pow(kMainIncrement, i);
    }
    box.put('ceoCost', newCeoCost);
  }
}
