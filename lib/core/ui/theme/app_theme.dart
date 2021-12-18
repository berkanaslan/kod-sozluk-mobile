import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';

enum MessageType { Info, Success, Warning, Error }

class AppColors {
  static const Color logo = Color(0xffc1282d);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xfff8f8f8);
  static const Color grey2 = Color(0xffD2D5DC);
  static const Color grey3 = Color(0xff9CA2AE);
  static const Color grey4 = Color(0xff6B7380);
  static const Color grey5 = Color(0xff4C5564);
  static const Color grey6 = Color(0xff384152);
  static const Color grey7 = Color(0xff202938);
  static const Color black = Color(0xff000000);
  static const Color secondary = Color(0xffFD4E5D);
  static const Color secondary2 = Color(0xffD9DDE8);
  static const Color secondary3 = Color(0xffB3CEE3);
  static const Color secondary4 = Color(0xff192233);

  static const Color primary = Color(0xff1c212d);
  static const lightGreen = Color(0xff35dba3);

  // State Colors
  static const Color info = Color(0xffA0C2FF);
  static const Color success = Color(0xff76CB66);
  static const Color warning = Color(0xffFBC757);
  static const Color error = Color(0xffBA0001);

  // Text Colors
  static const Color closedText = Color(0xff418b88);
  static const Color cancelledText = Color(0xffe5a24f);
  static const Color openText = Color(0xffdd635b);

  static const Color defaultText = Color(0xfff9e7e6);

  // Text Background Colors
  static const Color closedBackground = Color(0xfff3fdfc);
  static const Color cancelledBackground = Color(0xfffff6e9);
  static const Color openBackground = Color(0xfffae7e6);

  static const Color defaultBackground = Color(0xfff9e7e6);
}

ThemeData get theme => ThemeData(
      fontFamily: GoogleFonts.openSans().fontFamily,
      primarySwatch: generateMaterialColor(color: AppColors.primary),
      iconTheme: iconThemeData,
      textTheme: const TextTheme(headline6: TextStyle(color: AppColors.white)),
      appBarTheme: appBarTheme,
    );

IconThemeData get iconThemeData => const IconThemeData(color: AppColors.grey5);

AppBarTheme get appBarTheme => const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

void configLoadingIndicator() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..backgroundColor = AppColors.primary
    ..indicatorWidget = const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary))
    ..dismissOnTap = false;
}
