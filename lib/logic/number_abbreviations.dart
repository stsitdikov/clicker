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

    if (n < pow(10, 3))
      return reformat(n, '');
    else if (n >= pow(10, 3) && n < pow(10, 6))
      return reformat(n / pow(10, 3), 'K');
    else if (n >= pow(10, 6) && n < pow(10, 9))
      return reformat(n / pow(10, 6), 'M');
    else if (n >= pow(10, 9) && n < pow(10, 12))
      return reformat(n / pow(10, 9), 'B');
    else if (n >= pow(10, 12) && n < pow(10, 15))
      return reformat(n / pow(10, 12), 'T');
    else if (n >= pow(10, 15) && n < pow(10, 18))
      return reformat(n / pow(10, 15), 'Qa');
    else
      return 'Error';
  }
}
