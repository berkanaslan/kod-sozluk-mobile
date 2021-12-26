import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';

class AddEntryIconButton extends StatelessWidget {
  final void Function()? onPressed;

  const AddEntryIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: AppIcons.edit,
      color: AppColors.primary,
      onPressed: onPressed,
    );
  }
}
