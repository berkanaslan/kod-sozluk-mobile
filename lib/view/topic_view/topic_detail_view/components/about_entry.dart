import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
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
        buildAuthor(context),
        const SizedBox(width: 8.0),
        buildAvatar(),
      ],
    );
  }

  Column buildAuthor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildUsername(context),
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
      style: const TextStyle(fontSize: 10, color: AppColors.lightGrey),
    );
  }

  Text buildUsername(BuildContext context) {
    return Text(
      entry.createdBy!,
      style:  TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: context.theme.primaryColor),
    );
  }

  GestureDetector buildAvatar() {
    return GestureDetector(
      child: const CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.lightGrey,
        child: Icon(AppIcons.person, color: AppColors.white),
      ),
      onTap: onAvatarPressed,
    );
  }
}
