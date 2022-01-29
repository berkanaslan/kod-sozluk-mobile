import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefreshIndicator extends StatelessWidget {
  final RefreshController controller;
  final void Function() onRefresh;
  final void Function()? onLoading;
  final Widget child;

  const AppRefreshIndicator({
    Key? key,
    required this.controller,
    required this.onRefresh,
    required this.child,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      header: const RefreshHeader(),
      physics: const BouncingScrollPhysics(),
      footer: CustomFooter(builder: (context, mode) => const AppSizedBox()),
      enablePullDown: true,
      enablePullUp: onLoading != null,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }
}

class RefreshHeader extends StatelessWidget {
  const RefreshHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialClassicHeader(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      color: context.theme.primaryColor,
    );
  }
}
