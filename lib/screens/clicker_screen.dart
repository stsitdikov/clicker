import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/autoclick_row.dart';
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
    bool autoClickAnimation =
        Provider.of<ClickerBrain>(context).autoClickAnimation;

    if (autoClickAnimation == true) {
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
          ListView(
            shrinkWrap: true,
            children: [
              Visibility(
                visible:
                    Provider.of<ClickerBrain>(context).isAutoClickVisible(),
                child: AutoclickRow(controller),
              ),
              ClickRow(),
            ],
          ),
        ],
      ),
    );
  }
}
