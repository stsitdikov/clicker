import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/autoclick_row.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: Duration(seconds: 3),
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

  int flexExpand = 0;

  @override
  Widget build(BuildContext context) {
    flexExpand = (controller.value * 100).round();
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
                controller.forward();
                controller.addListener(() {
                  setState(() {});
                });
              },
              child: Container(
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            child: Row(
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
            ),
          ),
        ],
      ),
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
