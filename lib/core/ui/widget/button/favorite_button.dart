import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final Entry entry;

  const FavoriteButton({Key? key, required this.entry}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late final Entry entry;
  late bool favorited;

  @override
  void initState() {
    super.initState();
    entry = widget.entry;
    favorited = entry.favorited;
    entry.favoritesCount ??= entry.favoritesCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPrefs.getUser() == null) return const SizedBox.shrink();

    return Row(
      children: [
        AppIconButton(
          color: favorited ? context.theme.primaryColor : AppColors.grey,
          icon: AppIcons.logo,
          size: 20,
          onPressed: () async {
            if (favorited) {
              entry.favoritesCount = entry.favoritesCount! - 1;
            } else {
              entry.favoritesCount = entry.favoritesCount! + 1;
            }

            log("${entry.favoritesCount} berkan");

            favorited = await context.read<EntryRepository>().addToFavorite(entryId: entry.id ?? 0);

            setState(() {});
          },
        ),
        if (entry.favoritesCount != null && entry.favoritesCount != 0)
          Text(
            entry.favoritesCount.toString(),
            style: context.textTheme.bodyText2!.copyWith(color: AppColors.grey),
          )
      ],
    );
  }
}
