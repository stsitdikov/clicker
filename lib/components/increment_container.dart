import 'package:flutter/material.dart';

class IncrementContainer extends StatelessWidget {
  const IncrementContainer(this.incrementNumber, this.border);

  final String incrementNumber;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: border,
      ),
      child: Center(
        child: Text(
          'x $incrementNumber',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
