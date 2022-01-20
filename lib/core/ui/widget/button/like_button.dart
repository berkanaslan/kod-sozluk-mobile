import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';

class LikeButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool liked;

  const LikeButton({
    Key? key,
    this.onPressed,
    this.liked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      color: liked ? AppColors.primaryDark : null,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.zero,
      icon: AppIcons.logo,
      size: 16,
      onPressed: onPressed,
    );
  }
}
