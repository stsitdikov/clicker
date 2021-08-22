import 'package:flutter/material.dart';

const Color kBorderColor = Colors.black;
const Duration kShowButtonDuration = Duration(milliseconds: 500);
const String kClickerBrainBox = 'clicker_brain_box';

const TextStyle kInfoTextStyle = TextStyle(fontSize: 20.0, height: 1.35);

// screen names

const String kClickerScreenName = 'ClickerScreen';
const String kTestScreenName = 'TestScreen';
const String kLaunchScreenName = 'LaunchScreen';

// main constants

const String kAppName = 'Clicker';
const double kMainIncrement = 1.2;
const double kRowHeight = 70.0;
const double kGlobalUpgradeTileHeight = 100.0;
const Duration kShowRowDuration = Duration(milliseconds: 500);

// click row constants

const String kClickName = 'Click';
const double kDefaultClickAmount = 10;
const double kDefaultClickCost = 10;
const double kDefaultClickCostOne = 10;
const double kDefaultClickIncrement = 1;

// autoclick constants

const String kAutoClickName = 'AutoClick';
const double kMoneyToShowAutoClick = 10;
const double kDefaultAutoClickCost = 10;
const double kDefaultAutoClickCostOne = 10;
const double kDefaultAutoClickIncrement = 1;

const double kDefaultAutoClickDurationMilliseconds = 3000;
const double kDefaultAutoClickDecreaseDurationCost = 100;
const double kDecreaseAutoClickDurationBy = 1000;

// worker constants

const String kWorkerName = 'Worker';
const double kAutoClickNumberToShowWorker = 5;
const double kDefaultWorkerCost = 10;
const double kDefaultWorkerCostOne = 10;
const double kDefaultWorkerIncrement = 1;

const double kDefaultWorkerDurationMilliseconds = 10000;
const double kDefaultWorkerDecreaseDurationCost = 1000;
const double kDecreaseWorkerDurationBy = 5000;

// manager constants

const String kManagerName = 'Manager';
const double kWorkerNumberToShowManager = 5;
const double kDefaultManagerCost = 10;
const double kDefaultManagerCostOne = 10;
const double kDefaultManagerIncrement = 1;

const double kDefaultManagerDurationMilliseconds = 30000;
const double kDefaultManagerDecreaseDurationCost = 10000;
const double kDecreaseManagerDurationBy = 10000;

// ceo constants

const String kCeoName = 'Ceo';
const double kManagerNumberToShowCeo = 5;
const double kDefaultCeoCost = 10;
const double kDefaultCeoCostOne = 10;
const double kDefaultCeoIncrement = 1;

const double kDefaultCeoDurationMilliseconds = 60000;
const double kDefaultCeoDecreaseDurationCost = 100000;
const double kDecreaseCeoDurationBy = 10000;

// millionaire constants

const double kCeoNumberToShowMillionaire = 5;
const double kDefaultMillionaireCost = 10;
const double kDefaultMillionaireCostOne = 10;
const double kDefaultMillionaireIncrement = 1;

const double kDefaultMillionaireDurationMilliseconds = 60000;
const double kDefaultMillionaireDecreaseDurationCost = 100000;
const double kDecreaseMillionaireDurationBy = 10000;
