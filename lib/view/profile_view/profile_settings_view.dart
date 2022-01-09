import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/viewmodel/login_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileSettingsView extends StatefulWidget {
  static const String PATH = "/settings";

  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  _ProfileSettingsViewState createState() => _ProfileSettingsViewState();
}

// TODO: Move hard-coded String values to translation file.
class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      rootNavigator: false,
      title: "ayarlar",
      body: ListView(
        children: [
          firstRowBackground,
          const SettingsListTile(title: "tercihler"),
          const SettingsListTile(title: "bağlı hesaplar"),
          const SettingsListTile(title: "kişsel bilgilerim"),
          const SettingsListTile(title: "yazı boyutu"),
          const SettingsListTile(title: "reklamsız"),
          const SettingsListTile(title: "takip/engellenmiş"),
          const SettingsListTile(title: "çöp"),
          const SettingsListTile(title: "e-mail adresimi değiştir"),
          const SettingsListTile(title: "şifremi değiştir"),
          buildDarkModeToggle(context),
          const SettingsListTile(title: "uygulama içi bildirimler", isToggle: true),
          const SettingsListTile(title: "kullanıcı sözleşmesi"),
          const SettingsListTile(title: "gizlilik politikası"),
          const SettingsListTile(title: "kullanım koşulları"),
          const SettingsListTile(title: "iletişim"),
          buildLogoutButton(context),
        ],
      ),
    );
  }

  StatefulBuilder buildDarkModeToggle(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SettingsListToggleTile(
        title: "gece modu",
        value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
        onTap: () {},
        onChanged: (value) => setState(() => AdaptiveTheme.of(context).toggleThemeMode()),
      ),
    );
  }

  SettingsListTile buildLogoutButton(BuildContext context) {
    return SettingsListTile(
      title: "çıkış",
      onPressed: () async {
        await SharedPrefs.removeUserData();
        context.navigator.pop();
        context.read<LoginViewModel>().checkAuthenticationAndEmit();
      },
    );
  }

  Container get firstRowBackground {
    return Container(
      padding: UIConstants.SMALL_PADDING,
      color: context.theme.hoverColor,
      height: 50,
      width: double.infinity,
      child: firstRow,
    );
  }

  Row get firstRow {
    return Row(
      children: [
        userAvatar,
        UIConstants.HORIZONTAL_SMALL_SIZED_BOX,
        usernameText,
      ],
    );
  }

  Text get usernameText {
    return Text(
      SharedPrefs.getUser()!.username!,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  CircleAvatar get userAvatar {
    return const CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.lightGrey,
      child: Icon(AppIcons.person, color: AppColors.white),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool isToggle;

  const SettingsListTile({
    Key? key,
    required this.title,
    this.onPressed,
    this.isToggle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onPressed ?? () {},
      trailing: const Icon(AppIcons.forward),
    );
  }
}

class SettingsListToggleTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final void Function(bool value)? onChanged;
  final bool value;

  const SettingsListToggleTile({Key? key, required this.title, this.onChanged, this.value = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Switch(value: value, onChanged: onChanged),
      onTap: onTap,
    );
  }
}
