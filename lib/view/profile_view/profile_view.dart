import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';

class ProfileView extends StatefulWidget {
  static const String PATH = "/profile_view";

  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.profile.locale,
      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
