import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const RoundedButton({Key? key, this.onPressed, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.75,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
    );
  }
}

class DialogRoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool positive;

  const DialogRoundedButton({Key? key, this.onPressed, required this.title, this.positive = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: UIConstants.SMALL_PADDING,
        width: context.width * 0.75,
        height: context.height * 0.05,
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodyText1!.copyWith(color: positive ? Colors.white : null),
          ),
        ),
        decoration: BoxDecoration(
          color: positive ? context.theme.primaryColor : null,
          border: Border.all(color: context.theme.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
