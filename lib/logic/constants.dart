import 'package:flutter/material.dart';

const Color kBorderColor = Colors.black;
const Duration kShowButtonDuration = Duration(milliseconds: 500);
const String kClickerBrainBox = 'clicker_brain_box';

const TextStyle kInfoTextStyle = TextStyle(fontSize: 20.0, height: 1.35);
const TextStyle kDialogButtonTextStyle = TextStyle(fontSize: 18.0);

// screen names

const String kClickerScreenName = 'ClickerScreen';
const String kTestScreenName = 'TestScreen';
const String kLaunchScreenName = 'LaunchScreen';

// row names

const String kClickName = 'Click';
const String kAutoClickName = 'AutoClick';
const String kWorkerName = 'Worker';
const String kManagerName = 'Manager';
const String kCeoName = 'Ceo';
const String kMillionaireName = 'Millionaire';

// main constants

const String kAppName = 'Click & Tick';
const double kDefaultClickAmount = 10.0;
const double kMainIncrement = 1.2;
const double kRowHeight = 70.0;
const double kGlobalUpgradeTileHeight = 100.0;
const Duration kShowRowDuration = Duration(milliseconds: 500);

// lists and maps

const List<String> kListOfNamesExceptClick = [
  kAutoClickName,
  kWorkerName,
  kManagerName,
  kCeoName,
  kMillionaireName,
];
const Map kMapOfDefaultCosts = {
  kClickName: 10.0,
  kAutoClickName: 10.0,
  kWorkerName: 10.0,
  kManagerName: 10.0,
  kCeoName: 10.0,
  kMillionaireName: 10.0,
};
const Map kMapOfDefaultDurations = {
  kAutoClickName: 3000.0,
  kWorkerName: 10000.0,
  kManagerName: 30000.0,
  kCeoName: 60000.0,
  kMillionaireName: 120000.0,
};
const Map kMapOfDefaultDecreaseDurationCosts = {
  kAutoClickName: 100.0,
  kWorkerName: 1000.0,
  kManagerName: 10000.0,
  kCeoName: 100000.0,
  kMillionaireName: 1000000.0,
};
const Map kMapOfVisibilityRequirements = {
  kAutoClickName: 10.0,
  kWorkerName: 5.0,
  kManagerName: 5.0,
  kCeoName: 5.0,
  kMillionaireName: 5.0,
};
const Map kMapOfDecreaseDurationIncrements = {
  kAutoClickName: 1000.0,
  kWorkerName: 5000.0,
  kManagerName: 10000.0,
  kCeoName: 10000.0,
  kMillionaireName: 10000.0,
};
