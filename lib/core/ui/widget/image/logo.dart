import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';

class Logo extends StatelessWidget {
  final double? size;

  const Logo({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppConstants.LOGO, width: size ?? context.width * 0.5);
  }
}
