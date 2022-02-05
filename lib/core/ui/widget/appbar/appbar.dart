import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_icon_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String? title;
  final Widget? child;
  final List<Widget>? actions;
  final bool rootNavigator;
  final Widget? leading;

  const CustomAppBar({
    Key? key,
    this.title,
    this.child,
    this.actions,
    required this.rootNavigator,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: leading != null ? 64 : 32,
      leading: buildLeadingIcon(context),
      title: getTitle(context),
      centerTitle: true,
      actions: actions,
    );
  }

  Widget? buildLeadingIcon(BuildContext context) {
    if (!rootNavigator) {
      return leading != null
          ? GestureDetector(onTap: context.navigator.pop, child: leading)
          : AppIconButton(icon: AppIcons.back, onPressed: context.navigator.pop);
    }

    if (!context.rootNavigator.canPop()) return null;
    return leading != null
        ? GestureDetector(onTap: context.navigator.pop, child: leading)
        : AppIconButton(icon: AppIcons.back, onPressed: context.rootNavigator.pop);
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

class CustomSliverAppBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: buildLeadingIcon(context),
      elevation: 0,
      pinned: true,
      leadingWidth: title == null ? 4 : 32,
      titleSpacing: title == null ? 32 : 8,
      title: title,
      actions: actions,
    );
  }

  Widget? buildLeadingIcon(BuildContext context) {
    if (!context.rootNavigator.canPop()) return null;
    return AppIconButton(icon: AppIcons.back, onPressed: context.rootNavigator.pop);
  }
}