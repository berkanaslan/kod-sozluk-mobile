import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/social_media_buttons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<EntryRepository>().isLoading) {
      return const AppShimmer(child: ProfileHeaderShimmer());
    }

    return buildHeader();
  }

  Padding buildHeader() {
    return Padding(
      padding: UIConstants.MEDIUM_PADDING,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(radius: 36, onAvatarPressed: () {}),
              const AppSizedBox(style: AppBoxStyle.HORIZONTAL, size: AppBoxSize.M),
              Expanded(child: UserStatisticWithUsername(user: user)),
            ],
          ),
          SocialMediaButtons(user: user),
        ],
      ),
    );
  }
}

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.white,
      child: child,
    );
  }
}

class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIConstants.MEDIUM_PADDING,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(radius: 36, onAvatarPressed: () {}),
              const AppSizedBox(style: AppBoxStyle.HORIZONTAL, size: AppBoxSize.M),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 15, width: context.width * 0.5, color: AppColors.primary),
                    UserHeaderStatisticWidget(user: User()),
                  ],
                ),
              ),
            ],
          ),
          SocialMediaButtons(user: User()),
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
