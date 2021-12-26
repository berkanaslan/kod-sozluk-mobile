import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/view/navigation_provider.dart';
import 'package:provider/provider.dart';

class RootView extends StatelessWidget {
  static const String PATH = '/';

  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.buildLogger("RootView");

    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bottomNavigationBarItems = provider.screens
            .map((screen) => BottomNavigationBarItem(icon: Icon(screen.icon), label: screen.title.locale))
            .toList();

        final screenNavigators = provider.screens
            .map((screen) => Navigator(key: screen.navigatorState, onGenerateRoute: screen.onGenerateRoute))
            .toList();

        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            body: IndexedStack(children: screenNavigators, index: provider.currentTabIndex),
            bottomNavigationBar: BottomNavigationBar(
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
              selectedIconTheme: const IconThemeData(size: 24),
              unselectedIconTheme: const IconThemeData(size: 20),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: bottomNavigationBarItems,
              currentIndex: provider.currentTabIndex,
              onTap: provider.setTab,
            ),
          ),
        );
      },
    );
  }
}

class NotFoundView extends StatelessWidget {
  static const String PATH = "/not-found";

  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.title.locale,
      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
