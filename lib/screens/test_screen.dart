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
  )..repeat();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Clicker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.lightGreen,
                ),
                SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: Container(
                    color: Colors.black.withOpacity(0),
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
