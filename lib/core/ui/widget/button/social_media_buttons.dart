import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          icon: AppIcons.facebook,
          color: AppColors.facebook,
          url: SharedPrefs?.getUser()?.connectedApplications?.facebook,
        ),
        SocialMediaButton(
          icon: AppIcons.twitter,
          color: AppColors.twitter,
          url: SharedPrefs?.getUser()?.connectedApplications?.twitter,
        ),
        SocialMediaButton(
          icon: AppIcons.instagram,
          color: AppColors.instagram,
          url: SharedPrefs?.getUser()?.connectedApplications?.instagram,
        ),
        SocialMediaButton(
          icon: AppIcons.github,
          url: SharedPrefs?.getUser()?.connectedApplications?.github,
        ),
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String? url;
  final Color? color;

  const SocialMediaButton({Key? key, required this.icon, this.url, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppIconButton(icon: icon, color: color, onPressed: url == null ? null : onTapped);
  }

  void onTapped() => launch(url!);
}
