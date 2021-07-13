import 'package:clicker/components/click_row.dart';
import 'package:clicker/logic/clicker_brain.dart';
import 'package:clicker/logic/constants.dart';
import 'package:flutter/material.dart';
import 'package:clicker/components/money_display.dart';
import 'package:clicker/components/reusable_progress_row.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Box<double> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(kClickerBrainBox);
  }

  void click() async {
    double newMoney = (box.get('money', defaultValue: 0)) as double;
    newMoney = newMoney + 10;
    box.put('money', newMoney);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Test'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<double> box, _) {
          return Center(
            child: Text(box.get('money', defaultValue: 0).toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: click),
    );
  }
}
