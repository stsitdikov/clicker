import 'dart:math';

import 'package:clicker/logic/constants.dart';

class NumberAbbreviations {
  String getNumberString(n) {
    int numbersAfterDecimal = 2;
    int power = 0;

    Map mapOfNumberLetters = {
      3: 'K',
      6: 'M',
      9: 'B',
      12: 'T',
      15: 'Qa',
      18: 'Qi',
    };

    String reformat(n, numberLetter) {
      if ((n * 10).truncate() == (n * 10)) {
        numbersAfterDecimal = 1;
      }
      return n.toStringAsFixed(n.truncate() == n ? 0 : numbersAfterDecimal) +
          numberLetter;
    }

    if (n > kMaxDouble)
      return 'MAX';
    else if (n < pow(10, 3))
      return reformat(n, '');
    else {
      for (int i = 3; i <= 18; i = i + 3)
        if (n >= pow(10, i) && n < pow(10, i + 3)) power = i;

      return reformat(n / pow(10, power), mapOfNumberLetters[power]);
    }
  }
}
