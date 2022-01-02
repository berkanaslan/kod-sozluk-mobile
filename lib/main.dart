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

  runApp(EasyLocalization(
    path: AppConstants.ASSETS_LANG_PATH,
    supportedLocales: AppConstants.SUPPORTED_LOCALE,
    fallbackLocale: AppConstants.TR_LOCALE,
    child: buildBlocProviders(),
  ));

  configLoadingIndicator();
}

MultiProvider buildBlocProviders() {
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
      child: const KodSozlukApplication(),
    ),
  );
}

class KodSozlukApplication extends StatelessWidget {
  const KodSozlukApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      builder: EasyLoading.init(builder: (context, child) => ConnectivityListener(child: child!)),
      theme: theme,
      initialRoute: RootView.PATH,
      onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
    );
  }
}
