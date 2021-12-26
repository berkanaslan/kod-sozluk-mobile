import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class ReadMoreButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool visible;

  const ReadMoreButton({Key? key, this.onPressed, required this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextButton.icon(
        icon: const Icon(AppIcons.more, color: AppColors.grey3, size: 15),
        label: Text(LocaleKeys.read_more.locale,
            style: const TextStyle(color: AppColors.grey3, fontStyle: FontStyle.italic, fontSize: 12)),
        style: ButtonStyle(overlayColor: MaterialStateProperty.all(AppColors.transparent)),
        onPressed: onPressed,
      ),
    );
  }
}
