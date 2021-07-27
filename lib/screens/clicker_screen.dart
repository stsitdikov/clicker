import 'package:flutter/material.dart';

import 'package:clicker/logic/constants.dart';

import 'tabs/main_tab.dart';
import 'tabs/upgrade_tab.dart';
import 'tabs/info_tab.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = <Widget>[
      MainTab(),
      UpgradeTab(),
      InfoTab(),
    ];

    void onTabTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14.0,
        unselectedFontSize: 10.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Main'),
          BottomNavigationBarItem(
              icon: Icon(Icons.upgrade_outlined), label: 'Upgrades'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Info'),
        ],
        currentIndex: selectedIndex,
        onTap: onTabTapped,
      ),
      body: tabs.elementAt(selectedIndex),
    );
  }
}
