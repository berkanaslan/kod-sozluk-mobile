import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String? title;
  final Widget? child;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, this.title, this.child, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 32,
      leading: buildLeadingIcon(context),
      iconTheme: context.theme.iconTheme.copyWith(color: AppColors.black),
      title: getTitle(context),
      centerTitle: true,
      backgroundColor: AppColors.white,
      actions: actions,
    );
  }

  Widget? buildLeadingIcon(BuildContext context) {
    if (!context.navigator.canPop()) return null;

    return AppIconButton(
      icon: AppIcons.back,
      onPressed: context.navigator.pop,
    );
  }

  Widget getTitle(BuildContext context) {
    if (child != null) return child!;

    return Text(
      title ?? "",
      maxLines: 2,
      style: context.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
