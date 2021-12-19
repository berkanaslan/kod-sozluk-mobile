import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String? title;
  final Widget? child;

  const CustomAppBar({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: getTitle(context),
      centerTitle: true,
      backgroundColor: AppColors.white,
      elevation: 0,
    );
  }

  Widget getTitle(BuildContext context) {
    return child ?? Text(title ?? "", style: context.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold));
  }
}
