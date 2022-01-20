import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/not_logged_profile_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/profile_view_header.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/register_view.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_settings_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/login_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static const String PATH = "/profile_view";

  final String entryCount = "32";
  final String followings = "32";
  final String followers = "32";
  final String url = "";
  final String url1 = "";
  final String url2 = "";

  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {},
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return buildProfileView(context);
        }

        return NotLoggedProfileView(
          onLoginButtonPressed: () => context.navigator.pushNamed(LoginView.PATH),
          onRegisterButtonPressed: () => context.navigator.pushNamed(RegisterView.PATH),
        );
      },
    );
  }

  AppScaffold buildProfileView(BuildContext context) => buildScaffold(context);

  AppScaffold buildScaffold(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.profile.locale,
      actions: [
        buildProfileSettingsViewIconButton(context),
      ],
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileHeader(
            username: SharedPrefs.getUser()?.username ?? "",
            entryCount: entryCount,
            followings: followings,
            followers: followers,
          ),
          SocialMediaButtons(twitterURL: url, facebookURL: url1, instagramURL: url2),
          ...List.generate(123, (index) => const Text("12345")).toList(),
        ],
      ),
    );
  }

  AppIconButton buildProfileSettingsViewIconButton(BuildContext context) {
    return AppIconButton(
      icon: AppIcons.settings,
      color: context.theme.primaryColor,
      onPressed: () => context.navigator.pushNamed(ProfileSettingsView.PATH),
    );
  }
}

class SocialMediaButtons extends StatelessWidget {
  final String? twitterURL;
  final String? facebookURL;
  final String? instagramURL;
  final String? githubURL;

  const SocialMediaButtons({
    Key? key,
    this.twitterURL,
    this.facebookURL,
    this.instagramURL,
    this.githubURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SocialMediaButton(icon: AppIcons.facebook),
        SocialMediaButton(icon: AppIcons.twitter),
        SocialMediaButton(icon: AppIcons.instagram),
        SocialMediaButton(icon: AppIcons.github),
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String? url;

  const SocialMediaButton({Key? key, required this.icon, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(icon: icon, onPressed: url == null ? null : onTapped);
  }

  void onTapped() {
    // TODO: URL Launcher:
    debugPrint("$url");
  }
}
