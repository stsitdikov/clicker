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

    if (removedBlockedRows == 0) {
      clickerBrain.initialTimers(widget.animationControllerList);
      int i = 0;
      for (String name in kListOfNamesExceptClick) {
        i++;
        if (clickerBrain.showedRow(name) == 1.0) {
          listOfRows.removeAt(i);
          if (name == kListOfNamesExceptClick.last) {
            listOfRows.removeAt(i + 1);
          }
        }
      }
      removedBlockedRows++;
    }

    for (String name in kListOfNamesExceptClick) {
      if (clickerBrain.isVisible(name) && clickerBrain.showedRow(name) == 0.0) {
        listOfRows.removeAt(kListOfNamesExceptClick.indexOf(name) + 1);
        rowsKey.currentState?.insertItem(
            kListOfNamesExceptClick.indexOf(name) + 1,
            duration: kShowRowDuration);
        if (name == kListOfNamesExceptClick.last) {
          rowsKey.currentState?.removeItem(
            kListOfNamesExceptClick.indexOf(name) + 2,
            (context, animation) => transition(
                context, kListOfNamesExceptClick.indexOf(name) + 2, animation),
          );
        }
        clickerBrain.updateShowedRow(name);
        clickerBrain.increaseListFlex();
        Timer(kShowRowDuration, () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: kShowRowDuration, curve: Curves.linear);
        });
      }
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
