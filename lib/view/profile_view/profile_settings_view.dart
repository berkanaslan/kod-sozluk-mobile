import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/settings_list_tile.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/settings_list_toggle_tile.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/connected_apps_view.dart';
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
          buildConnectedAppsOption(context),
          const SettingsListTile(title: "kişisel bilgilerim"),
          const SettingsListTile(title: "yazı boyutu"),
          const SettingsListTile(title: "reklamsız"),
          const SettingsListTile(title: "takip/engellenmiş"),
          const SettingsListTile(title: "çöp"),
          const SettingsListTile(title: "e-mail adresimi değiştir"),
          const SettingsListTile(title: "şifremi değiştir"),
          buildDarkModeToggle(context),
          buildInAppNotificationsOption(context),
          const SettingsListTile(title: "kullanıcı sözleşmesi"),
          const SettingsListTile(title: "gizlilik politikası"),
          const SettingsListTile(title: "kullanım koşulları"),
          const SettingsListTile(title: "iletişim"),
          buildLogoutButton(context),
        ],
      ),
    );
  }

  SettingsListTile buildConnectedAppsOption(BuildContext context) {
    return SettingsListTile(
      title: "bağlı hesaplar",
      onPressed: () => context.rootNavigator.pushNamed(ConnectedAppsView.PATH),
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

  StatefulBuilder buildInAppNotificationsOption(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SettingsListToggleTile(
        title: "uygulama içi bildirimler",
        value: true,
        onTap: () {},
        onChanged: (value) => {},
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
