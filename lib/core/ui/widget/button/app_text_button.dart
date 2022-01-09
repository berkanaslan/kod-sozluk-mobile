import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

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
    this.color,
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
          style: TextStyle(color: context.textTheme.bodyText1!.color),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(color: context.theme.primaryColor),
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
