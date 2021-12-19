import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/animations/fade_route.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_exit_dialog.dart';
import 'package:kod_sozluk_mobile/model/base/screen.dart';
import 'package:kod_sozluk_mobile/root_view.dart';
import 'package:kod_sozluk_mobile/view/home_view/home_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_view.dart';
import 'package:provider/provider.dart';

const HOME_SCREEN = 0;
const SEARCH_SCREEN = 1;
const MESSAGES_SCREEN = 2;
const FOLLOWED_TOPICS_SCREEN = 3;
const PROFILE_SCREEN = 4;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = HOME_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.PATH:
        return FadeRoute(page: const HomeView());
      case TopicView.PATH:
        return FadeRoute(page: const TopicView());
      default:
        return FadeRoute(page: const RootView());
    }
  }

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      title: 'HOME_SCREEN',
      icon: EvaIcons.code,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeView());
      },
      scrollController: ScrollController(),
    ),
    SEARCH_SCREEN: Screen(
      title: 'SEARCH_SCREEN',
      icon: EvaIcons.search,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeView());
      },
      scrollController: ScrollController(),
    ),
    MESSAGES_SCREEN: Screen(
      title: 'MESSAGES_SCREEN',
      icon: EvaIcons.messageCircleOutline,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeView());
      },
      scrollController: ScrollController(),
    ),
    FOLLOWED_TOPICS_SCREEN: Screen(
      title: 'FOLLOWED_TOPICS_SCREEN',
      icon: EvaIcons.bellOutline,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeView());
      },
      scrollController: ScrollController(),
    ),
    PROFILE_SCREEN: Screen(
      title: 'PROFILE_SCREEN',
      icon: EvaIcons.personOutline,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const HomeView());
      },
      scrollController: ScrollController(),
    )
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex]!;

  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToTopOfPage();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  void _scrollToTopOfPage() {
    if (currentScreen.scrollController != null && currentScreen.scrollController!.hasClients) {
      currentScreen.scrollController!.animateTo(0.0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    final NavigatorState? currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState == null) return false;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    }

    if (currentTabIndex != HOME_SCREEN) {
      setTab(HOME_SCREEN);
      notifyListeners();
      return false;
    }

    return await AppAlertDialog.show("çıkıyorsun?", "uygulamadan çıkmak istediğinden emin misin?");
  }
}
