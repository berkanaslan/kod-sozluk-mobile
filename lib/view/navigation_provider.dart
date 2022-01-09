import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/animations/fade_route.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/animations/slide_left_route.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_exit_dialog.dart';
import 'package:kod_sozluk_mobile/model/base/screen.dart';
import 'package:kod_sozluk_mobile/view/followings_topics_view/following_topics_view.dart';
import 'package:kod_sozluk_mobile/view/home_view/home_view.dart';
import 'package:kod_sozluk_mobile/view/message_view/messages_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_settings_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_view.dart';
import 'package:kod_sozluk_mobile/view/root_view.dart';
import 'package:kod_sozluk_mobile/view/search_view/search_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/topic_detail_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_view.dart';
import 'package:provider/provider.dart';

const HOME_SCREEN = 0;
const SEARCH_SCREEN = 1;
const MESSAGES_SCREEN = 2;
const FOLLOWING_TOPICS_SCREEN = 3;
const PROFILE_SCREEN = 4;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = HOME_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NotFoundView.PATH:
        return SlideLeftRoute(page: const NotFoundView());
      case HomeView.PATH:
        return SlideLeftRoute(page: const HomeView());
      case TopicView.PATH:
        return SlideLeftRoute(page: const TopicView());
      case EntryDetailView.PATH:
        if (settings.arguments is EntryDetailArgs) {
          return SlideLeftRoute(page: EntryDetailView(args: settings.arguments as EntryDetailArgs));
        }
        return SlideLeftRoute(page: const NotFoundView());
      case SearchView.PATH:
        return SlideLeftRoute(page: const SearchView());
      case MessagesView.PATH:
        return SlideLeftRoute(page: const MessagesView());
      case FollowingTopicsView.PATH:
        return SlideLeftRoute(page: const FollowingTopicsView());
      case ProfileView.PATH:
        return SlideLeftRoute(page: const ProfileView());
      case ProfileSettingsView.PATH:
        return SlideLeftRoute(page: const ProfileSettingsView());
      default:
        return SlideLeftRoute(page: const RootView());
    }
  }

  final Map<int, Screen> _screens = {
    HOME_SCREEN: Screen(
      title: LocaleKeys.home,
      icon: AppIcons.logo,
      child: const HomeView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return SlideLeftRoute(page: const HomeView());
        }
      },
      scrollController: ScrollController(),
    ),
    SEARCH_SCREEN: Screen(
      title: LocaleKeys.search,
      icon: AppIcons.search,
      child: const SearchView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return SlideLeftRoute(page: const SearchView());
        }
      },
      scrollController: ScrollController(),
    ),
    MESSAGES_SCREEN: Screen(
      title: LocaleKeys.messages,
      icon: AppIcons.message,
      child: const MessagesView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return SlideLeftRoute(page: const MessagesView());
        }
      },
      scrollController: ScrollController(),
    ),
    FOLLOWING_TOPICS_SCREEN: Screen(
      title: LocaleKeys.followings,
      icon: AppIcons.bell,
      child: const FollowingTopicsView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return SlideLeftRoute(page: const FollowingTopicsView());
        }
      },
      scrollController: ScrollController(),
    ),
    PROFILE_SCREEN: Screen(
      title: LocaleKeys.profile,
      icon: AppIcons.person,
      child: const ProfileView(),
      initialRoute: HomeView.PATH,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RegisterView.PATH:
            return FadeRoute(page: const RegisterView());
          case LoginView.PATH:
            return FadeRoute(page: const LoginView());
          case ProfileSettingsView.PATH:
            return SlideLeftRoute(page: const ProfileSettingsView());
          default:
            return SlideLeftRoute(page: const ProfileView());
        }
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

    return await AppAlertDialog.showConfirmationDialog(
        LocaleKeys.exit.locale, LocaleKeys.are_you_sure_to_exit_app.locale);
  }
}
