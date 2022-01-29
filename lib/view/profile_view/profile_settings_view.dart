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
import 'package:kod_sozluk_mobile/repository/user_repository.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/connected_apps_view.dart';
import 'package:kod_sozluk_mobile/view/root_view.dart';
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
          const AppListTile(title: "tercihler"),
          buildConnectedAppsOption(context),
          const AppListTile(title: "kişisel bilgilerim"),
          const AppListTile(title: "yazı boyutu"),
          const AppListTile(title: "reklamsız"),
          const AppListTile(title: "takip/engellenmiş"),
          const AppListTile(title: "çöp"),
          const AppListTile(title: "e-mail adresimi değiştir"),
          const AppListTile(title: "şifremi değiştir"),
          buildDarkModeToggle(context),
          buildInAppNotificationsOption(context),
          const AppListTile(title: "kullanıcı sözleşmesi"),
          const AppListTile(title: "gizlilik politikası"),
          const AppListTile(title: "kullanım koşulları"),
          const AppListTile(title: "iletişim"),
          buildLogoutButton(context),
        ],
      ),
    );
  }

  AppListTile buildConnectedAppsOption(BuildContext context) {
    return AppListTile(
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

  AppListTile buildLogoutButton(BuildContext context) {
    return AppListTile(
      title: "çıkış",
      onPressed: () async {
        await SharedPrefs.removeUserData();
        context.navigator.pushNamedAndRemoveUntil(RootView.PATH, (route) => false);
        context.read<UserRepository>().checkAuthenticationAndEmit();
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
