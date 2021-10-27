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
const String kCeoName = 'CEO';
const String kMillionaireName = 'Millionaire';
const String kPresidentName = 'President';
const String kJeffreyName = 'Jeffrey';

// main constants

const String kAppName = 'Click & Tick';
const double kDefaultClickAmount = 0.1;

const int kHiveDecimals = 2;

const double kClickAmountIncreaseIncrement = 1.5;
const double kDecreaseDurationIncrement = 5.0;

const double kRowHeight = 70.0;
const double kGlobalUpgradeTileHeight = 100.0;
const Duration kShowRowDuration = Duration(milliseconds: 500);

const double kMaxDouble = 3870000000000000000.0;

// lists and maps

const List<String> kListOfNamesExceptClick = [
  kAutoClickName,
  kWorkerName,
  kManagerName,
  kCeoName,
  kMillionaireName,
  kPresidentName,
  kJeffreyName,
];
const Map kMapOfDefaultCosts = {
  kClickName: 100.0,
  kAutoClickName: 2.0,
  kWorkerName: 20.0,
  kManagerName: 100.0,
  kCeoName: 500.0,
  kMillionaireName: 2500.0,
  kPresidentName: 12500.0,
  kJeffreyName: 62500.0,
};
const Map kMapOfUpgradeCostIncrements = {
  kClickName: 30.0,
  kAutoClickName: 1.05,
  kWorkerName: 1.1,
  kManagerName: 1.2,
  kCeoName: 1.2,
  kMillionaireName: 1.2,
  kPresidentName: 1.2,
  kJeffreyName: 1.2,
};
const Map kMapOfDefaultDurations = {
  kAutoClickName: 3000.0,
  kWorkerName: 6000.0,
  kManagerName: 12000.0,
  kCeoName: 24000.0,
  kMillionaireName: 48000.0,
  kPresidentName: 96000.0,
  kJeffreyName: 192000.0,
};
const Map kMapOfDefaultDecreaseDurationCosts = {
  kAutoClickName: 1000.0,
  kWorkerName: 10000.0,
  kManagerName: 25000.0,
  kCeoName: 125000.0,
  kMillionaireName: 625000.0,
  kPresidentName: 3125000.0,
  kJeffreyName: 15625000.0,
};
const Map kMapOfDecreaseDurationIncrements = {
  kAutoClickName: 200.0,
  kWorkerName: 200.0,
  kManagerName: 300.0,
  kCeoName: 400.0,
  kMillionaireName: 500.0,
  kPresidentName: 600.0,
  kJeffreyName: 700.0,
};
const Map kMapOfVisibilityRequirements = {
  kAutoClickName: 0.0,
  kWorkerName: 5.0,
  kManagerName: 7.0,
  kCeoName: 9.0,
  kMillionaireName: 10.0,
  kPresidentName: 10.0,
  kJeffreyName: 10.0,
};
