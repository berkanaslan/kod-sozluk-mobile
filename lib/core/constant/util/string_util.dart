import 'package:intl/intl.dart';

mixin StringUtil {
  static bool isEmptyString(String? string) => string != null && string.trim() == "";

  static bool isNotEmptyString(String? string) => !isEmptyString(string);

  static String toFormattedDate(final DateTime date) {
    final DateFormat formatter = DateFormat(dateTimePattern);
    return formatter.format(date.toLocal());
  }
}

String get dateTimePattern => "dd.MM.yyyy HH:mm";
