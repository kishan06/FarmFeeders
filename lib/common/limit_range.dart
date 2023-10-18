import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value;
    if (newValue.text.isNotEmpty) {
      value = int.parse(newValue.text);
    } else {
      value = 1;
    }

    if (value < minRange) {
      print('value print in between 1 - 20');
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      print('not more 20');
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}

class utils {
  static showToast(String? msg) {
    if (msg != null && msg != "null" && msg.isNotEmpty) {
      Fluttertoast.showToast(msg: msg);
    }
  }
}
