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

  // ------------------------------------------------------------------------------------------------------------------
  // HTTP - REST SERVICE CONSTANTS                                                                                    /
  // ------------------------------------------------------------------------------------------------------------------
  static const int PER_PAGE_20 = 20;
  static const String SORT_DESC = "d";
  static const String SORT_ASC = "a";
}
