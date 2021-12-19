import 'package:flutter/material.dart';

class Screen {
  final String title;
  final IconData icon;
  final Widget child;
  final RouteFactory onGenerateRoute;
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorState;
  final ScrollController? scrollController;

  Screen({
    required this.title,
    required this.icon,
    required this.child,
    required this.onGenerateRoute,
    required this.initialRoute,
    required this.navigatorState,
    this.scrollController,
  });
}
