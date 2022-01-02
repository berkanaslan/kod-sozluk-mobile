import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/not_logged_profile_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  static const String PATH = "/profile_view";

  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthViewModel>().user == null) {
      return NotLoggedProfileView(
        onLoginButtonPressed: () => context.rootNavigator.pushNamed(LoginView.PATH),
        onRegisterButtonPressed: () => context.rootNavigator.pushNamed(RegisterView.PATH),
      );
    }

    return profileView;
  }

  AppScaffold get profileView {
    return AppScaffold(
      title: LocaleKeys.profile.locale,

      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
