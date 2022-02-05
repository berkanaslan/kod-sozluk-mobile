import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget body;
  final bool rootNavigator;
  final Widget? leading;

  const AppScaffold({
    Key? key,
    this.title,
    this.titleWidget,
    this.actions,
    required this.body,
    this.rootNavigator = true,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        rootNavigator: rootNavigator,
        title: title,
        child: titleWidget,
        actions: actions,
        leading: leading,
      ),
      body: body,
    );
  }
}
