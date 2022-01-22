import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/connection_listener.dart';
import 'package:kod_sozluk_mobile/view/navigation_provider.dart';
import 'package:kod_sozluk_mobile/view/root_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/connectivity_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/entry_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/home_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/login_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/register_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/topic_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await EasyLocalization.ensureInitialized();

  await SharedPrefs().init();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(EasyLocalization(
    path: AppConstants.ASSETS_LANG_PATH,
    supportedLocales: AppConstants.SUPPORTED_LOCALE,
    fallbackLocale: AppConstants.TR_LOCALE,
    child: buildBlocProviders(savedThemeMode),
  ));

  configLoadingIndicator();
}

MultiProvider buildBlocProviders(final AdaptiveThemeMode? savedThemeMode) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<NavigationProvider>(create: (context) => NavigationProvider(), lazy: false),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityViewModel>(create: (context) => ConnectivityViewModel(), lazy: false),
        BlocProvider<LoginViewModel>(create: (context) => LoginViewModel(), lazy: false),
        BlocProvider<RegisterViewModel>(create: (context) => RegisterViewModel()),
        BlocProvider<HomeViewModel>(create: (context) => HomeViewModel()),
        BlocProvider<TopicViewModel>(create: (context) => TopicViewModel()),
        BlocProvider<EntryViewModel>(create: (context) => EntryViewModel()),
      ],
      child: KodSozlukApplication(savedThemeMode: savedThemeMode),
    ),
  );
}

class KodSozlukApplication extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const KodSozlukApplication({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: theme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        builder: EasyLoading.init(builder: (context, child) => ConnectivityListener(child: child!)),
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: RootView.PATH,
        onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
      ),
    );
  }
}
