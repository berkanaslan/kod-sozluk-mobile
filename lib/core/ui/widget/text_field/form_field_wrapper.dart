import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';

class FormFieldWrapper extends StatelessWidget {
  final Widget child;
  final double? width;

  const FormFieldWrapper({Key? key, required this.child, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.SMALL_PADDING,
      child: SizedBox(
        // height: 40,
        width: width ?? context.width * 0.85,
        child: child,
      ),
    );
  }
}
