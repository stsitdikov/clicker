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

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with TickerProviderStateMixin {
  late final AnimationController autoClickController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getAutoClickDuration(),
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController workerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getWorkerDuration(),
    vsync: this,
  );
  late final Animation<double> workerAnimation = CurvedAnimation(
    parent: workerController,
    curve: Curves.linear,
  );

  late final AnimationController managerController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getManagerDuration(),
    vsync: this,
  );
  late final Animation<double> managerAnimation = CurvedAnimation(
    parent: managerController,
    curve: Curves.linear,
  );

  late final AnimationController ceoController = AnimationController(
    duration: Provider.of<ClickerBrain>(context).getCeoDuration(),
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
  }

  late Box<double> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(kClickerBrainBox);
  }

  @override
  Widget build(BuildContext context) {
    var clickerBrain = Provider.of<ClickerBrain>(context);

    clickerBrain.initialAutoClickTimer(autoClickController);
    clickerBrain.initialWorkerTimer(workerController);
    clickerBrain.initialManagerTimer(managerController);
    clickerBrain.initialCeoTimer(ceoController);

    int listFlex = 1;

    List<Widget> listOfRows = [
      ClickRow(),
    ];

    if (clickerBrain.isAutoClickVisible()) {
      listOfRows.add(AutoClickRow(autoClickAnimation, autoClickController));
      listFlex = 2;
    }

    if (clickerBrain.isWorkerVisible()) {
      listOfRows.add(WorkerRow(workerAnimation, workerController));
      listFlex = 3;
    }

    if (clickerBrain.isManagerVisible()) {
      listOfRows.add(ManagerRow(managerAnimation, managerController));
      listFlex = 4;
    }

    if (clickerBrain.isCeoVisible()) {
      listOfRows.add(CeoRow(ceoAnimation, ceoController));
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
            flex: listFlex,
            child: Scrollbar(
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: listOfRows,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
