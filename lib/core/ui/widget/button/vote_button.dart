import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';

class VoteButton extends StatelessWidget {
  final bool up;
  final void Function()? onPressed;
  final Color? color;

  const VoteButton({
    Key? key,
    this.up = true,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.zero,
      icon: up ? AppIcons.up : AppIcons.down,
      size: 20,
      onPressed: onPressed,
    );
  }
}
