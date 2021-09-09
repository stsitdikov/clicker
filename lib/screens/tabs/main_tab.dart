import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';

import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:clicker/rows/blocked_row.dart';
import 'package:clicker/rows/1_click_row.dart';

class MainTab extends StatefulWidget {
  final Map animationControllerMap;
  final Map animationMap;
  MainTab(this.animationControllerMap, this.animationMap);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  ScrollController scrollController = ScrollController();

  GlobalKey<AnimatedListState> rowsKey = GlobalKey();

  late List<Widget> listOfRows = [
    ClickRow(),
    BlockedRow(),
    ReusableProgressRow(
        animation: widget.animationMap[kAutoClickName],
        controller: widget.animationControllerMap[kAutoClickName],
        name: kAutoClickName),
    BlockedRow(),
    ReusableProgressRow(
        animation: widget.animationMap[kWorkerName],
        controller: widget.animationControllerMap[kWorkerName],
        name: kWorkerName),
    BlockedRow(),
    ReusableProgressRow(
        animation: widget.animationMap[kManagerName],
        controller: widget.animationControllerMap[kManagerName],
        name: kManagerName),
    BlockedRow(),
    ReusableProgressRow(
        animation: widget.animationMap[kCeoName],
        controller: widget.animationControllerMap[kCeoName],
        name: kCeoName),
    BlockedRow(),
    ReusableProgressRow(
        animation: widget.animationMap[kMillionaireName],
        controller: widget.animationControllerMap[kMillionaireName],
        name: kMillionaireName),
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
      clickerBrain.initialTimers(widget.animationControllerMap);
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
