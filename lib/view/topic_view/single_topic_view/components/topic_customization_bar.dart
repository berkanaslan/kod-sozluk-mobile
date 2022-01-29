import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/icon_chip_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/text_chip_button.dart';
import 'package:kod_sozluk_mobile/view/root_view.dart';

class TopicCustomizationBar extends StatelessWidget {
  final String title;

  const TopicCustomizationBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.hoverColor,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(color: AppColors.lightGrey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSortByButton(),
                buildFilterButton(),
                buildAddFavoritesButton(),
                buildShareButton(),
                buildSearchButton(),
                buildAskQuestionButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  IconChipButton buildSortByButton() {
    return IconChipButton(
      icon: AppIcons.dollar,
      onPressed: () {},
      filled: true,
    );
  }

  IconChipButton buildFilterButton() {
    return IconChipButton(
      icon: AppIcons.sliders,
      onPressed: () {},
    );
  }

  IconChipButton buildAddFavoritesButton() {
    return IconChipButton(
      icon: AppIcons.bell,
      onPressed: () {},
    );
  }

  IconChipButton buildShareButton() {
    return IconChipButton(
      icon: AppIcons.share,
      onPressed: () {},
    );
  }

  IconChipButton buildSearchButton() {
    return IconChipButton(
      icon: AppIcons.search,
      onPressed: () {},
    );
  }

  TextChipButton buildAskQuestionButton(BuildContext context) {
    return TextChipButton(
      title: LocaleKeys.ask_question.locale,
      onPressed: () => context.rootNavigator.pushNamed(NotFoundView.PATH),
    );
  }
}
