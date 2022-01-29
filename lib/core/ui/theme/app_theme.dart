import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_color_generator/material_color_generator.dart';

class AppColors {
  static const Color transparent = Colors.transparent;
  static const Color lightGrey = Color(0xff9CA2AE);
  static const Color grey = Color(0xff6B7380);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color primary = Color(0xff784384);
  static const Color primaryDark = Color(0xffd771fa);
  static const Color info = Color(0xff417adc);
  static const Color success = Color(0xff76CB66);
  static const Color warning = Color(0xffFBC757);
  static const Color error = Color(0xffBA0001);
  static const Color facebook = Color(0xff3b5998);
  static const Color twitter = Color(0xff1da1f2);
  static const Color instagram = Color(0xffc32aa3);
}

ThemeData get theme => ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      primarySwatch: generateMaterialColor(color: AppColors.primary),
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme,
    );

AppBarTheme get appBarTheme => const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    );

TabBarTheme get tabBarTheme {
  return const TabBarTheme(
    unselectedLabelColor: AppColors.lightGrey,
    labelColor: AppColors.black,
  );
}

// DARK THEME
ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      primarySwatch: generateMaterialColor(color: AppColors.primaryDark),
      primaryColor: AppColors.primaryDark,
      appBarTheme: appBarDarkTheme,
      indicatorColor: AppColors.primaryDark,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: AppColors.primaryDark),
      toggleableActiveColor: AppColors.primaryDark,
    );

AppBarTheme get appBarDarkTheme => AppBarTheme(
      centerTitle: true,
      titleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
    );

// UTILITIES
void configLoadingIndicator() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..userInteractions = false
    ..indicatorWidget = const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary))
    ..dismissOnTap = false;
}
