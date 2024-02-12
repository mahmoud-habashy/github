import 'package:github/config/app_config.dart';
import 'package:intl/intl.dart';

class AppGlobal {
  static String intToStringAsFixed(int value) {
    String text = value.toString();
    if (value >= 1000) {
      text = "${(value / 1000).toStringAsFixed(1)}k";
    }
    return text;
  }

  static DateTime? parseDate(String stringDate) {
    return DateTime.tryParse(stringDate);
  }

  static String formatDate(String stringDate) {
    String result = "";
    DateTime? date = parseDate(stringDate);
    if (date != null) {
      result = DateFormat(AppConfig.repoDateFormat).format(date);
    }
    return result;
  }
}
