import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/favorite_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/vote_button.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';

class EntryActionsBar extends StatelessWidget {
  final Entry entry;
  final void Function()? onUpVotePressed;
  final void Function()? onDownVotePressed;
  final void Function()? onSharePressed;
  final void Function()? onMorePressed;

  const EntryActionsBar({
    Key? key,
    required this.entry,
    this.onUpVotePressed,
    this.onDownVotePressed,
    this.onSharePressed,
    this.onMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            VoteButton(
              up: true,
              onPressed: onUpVotePressed,
            ),
            VoteButton(
              up: false,
              onPressed: onDownVotePressed,
            ),
            FavoriteButton(entry: entry),
          ],
        ),
        Row(
          children: [
            AppIconButton(
              icon: AppIcons.share,
              size: 18,
              onPressed: onSharePressed,
            ),
            AppIconButton(
              icon: AppIcons.ellipsis,
              size: 16,
              onPressed: onMorePressed,
            ),
          ],
        )
      ],
    );
  }
}
