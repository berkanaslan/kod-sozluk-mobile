import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;
  final void Function()? onPressed;

  const AppIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      iconSize: size!,
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
