import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';

class AppAlertDialog {
  static show(String title, String message) {
    Get.generalDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
            title: _buildDialogTitle(title, context),
            content: _buildDialogContent(message, context),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('tamam')),
            ],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: "",
      barrierDismissible: true,
      pageBuilder: (context, animation1, animation2) => const AppSizedBox(style: AppBoxStyle.EMPTY),
    );
  }

  static Future<bool> showConfirmationDialog(String title, String message) async {
    return await Get.generalDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
            title: _buildDialogTitle(title, context),
            content: _buildDialogContent(message, context),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('iptal')),
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('devam')),
            ],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: "",
      barrierDismissible: true,
      pageBuilder: (context, animation1, animation2) => const AppSizedBox(style: AppBoxStyle.EMPTY),
    );
  }

  static Text _buildDialogTitle(String title, BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: context.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static Text _buildDialogContent(String message, BuildContext context) {
    return Text(message, style: context.theme.textTheme.bodyText1, textAlign: TextAlign.center);
  }
}
