import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  late final AnimationController autoClickController = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  );
  late final Animation<double> autoClickAnimation = CurvedAnimation(
    parent: autoClickController,
    curve: Curves.linear,
  );

  late final AnimationController expandController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );

  @override
  void dispose() {
    super.dispose();
    autoClickController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                expandController.forward();
                expandController.addListener(() {
                  setState(() {});
                });
              },
              child: Container(
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            child: ExpandableRow((expandController.value * 100).round()),
          ),
        ],
      ),
    );
  }
}

class ExpandableRow extends StatelessWidget {
  ExpandableRow(this.flexExpand);

  final int flexExpand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 400,
          child: Container(
            color: Colors.blue,
          ),
        ),
        Expanded(
          flex: flexExpand,
          child: Container(
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class AnimatedStack extends StatelessWidget {
  const AnimatedStack({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.lightGreen,
        ),
        SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
