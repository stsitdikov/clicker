import 'package:clicker/components/autoclick_row.dart';
import 'package:clicker/components/ceo_row.dart';
import 'package:clicker/components/click_row.dart';
import 'package:clicker/components/manager_row.dart';
import 'package:clicker/components/worker_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clicker/logic/constants.dart';

class ClickerScreen2 extends StatefulWidget {
  @override
  _ClickerScreen2State createState() => _ClickerScreen2State();
}

class _ClickerScreen2State extends State<ClickerScreen2>
    with TickerProviderStateMixin {
  GlobalKey<AnimatedListState> key = GlobalKey();

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
      key.currentState?.insertItem(1, duration: Duration(seconds: 1));
      showedAutoClick = true;
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isWorkerVisible() && showedWorker == false) {
      key.currentState?.insertItem(2, duration: Duration(seconds: 1));
      showedWorker = true;
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isManagerVisible() && showedManager == false) {
      key.currentState?.insertItem(3, duration: Duration(seconds: 1));
      showedManager = true;
      clickerBrain.increaseListFlex();
    }

    if (clickerBrain.isCeoVisible() && showedCeo == false) {
      key.currentState?.insertItem(4, duration: Duration(seconds: 1));
      showedCeo = true;
      clickerBrain.increaseListFlex();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: MoneyDisplay(),
          ),
          Expanded(
            flex: clickerBrain.listFlex().toInt(),
            child: Scrollbar(
              // child: ListView(
              //   shrinkWrap: true,
              //   reverse: true,
              //   children: listOfRows,
              // ),
              child: AnimatedList(
                reverse: true,
                key: key,
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
      ),
    );
  }
}
