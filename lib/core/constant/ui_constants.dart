import 'package:flutter/cupertino.dart';

mixin UIConstants {
  static const double X_SMALL = 4.0;
  static const double SMALL = 8.0;
  static const double MEDIUM = 16.0;
  static const double LARGE = 24.0;
  static const double X_LARGE = 64.0;

  static const EdgeInsets EDGE_INSETS_ZERO = EdgeInsets.zero;

  static const EdgeInsets SMALL_PADDING = EdgeInsets.all(SMALL);
  static const EdgeInsets MEDIUM_PADDING = EdgeInsets.all(MEDIUM);
  static const EdgeInsets LARGE_PADDING = EdgeInsets.all(LARGE);

  static const EdgeInsets VERTICAL_PADDING_SMALL = EdgeInsets.symmetric(vertical: SMALL);
  static const EdgeInsets VERTICAL_PADDING_MEDIUM = EdgeInsets.symmetric(vertical: MEDIUM);
  static const EdgeInsets VERTICAL_PADDING_LARGE = EdgeInsets.symmetric(vertical: LARGE);

  static const EdgeInsets HORIZONTAL_PADDING_SMALL = EdgeInsets.symmetric(horizontal: SMALL);
  static const EdgeInsets HORIZONTAL_PADDING_MEDIUM = EdgeInsets.symmetric(horizontal: MEDIUM);
  static const EdgeInsets HORIZONTAL_PADDING_LARGE = EdgeInsets.symmetric(horizontal: LARGE);

  static const SizedBox VERTICAL_X_SMALL_SIZED_BOX = SizedBox(height: X_SMALL);
  static const SizedBox VERTICAL_SMALL_SIZED_BOX = SizedBox(height: SMALL);
  static const SizedBox VERTICAL_MEDIUM_SIZED_BOX = SizedBox(height: MEDIUM);
  static const SizedBox VERTICAL_LARGE_SIZED_BOX = SizedBox(height: LARGE);
  static const SizedBox VERTICAL_X_LARGE_SIZED_BOX = SizedBox(height: X_LARGE);

  static const SizedBox HORIZONTAL_X_SMALL_SIZED_BOX = SizedBox(width: X_SMALL);
  static const SizedBox HORIZONTAL_SMALL_SIZED_BOX = SizedBox(width: SMALL);
  static const SizedBox HORIZONTAL_MEDIUM_SIZED_BOX = SizedBox(width: MEDIUM);
  static const SizedBox HORIZONTAL_X_LARGE_SIZED_BOX = SizedBox(width: LARGE);
  static const SizedBox HORIZONTAL_LARGE_SIZED_BOX = SizedBox(width: X_LARGE);

  static BorderRadius get BORDER_RADIUS_CIRCULAR_10 => BorderRadius.circular(10);
}
