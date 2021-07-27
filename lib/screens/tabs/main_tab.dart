import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/money_display.dart';
import 'package:clicker/rows/autoclick_row.dart';
import 'package:clicker/rows/ceo_row.dart';
import 'package:clicker/rows/click_row.dart';
import 'package:clicker/rows/manager_row.dart';
import 'package:clicker/rows/worker_row.dart';

class MainTab extends StatefulWidget {
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with TickerProviderStateMixin {
  late var clickerBrain = Provider.of<ClickerBrain>(context);

  ScrollController scrollController = ScrollController();

  GlobalKey<AnimatedListState> rowsKey = GlobalKey();

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

  @override
  void dispose() {
    super.dispose();
    autoClickController.dispose();
    workerController.dispose();
    managerController.dispose();
    ceoController.dispose();
  }

  bool showedAutoClick = false;
  bool showedWorker = false;
  bool showedManager = false;
  bool showedCeo = false;

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

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
