// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/settings_list_tile.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/refresh/refresh_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserStatisticView extends StatefulWidget {
  final bool wantKeepAlive;
  final int userId;
  final void Function()? onRefresh;

  const UserStatisticView({
    Key? key,
    this.wantKeepAlive = true,
    required this.userId,
    this.onRefresh,
  }) : super(key: key);

  @override
  _UserStatisticViewState createState() => _UserStatisticViewState();
}

class _UserStatisticViewState extends State<UserStatisticView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  late final int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      controller: _refreshController,
      onRefresh: () {
        if (widget.onRefresh != null) widget.onRefresh!();
        _refreshController.refreshCompleted();
      },
      child: ListView(
        children: const [
          AppListTile(title: "en çok favorilenenler"),
          AppListTile(title: "son oylanan"),
          AppListTile(title: "bu hafta dikkat çekenleri"),
          AppListTile(title: "el emeği göz nuru"),
          AppListTile(title: "en beğeninenleri"),
          AppListTile(title: "görseller"),
          AppListTile(title: "sorunsallar"),
          AppListTile(title: "sorunsal yanıtları"),
        ],
      ),
    );
  }
}
