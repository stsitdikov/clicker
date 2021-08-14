import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/money_display.dart';
import 'package:clicker/rows/blocked_row.dart';
import 'package:clicker/rows/autoclick_row.dart';
import 'package:clicker/rows/ceo_row.dart';
import 'package:clicker/rows/click_row.dart';
import 'package:clicker/rows/manager_row.dart';
import 'package:clicker/rows/worker_row.dart';

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

    if (removedBlockedRows == 0) {
      if (clickerBrain.showedAutoClick() == 1.0) {
        listOfRows.removeAt(1);
      }
      if (clickerBrain.showedWorker() == 1.0) {
        listOfRows.removeAt(2);
      }
      if (clickerBrain.showedManager() == 1.0) {
        listOfRows.removeAt(3);
      }
      if (clickerBrain.showedCeo() == 1.0) {
        listOfRows.removeAt(4);
        listOfRows.removeAt(5);
      }
      removedBlockedRows++;
    }

    if (clickerBrain.isAutoClickVisible() &&
        clickerBrain.showedAutoClick() == 0.0) {
      listOfRows.removeAt(1);
      rowsKey.currentState?.insertItem(1, duration: kShowRowDuration);
      clickerBrain.updateShowedAutoClick();
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isWorkerVisible() && clickerBrain.showedWorker() == 0.0) {
      listOfRows.removeAt(2);
      rowsKey.currentState?.insertItem(2, duration: kShowRowDuration);
      clickerBrain.updateShowedWorker();
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isManagerVisible() &&
        clickerBrain.showedManager() == 0.0) {
      listOfRows.removeAt(3);
      rowsKey.currentState?.insertItem(3, duration: kShowRowDuration);
      clickerBrain.updateShowedManager();
      clickerBrain.increaseListFlex();
      Timer(kShowRowDuration, () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: kShowRowDuration, curve: Curves.linear);
      });
    }

    if (clickerBrain.isCeoVisible() && clickerBrain.showedCeo() == 0.0) {
      listOfRows.removeAt(4);
      rowsKey.currentState?.insertItem(4, duration: kShowRowDuration);
      rowsKey.currentState?.removeItem(
        5,
        (context, animation) => transition(context, 5, animation),
      );
      clickerBrain.updateShowedCeo();
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
