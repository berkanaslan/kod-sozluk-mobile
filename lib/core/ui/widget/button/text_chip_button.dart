import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class TextChipButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? fontSize;

  const TextChipButton({Key? key, required this.title, this.onPressed, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: TextButton(
        child: Text(title, style: TextStyle(color: AppColors.lightGrey, fontSize: fontSize ?? 13)),
        onPressed: onPressed,
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(AppColors.white),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          overlayColor: MaterialStateProperty.all(AppColors.transparent),
          side: MaterialStateProperty.all(const BorderSide(color: AppColors.lightGrey, width: 1)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0))),
        ),
      ),
    );
  }
}
