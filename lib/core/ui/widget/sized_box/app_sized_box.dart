import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';

enum AppBoxSize { XS, S, M, L, XL }
enum AppBoxStyle { VERTICAL, HORIZONTAL, EMPTY }

class AppSizedBox extends StatelessWidget {
  final AppBoxSize? size;
  final AppBoxStyle? style;

  const AppSizedBox({
    Key? key,
    this.size,
    this.style = AppBoxStyle.VERTICAL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AppBoxStyle.EMPTY == style) {
      return const SizedBox(height: 0, width: 0);
    }

    if (AppBoxStyle.VERTICAL == style) {
      switch (size) {
        case AppBoxSize.XS:
          return UIConstants.VERTICAL_X_SMALL_SIZED_BOX;
        case AppBoxSize.S:
          return UIConstants.VERTICAL_SMALL_SIZED_BOX;
        case AppBoxSize.M:
          return UIConstants.VERTICAL_MEDIUM_SIZED_BOX;
        case AppBoxSize.L:
          return UIConstants.VERTICAL_LARGE_SIZED_BOX;
        case AppBoxSize.XL:
          return UIConstants.VERTICAL_X_LARGE_SIZED_BOX;
        default:
          return UIConstants.VERTICAL_SMALL_SIZED_BOX;
      }
    } else {
      switch (size) {
        case AppBoxSize.XS:
          return UIConstants.HORIZONTAL_X_SMALL_SIZED_BOX;
        case AppBoxSize.S:
          return UIConstants.HORIZONTAL_SMALL_SIZED_BOX;
        case AppBoxSize.M:
          return UIConstants.HORIZONTAL_MEDIUM_SIZED_BOX;
        case AppBoxSize.L:
          return UIConstants.HORIZONTAL_LARGE_SIZED_BOX;
        case AppBoxSize.XL:
          return UIConstants.HORIZONTAL_X_LARGE_SIZED_BOX;
        default:
          return UIConstants.HORIZONTAL_SMALL_SIZED_BOX;
      }
    }
  }
}
