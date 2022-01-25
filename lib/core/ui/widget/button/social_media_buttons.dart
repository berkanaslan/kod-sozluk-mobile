import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButtons extends StatelessWidget {
  final User? user;

  const SocialMediaButtons({Key? key, required this.user}) : super(key: key);

  static const String FACEBOOK_PREFIX = "https://www.facebook.com/";
  static const String TWITTER_PREFIX = "https://twitter.com/";
  static const String INSTAGRAM_PREFIX = "https://www.instagram.com/";
  static const String GITHUB_PREFIX = "https://github.com/";

  String? getURLWithPrefix(String prefix, String? path) {
    if (path == null) return null;

    return prefix + path;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaButton(
          icon: AppIcons.facebook,
          color: AppColors.facebook,
          url: getURLWithPrefix(FACEBOOK_PREFIX, user?.connectedApplications?.facebook),
        ),
        SocialMediaButton(
          icon: AppIcons.twitter,
          color: AppColors.twitter,
          url: getURLWithPrefix(TWITTER_PREFIX, user?.connectedApplications?.twitter),
        ),
        SocialMediaButton(
          icon: AppIcons.instagram,
          color: AppColors.instagram,
          url: getURLWithPrefix(INSTAGRAM_PREFIX, user?.connectedApplications?.instagram),
        ),
        SocialMediaButton(
          icon: AppIcons.github,
          url: getURLWithPrefix(GITHUB_PREFIX, user?.connectedApplications?.github),
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
