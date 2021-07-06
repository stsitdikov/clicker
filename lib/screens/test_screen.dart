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

  int flex1 = 4;
  int flex2 = 0;

  @override
  Widget build(BuildContext context) {
    final total = flex1 + flex2;
    final width = MediaQuery.of(context).size.width;
    final width1 = (width * flex1) / total;
    final width2 = (width * flex2) / total;

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
                setState(() {
                  flex2 == 0 ? flex2 = 1 : flex2 = 0;
                });
              },
              child: Container(
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  color: Colors.blue,
                  width: width1,
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  color: Colors.green,
                  width: width2,
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
