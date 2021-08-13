import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:clicker/logic/constants.dart';

import 'package:clicker/rows/click_row.dart';

class BlockedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kRowHeight,
      child: Stack(
        children: [
          ClickRow(),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(),
          )
        ],
      ),
    );
  }
}
