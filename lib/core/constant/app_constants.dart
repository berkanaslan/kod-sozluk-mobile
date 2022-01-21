import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/enum/language_enum.dart';

mixin AppConstants {
  // ------------------------------------------------------------------------------------------------------------------
  // LANG                                                                                                             /
  // ------------------------------------------------------------------------------------------------------------------
  static const ASSETS_LANG_PATH = "assets/languages";

  static const TR_LOCALE = Locale('tr', 'TR');

  static const List<Locale> SUPPORTED_LOCALE = [TR_LOCALE];

  static const TR_LOCALE_STRING = "tr-TR";

  static Language getLanguageEnum(BuildContext context) {
    if (context.locale == AppConstants.TR_LOCALE) {
      return Language.TURKISH;
    }

    return Language.TURKISH;
  }

  static String get localeKey {
    return TR_LOCALE_STRING;
  }

  // ------------------------------------------------------------------------------------------------------------------
  // HTTP - REST SERVICE CONSTANTS                                                                                    /
  // ------------------------------------------------------------------------------------------------------------------
  static const int PER_PAGE_20 = 20;
  static const String SORT_ASC = "a";
  static const String SORT_DESC = "d";
  static const String X_TOKEN = "X-TOKEN";

  // ------------------------------------------------------------------------------------------------------------------
  // IMAGE PATHs                                                                                                      /
  // ------------------------------------------------------------------------------------------------------------------
  static const String LOGO = "assets/images/kod-sozluk-logo.png";
  static const String LOGO_DARK = "assets/images/kod-sozluk-logo-dark.png";

  // ------------------------------------------------------------------------------------------------------------------
  // REGEX                                                                                                   /
  // ------------------------------------------------------------------------------------------------------------------
  static const String EMAIL_REGEX = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String PASSWORD_REGEX = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  static const String UPPERCASE_REGEX = "[A-Z]";
  static const String LOWERCASE_REGEX = "[a-z]";
  static const String EIGHT_CHAR_REGEX = ".{8,}";
  static const String DIGIT_REGEX = "[0-9]";
  static const String VALID_USERNAME_REGEX = r"^[A-Za-z][A-Za-z0-9_]{0,29}$";
}
