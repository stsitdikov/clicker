import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:provider/provider.dart';

class ClickerScreen extends StatefulWidget {
  @override
  _ClickerScreenState createState() => _ClickerScreenState();
}

class _ClickerScreenState extends State<ClickerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: Provider.of<ClickerBrain>(context).autoClickerDuration,
    vsync: this,
  );
  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ClickerBrain>(context).autoClickAnimation == true) {
      controller.repeat();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MoneyDisplay(),
          ),
          Consumer<ClickerBrain>(
            builder: (context, clickerBrain, child) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Visibility(
                    visible: clickerBrain.isAutoClickVisible(),
                    child: ReusableProgressRow(
                      animation: animation,
                      title:
                          '${Provider.of<ClickerBrain>(context).autoClickNumber.toString()}  x  AutoClicker',
                      onUpgradeTap: () {
                        Provider.of<ClickerBrain>(context, listen: false)
                            .buyAutoClicker();
                      },
                      upgradeCost:
                          clickerBrain.autoClickCost.toStringAsFixed(1),
                    ),
                  ),
                  Visibility(
                    visible: clickerBrain.isAutoClickVisible(),
                    child: ReusableProgressRow(
                      animation: animation,
                      title:
                          '${clickerBrain.autoClickNumber.toString()}  x  AutoClicker',
                      onUpgradeTap: () {
                        Provider.of<ClickerBrain>(context, listen: false)
                            .buyAutoClicker();
                      },
                      upgradeCost:
                          clickerBrain.autoClickCost.toStringAsFixed(1),
                    ),
                  ),
                  ClickRow(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
