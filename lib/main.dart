import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/animations/fade_route.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/connection_listener.dart';
import 'package:kod_sozluk_mobile/view/home_view/home_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/connectivity_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  await EasyLocalization.ensureInitialized();

  await SharedPrefs().init();

  runApp(
    EasyLocalization(
      path: AppConstants.ASSETS_LANG_PATH,
      supportedLocales: AppConstants.SUPPORTED_LOCALE,
      fallbackLocale: AppConstants.TR_LOCALE,
      child: buildBlocProviders(),
    ),
  );
}

MultiBlocProvider buildBlocProviders() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<ConnectivityViewModel>(create: (BuildContext context) => ConnectivityViewModel(), lazy: false),
    ],
    child: const KodSozlukApplication(),
  );
}

class KodSozlukApplication extends StatelessWidget {
  const KodSozlukApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      builder: EasyLoading.init(builder: (context, child) => ConnectivityListener(child: child!)),
      theme: theme,
      initialRoute: HomeView.PATH,
      onGenerateRoute: onGenerateRoute,
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.PATH:
        return FadeRoute(page: const HomeView());
    }
  }
}
