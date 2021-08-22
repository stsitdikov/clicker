import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/money_display.dart';
import 'package:clicker/rows/blocked_row.dart';
import 'package:clicker/rows/1_click_row.dart';
import 'package:clicker/rows/2_autoclick_row.dart';
import 'package:clicker/rows/3_worker_row.dart';
import 'package:clicker/rows/4_manager_row.dart';
import 'package:clicker/rows/5_ceo_row.dart';
import 'package:clicker/rows/6_millionaire_row.dart';

class MainTab extends StatefulWidget {
  final List<AnimationController> animationControllerList;
  final List<Animation<double>> animationList;
  MainTab(this.animationControllerList, this.animationList);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  ScrollController scrollController = ScrollController();

  GlobalKey<AnimatedListState> rowsKey = GlobalKey();

  late List<Widget> listOfRows = [
    ClickRow(),
    BlockedRow(),
    AutoClickRow(widget.animationList[0], widget.animationControllerList[0]),
    BlockedRow(),
    WorkerRow(widget.animationList[1], widget.animationControllerList[1]),
    BlockedRow(),
    ManagerRow(widget.animationList[2], widget.animationControllerList[2]),
    BlockedRow(),
    CeoRow(widget.animationList[3], widget.animationControllerList[3]),
    BlockedRow(),
    MillionaireRow(widget.animationList[4], widget.animationControllerList[4]),
    BlockedRow(),
  ];

  late int removedBlockedRows = 0;

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    Widget transition(_, index, animation) {
      if (index < listOfRows.length) {
        return SizeTransition(
          key: UniqueKey(),
          sizeFactor: animation,
          child: listOfRows[index],
        );
      } else {
        return Container();
      }
    }

    clickerBrain.initialAutoClickTimer(widget.animationControllerList[0]);
    clickerBrain.initialWorkerTimer(widget.animationControllerList[1]);
    clickerBrain.initialManagerTimer(widget.animationControllerList[2]);
    clickerBrain.initialCeoTimer(widget.animationControllerList[3]);
    clickerBrain.initialMillionaireTimer(widget.animationControllerList[4]);

    if (removedBlockedRows == 0) {
      if (clickerBrain.showedRow(kAutoClickName) == 1.0) {
        listOfRows.removeAt(1);
      }
      if (clickerBrain.showedRow(kWorkerName) == 1.0) {
        listOfRows.removeAt(2);
      }
      if (clickerBrain.showedRow(kManagerName) == 1.0) {
        listOfRows.removeAt(3);
      }
      if (clickerBrain.showedRow(kCeoName) == 1.0) {
        listOfRows.removeAt(4);
      }
      if (clickerBrain.showedRow(kMillionaireName) == 1.0) {
        listOfRows.removeAt(5);
        listOfRows.removeAt(6);
      }
      removedBlockedRows++;
    }

    if (clickerBrain.isVisible(kAutoClickName) &&
        clickerBrain.showedRow(kAutoClickName) == 0.0) {
      listOfRows.removeAt(1);
      rowsKey.currentState?.insertItem(1, duration: kShowRowDuration);
      clickerBrain.updateShowedRow(kAutoClickName);
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isVisible(kWorkerName) &&
        clickerBrain.showedRow(kWorkerName) == 0.0) {
      listOfRows.removeAt(2);
      rowsKey.currentState?.insertItem(2, duration: kShowRowDuration);
      clickerBrain.updateShowedRow(kWorkerName);
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isVisible(kManagerName) &&
        clickerBrain.showedRow(kManagerName) == 0.0) {
      listOfRows.removeAt(3);
      rowsKey.currentState?.insertItem(3, duration: kShowRowDuration);
      clickerBrain.updateShowedRow(kManagerName);
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isVisible(kCeoName) &&
        clickerBrain.showedRow(kCeoName) == 0.0) {
      listOfRows.removeAt(4);
      rowsKey.currentState?.insertItem(4, duration: kShowRowDuration);
      clickerBrain.updateShowedRow(kCeoName);
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isVisible(kMillionaireName) &&
        clickerBrain.showedRow(kMillionaireName) == 0.0) {
      listOfRows.removeAt(5);
      rowsKey.currentState?.insertItem(5, duration: kShowRowDuration);
      rowsKey.currentState?.removeItem(
        6,
        (context, animation) => transition(context, 6, animation),
      );
      clickerBrain.updateShowedRow(kMillionaireName);
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
              itemBuilder: transition,
            ),
          ),
        ),
      ],
    );
  }
}
