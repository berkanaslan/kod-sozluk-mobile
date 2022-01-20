import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';

class BoldText extends StatelessWidget {
  final String text;

  const BoldText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold));
  }
}
