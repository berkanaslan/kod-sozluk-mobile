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
  final TextStyle? style;
  final EdgeInsets padding;

  const AppTextButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize,
    this.color,
    this.leadingText,
    this.trailingText,
    this.textAlign = TextAlign.center,
    this.style,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: padding,
        child: RichText(
          text: TextSpan(
            text: leadingText,
            style: style ?? TextStyle(color: context.textTheme.bodyText1!.color),
            children: <TextSpan>[
              TextSpan(
                text: title,
                style: style ?? TextStyle(color: context.theme.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = onPressed,
              ),
              TextSpan(text: trailingText),
            ],
          ),
          maxLines: 3,
          textAlign: textAlign!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
