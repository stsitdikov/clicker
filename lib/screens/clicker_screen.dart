import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clicker/logic/constants.dart';
import 'package:clicker/logic/clicker_brain.dart';

import 'tabs/main_tab.dart';
import 'tabs/upgrade_tab.dart';
import 'tabs/info_tab.dart';

class ClickerScreen extends StatefulWidget {
  final int initialIndex;
  ClickerScreen(this.initialIndex);
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with TickerProviderStateMixin {
  late int selectedIndex = widget.initialIndex;

  late var clickerBrain = Provider.of<ClickerBrain>(context);

  late final AnimationController autoClickController = AnimationController(
    duration: clickerBrain.getDuration(kAutoClickName),
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController workerController = AnimationController(
    duration: clickerBrain.getDuration(kWorkerName),
    vsync: this,
  );
  late final Animation<double> workerAnimation = CurvedAnimation(
    parent: workerController,
    curve: Curves.linear,
  );

  late final AnimationController managerController = AnimationController(
    duration: clickerBrain.getDuration(kManagerName),
    vsync: this,
  );
  late final Animation<double> managerAnimation = CurvedAnimation(
    parent: managerController,
    curve: Curves.linear,
  );

  late final AnimationController ceoController = AnimationController(
    duration: clickerBrain.getDuration(kCeoName),
    vsync: this,
  );
  late final Animation<double> ceoAnimation = CurvedAnimation(
    parent: ceoController,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    autoClickController.dispose();
    workerController.dispose();
    managerController.dispose();
    ceoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    clickerBrain.launchIsNormal();

    List<AnimationController> animationControllerList = [
      autoClickController,
      workerController,
      managerController,
      ceoController,
    ];
    List<Animation<double>> animationList = [
      autoClickAnimation,
      workerAnimation,
      managerAnimation,
      ceoAnimation,
    ];

    List<Widget> tabs = <Widget>[
      MainTab(animationControllerList, animationList),
      UpgradeTab(animationControllerList),
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
