import 'package:foodfixer/core/core.dart';
import 'package:intl/intl.dart';

class NumUtils {
  static final _indianRupeesFormat = NumberFormat.currency(
    locale: 'en_IN',
    decimalDigits: 1,
    symbol: '₹ ',
    name: 'INR',
  );

  static String inRupeesFormat(num? value) => value.isNull 
    ? '' 
    : _indianRupeesFormat.format(value);

  static String nilOrValue(num? value) {
    return value.isNull ? '-Nil-' : value.toString();
  }

  static String toStrVal(num? val) {
    if(val.isNull) {
      return '';
    } else {
      if(val is int) {
        return val.toInt().toString();
      }
      return val!.toStringAsFixed(2);
    }
  }

  static double calcGST(double base, double percent) {
    final covertedVal = percent / 100;
    final addVal = 1 + covertedVal;
    return base * addVal;
  }
}
