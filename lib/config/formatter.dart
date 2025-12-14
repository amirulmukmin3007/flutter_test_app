import 'package:intl/intl.dart';

class Formatter {
  String addComma(String value) {
    double parsedNumber = double.parse(value);
    return NumberFormat("#,##0.00").format(parsedNumber);
  }
}
