import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? fontSize;
  final Color? color;
  final String? leadingText;
  final String? trailingText;
  final TextAlign? textAlign;

  const AppTextButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize,
    this.color = AppColors.primary,
    this.leadingText,
    this.trailingText,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
        text: TextSpan(
          text: leadingText,
          style: const TextStyle(color: AppColors.black),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: const TextStyle(color: AppColors.primary),
              recognizer: TapGestureRecognizer()..onTap = onPressed,
            ),
            TextSpan(text: trailingText),
          ],
        ),
        maxLines: 3,
        textAlign: textAlign!,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
