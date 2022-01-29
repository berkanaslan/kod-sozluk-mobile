import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.SMALL_PADDING,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(radius: 36, onAvatarPressed: () {}),
          const AppSizedBox(style: AppBoxStyle.HORIZONTAL, size: AppBoxSize.M),
          Expanded(child: UserStatisticWithUsername(user: user)),
        ],
      ),
    );
  }
}

class UserStatisticWithUsername extends StatelessWidget {
  final User? user;

  const UserStatisticWithUsername({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(text: user?.username ?? ""),
        UserHeaderStatisticWidget(user: user),
      ],
    );
  }
}

// TODO: Translation
class UserHeaderStatisticWidget extends StatelessWidget {
  final User? user;

  const UserHeaderStatisticWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatisticWithName(value: user?.entryCount?.toString() ?? "", name: "entry"),
          StatisticWithName(value: user?.followingCount?.toString() ?? "", name: "takip edilen"),
          StatisticWithName(value: user?.followersCount?.toString() ?? "", name: "takipçi"),
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
