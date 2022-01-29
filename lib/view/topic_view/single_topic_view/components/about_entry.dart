import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:kod_sozluk_mobile/core/constant/util/string_util.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';

class AboutEntry extends StatelessWidget {
  final Entry entry;
  final void Function()? onAvatarPressed;

  const AboutEntry({Key? key, required this.entry, this.onAvatarPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildAuthor(context),
        const AppSizedBox(style: AppBoxStyle.HORIZONTAL),
        buildAvatar(),
      ],
    );
  }

  Column buildAuthor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildUsername(context),
        const AppSizedBox(),
        buildDateTimeArea(),
      ],
    );
  }

  Widget buildDateTimeArea() {
    if (entry.createdAt == null) return SizedBox.shrink();

    String dateTime = StringUtil.toFormattedDate(entry.createdAt!);

    if (entry.modifiedAt == null) {
      return Text(
        dateTime,
        style: const TextStyle(fontSize: 10, color: AppColors.lightGrey),
      );
    }

    if (entry.modifiedAt != null && entry.createdAt != entry.modifiedAt) {
      dateTime += " - " + StringUtil.toFormattedDate(entry.modifiedAt!);
    }

    return Text(
      dateTime,
      style: const TextStyle(fontSize: 10, color: AppColors.lightGrey),
    );
  }

  Text buildUsername(BuildContext context) {
    return Text(
      entry.author!.username!,
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: context.theme.primaryColor),
    );
  }

  UserAvatar buildAvatar() {
    return UserAvatar(onAvatarPressed: onAvatarPressed, radius: 20);
  }
}

class UserAvatar extends StatelessWidget {
  final void Function()? onAvatarPressed;
  final double radius;

  const UserAvatar({Key? key, required this.onAvatarPressed, this.radius = 16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.lightGrey,
        child: Icon(
          AppIcons.person,
          color: AppColors.white,
          size: radius,
        ),
      ),
      onTap: onAvatarPressed,
    );
  }
}
