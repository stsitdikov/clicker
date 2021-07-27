import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'tabs/upgrade_tab.dart';
import 'tabs/info_tab.dart';

import 'package:clicker/rows/autoclick_row.dart';
import 'package:clicker/rows/ceo_row.dart';
import 'package:clicker/rows/click_row.dart';
import 'package:clicker/rows/manager_row.dart';
import 'package:clicker/rows/worker_row.dart';

import 'package:clicker/components/money_display.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with TickerProviderStateMixin {
  GlobalKey<AnimatedListState> rowsKey = GlobalKey();

  late var clickerBrain = Provider.of<ClickerBrain>(context);

  late final AnimationController autoClickController = AnimationController(
    duration: clickerBrain.getAutoClickDuration(),
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController workerController = AnimationController(
    duration: clickerBrain.getWorkerDuration(),
    vsync: this,
  );
  late final Animation<double> workerAnimation = CurvedAnimation(
    parent: workerController,
    curve: Curves.linear,
  );

  late final AnimationController managerController = AnimationController(
    duration: clickerBrain.getManagerDuration(),
    vsync: this,
  );
  late final Animation<double> managerAnimation = CurvedAnimation(
    parent: managerController,
    curve: Curves.linear,
  );

  late final AnimationController ceoController = AnimationController(
    duration: clickerBrain.getCeoDuration(),
    vsync: this,
  );
  late final Animation<double> ceoAnimation = CurvedAnimation(
    parent: ceoController,
    curve: Curves.linear,
  );

  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    autoClickController.dispose();
    workerController.dispose();
    managerController.dispose();
    ceoController.dispose();
  }

  late Box<double> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(kClickerBrainBox);
  }

  bool showedAutoClick = false;
  bool showedWorker = false;
  bool showedManager = false;
  bool showedCeo = false;

  @override
  Widget build(BuildContext context) {
    clickerBrain.initialAutoClickTimer(autoClickController);
    clickerBrain.initialWorkerTimer(workerController);
    clickerBrain.initialManagerTimer(managerController);
    clickerBrain.initialCeoTimer(ceoController);

    List<Widget> listOfRows = [
      ClickRow(),
      AutoClickRow(autoClickAnimation, autoClickController),
      WorkerRow(workerAnimation, workerController),
      ManagerRow(managerAnimation, managerController),
      CeoRow(ceoAnimation, ceoController),
    ];

    if (clickerBrain.isAutoClickVisible() && showedAutoClick == false) {
      rowsKey.currentState?.insertItem(1, duration: kShowRowDuration);
      showedAutoClick = true;
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isWorkerVisible() && showedWorker == false) {
      rowsKey.currentState?.insertItem(2, duration: kShowRowDuration);
      showedWorker = true;
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isManagerVisible() && showedManager == false) {
      rowsKey.currentState?.insertItem(3, duration: kShowRowDuration);
      showedManager = true;
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isCeoVisible() && showedCeo == false) {
      rowsKey.currentState?.insertItem(4, duration: kShowRowDuration);
      showedCeo = true;
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    List<Widget> tabs = <Widget>[
      RowsTab(
          clickerBrain: clickerBrain,
          scrollController: scrollController,
          rowsKey: rowsKey,
          listOfRows: listOfRows),
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

class RowsTab extends StatelessWidget {
  const RowsTab({
    required this.clickerBrain,
    required this.scrollController,
    required this.rowsKey,
    required this.listOfRows,
  });

  final ClickerBrain clickerBrain;
  final ScrollController scrollController;
  final GlobalKey<AnimatedListState> rowsKey;
  final List<Widget> listOfRows;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: MoneyDisplay(),
        ),
        Expanded(
          flex: clickerBrain.listFlex().toInt(),
          child: Scrollbar(
            child: AnimatedList(
              controller: scrollController,
              reverse: true,
              key: rowsKey,
              initialItemCount: clickerBrain.itemCount().toInt(),
              shrinkWrap: true,
              itemBuilder: (_, index, animation) {
                if (index < listOfRows.length) {
                  return SizeTransition(
                    key: UniqueKey(),
                    sizeFactor: animation,
                    child: listOfRows[index],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
