import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/util/string_util.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
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
        buildAuthor(),
        const SizedBox(width: 8.0),
        buildAvatar(),
      ],
    );
  }

  Column buildAuthor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildUsername(),
        buildDateTimeArea(),
      ],
    );
  }

  Text buildDateTimeArea() {
    String dateTime = StringUtil.toFormattedDate(entry.creationDate!);

    if (entry.lastModifiedDate != null && entry.creationDate != entry.lastModifiedDate) {
      dateTime += " - " + StringUtil.toFormattedDate(entry.lastModifiedDate!);
    }

    return Text(
      dateTime,
      style: const TextStyle(fontSize: 10, color: AppColors.grey3),
    );
  }

  Text buildUsername() {
    return Text(
      entry.createdBy!,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
    );
  }

  GestureDetector buildAvatar() {
    return GestureDetector(
      child: const CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.grey2,
        child: Icon(AppIcons.person, color: AppColors.white),
      ),
      onTap: onAvatarPressed,
    );
  }
}
