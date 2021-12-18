import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

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

  void pop() => navigator.pop();

  Future<Object?> pushNamed(String routeName) => navigator.pushNamed(routeName).whenComplete(() {});

  Future<Object?> pushReplacementNamed(String routeName) =>
      navigator.pushReplacementNamed(routeName).whenComplete(() {});

  Future<Object?> pushNamedAndRemoveUntil(String routeName) =>
      navigator.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false).whenComplete(() {});

  NavigatorState get rootNavigator => Navigator.of(this, rootNavigator: true);
}

extension SnackBarExtension on BuildContext {
  ScaffoldFeatureController showSnackBar({
    required String message,
    int duration = 4,
    MessageType? type,
  }) {
    final ScaffoldMessengerState scaffoldState = ScaffoldMessenger.of(this);

    Color? backgroundColor;

    if (type == MessageType.Success) {
      backgroundColor = AppColors.success;
    } else if (type == MessageType.Warning) {
      backgroundColor = AppColors.warning;
    } else if (type == MessageType.Error) {
      backgroundColor = AppColors.error;
    } else if (type == MessageType.Info) {
      backgroundColor = AppColors.info;
    } else {
      backgroundColor = AppColors.primary;
    }

    // Remove if exist snack bar:
    scaffoldState.removeCurrentSnackBar();

    // Show new:
    return scaffoldState.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
      ),
    );
  }
}
