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
const double kDecreaseDurationIncrement = 2.0;

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
  kClickName: 150.0,
  kAutoClickName: 2.0,
  kWorkerName: 10.0,
  kManagerName: 100.0,
  kCeoName: 1500.0,
  kMillionaireName: 32000.0,
  kPresidentName: 1000000.0,
  kJeffreyName: 42000000.0,
};
const Map kMapOfUpgradeCostIncrements = {
  kClickName: 10.0,
  kAutoClickName: 1.1,
  kWorkerName: 1.2,
  kManagerName: 1.3,
  kCeoName: 1.4,
  kMillionaireName: 1.5,
  kPresidentName: 1.6,
  kJeffreyName: 1.7,
};
const Map kMapOfVisibilityRequirements = {
  kAutoClickName: 0.0,
  kWorkerName: 5.0,
  kManagerName: 5.0,
  kCeoName: 5.0,
  kMillionaireName: 5.0,
  kPresidentName: 5.0,
  kJeffreyName: 5.0,
};
const Map kMapOfDefaultDecreaseDurationCosts = {
  kAutoClickName: 1000.0,
  kWorkerName: 5000.0,
  kManagerName: 50000.0,
  kCeoName: 750000.0,
  kMillionaireName: 16000000.0,
  kPresidentName: 500000000.0,
  kJeffreyName: 21000000000.0,
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
const Map kMapOfDecreaseDurationIncrements = {
  kAutoClickName: 250.0,
  kWorkerName: 500.0,
  kManagerName: 1000.0,
  kCeoName: 2000.0,
  kMillionaireName: 4000.0,
  kPresidentName: 8000.0,
  kJeffreyName: 16000.0,
};
