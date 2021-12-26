import 'package:intl/intl.dart';

mixin StringUtil {
  static bool isEmptyString(String? string) => string != null && string.trim() == "";

  static bool isNotEmptyString(String? string) => !isEmptyString(string);

  static String toFormattedDate(String date) {
    final DateTime dt = DateTime.parse(date);
    final DateFormat formatter = DateFormat(dateTimePattern);
    return formatter.format(dt.toLocal());
  }
}

String get dateTimePattern => "dd.MM.yyyy HH:mm";
