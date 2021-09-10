import 'package:clicker/logic/constants.dart';
import 'package:flutter/material.dart';

class GameMechanics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'The goal of the game is pretty straightforward - get as much money as possible 😃\n\nYou begin your game with only the cheapest click action available: every time you click the money circle - you get  a little sum.\n\nThe more you click - the more you earn - the more money-making options you get.\n\nEvery row can be upgraded in iterations of x1, x10, x100.\n\n',
              style: kInfoTextStyle,
              textAlign: TextAlign.center,
            ),
            Text(
              '- $kClickName determines how much money you get each click.\n\n- $kAutoClickName clicks for you every ${(kMapOfDefaultDurations[kAutoClickName] / 1000).toInt()} seconds (at first).\n\n- Every $kWorkerName gives you an $kAutoClickName every ${(kMapOfDefaultDurations[kWorkerName] / 1000).toInt()} seconds and so forth - it means every next item works slower, but gives you a set amount of previous items.',
              style: kInfoTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
