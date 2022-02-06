import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  bool get isKeyBoardOpened => mediaQuery.viewInsets.bottom > 0;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension MediaQueryExtension on BuildContext {
  bool get isMobile => mediaQuery.size.shortestSide <= 650;

  bool get isTablet => mediaQuery.size.shortestSide >= 650;

  bool get isDesktop => mediaQuery.size.shortestSide >= 1100;

  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  NavigatorState get rootNavigator => Navigator.of(this, rootNavigator: true);
}

