import 'package:clicker/rows/autoclick_row.dart';
import 'package:clicker/rows/ceo_row.dart';
import 'package:clicker/rows/click_row.dart';
import 'package:clicker/rows/manager_row.dart';
import 'package:clicker/rows/worker_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/screens/clicker_screen.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';
import 'dart:async';

enum TabItem { red, green, blue }

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  TabItem currentTab = TabItem.red;

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
