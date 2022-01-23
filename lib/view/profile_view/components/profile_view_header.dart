import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.username,
    required this.entryCount,
    required this.followings,
    required this.followers,
  }) : super(key: key);

  final String username;
  final String entryCount;
  final String followings;
  final String followers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.SMALL_PADDING,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(radius: 36, onAvatarPressed: () {}),
          const AppSizedBox(style: AppBoxStyle.HORIZONTAL, size: AppBoxSize.M),
          Expanded(
            child: UserStatisticWithUsername(
              username: username,
              entryCount: entryCount,
              followings: followings,
              followers: followers,
            ),
          ),
        ],
      ),
    );
  }
}

class UserStatisticWithUsername extends StatelessWidget {
  final String username;
  final String entryCount;
  final String followings;
  final String followers;

  const UserStatisticWithUsername({
    Key? key,
    required this.username,
    required this.entryCount,
    required this.followings,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(text: username),
        UserStatisticWidget(entryCount: entryCount, followings: followings, followers: followers),
      ],
    );
  }
}

class UserStatisticWidget extends StatelessWidget {
  final String entryCount;
  final String followings;
  final String followers;

  const UserStatisticWidget({
    Key? key,
    required this.entryCount,
    required this.followings,
    required this.followers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Translation
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatisticWithName(value: entryCount, name: "entry"),
          StatisticWithName(value: followings, name: "takip edilen"),
          StatisticWithName(value: followers, name: "takipçi"),
        ],
      ),
    );
  }
}

class StatisticWithName extends StatelessWidget {
  final String value;
  final String name;

  const StatisticWithName({Key? key, required this.value, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [BoldText(text: value), Text(name)],
    );
  }
}
