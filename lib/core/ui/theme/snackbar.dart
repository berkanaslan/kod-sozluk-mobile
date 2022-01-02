import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

enum SnackBarType { SUCCESS, ERROR, WARNING, INFO }

mixin AppSnackBar {
  static void showSnackBar({required String message, int duration = 4, SnackBarType? type}) {
    Color? backgroundColor;
    String? title;

    if (type == SnackBarType.SUCCESS) {
      backgroundColor = AppColors.success;
      title = LocaleKeys.success.locale;
    } else if (type == SnackBarType.WARNING) {
      backgroundColor = AppColors.warning;
      title = LocaleKeys.warning.locale;
    } else if (type == SnackBarType.ERROR) {
      backgroundColor = AppColors.error;
      title = LocaleKeys.error.locale;
    } else {
      backgroundColor = AppColors.info;
      title = LocaleKeys.info.locale;
    }

    // Remove if exist snack bar:
    Get.closeCurrentSnackbar();

    // Show new:
    Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: message,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(milliseconds: 100),
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
        borderRadius: 8.0,
        mainButton: TextButton(
          onPressed: () => Get.closeCurrentSnackbar(),
          child: Text(
            LocaleKeys.close.locale,
            style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
