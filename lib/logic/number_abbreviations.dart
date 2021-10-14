import 'dart:math';

class NumberAbbreviations {
  String getNumberString(number) {
    int numbersAfterDecimal = 2;
    double n = number;

    String reformat(n, numberLetter) {
      if ((n * 10).truncateToDouble() == (n * 10)) {
        numbersAfterDecimal = 1;
      }
      return n.toStringAsFixed(
              n.truncateToDouble() == n ? 0 : numbersAfterDecimal) +
          numberLetter;
    }

    int power = 0;

    Map mapOfNumberLetters = {
      3: 'K',
      6: 'M',
      9: 'B',
      12: 'T',
      15: 'Qa',
      18: 'Qi',
      21: 'Sx',
    };

    if (n < pow(10, 3))
      return reformat(n, '');
    else {
      for (int i = 3; i <= 21; i = i + 3)
        if (n >= pow(10, i) && n < pow(10, i + 3)) power = i;

      return reformat(n / pow(10, power), mapOfNumberLetters[power]);
    }
  }
}
