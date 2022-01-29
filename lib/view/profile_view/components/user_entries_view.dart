// ignore_for_file: must_call_super

import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/refresh/refresh_indicator.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserEntriesView extends StatefulWidget {
  final bool wantKeepAlive;
  final int userId;
  final void Function()? onRefresh;

  const UserEntriesView({
    Key? key,
    this.wantKeepAlive = true,
    required this.userId,
    this.onRefresh,
  }) : super(key: key);

  @override
  _UserEntriesViewState createState() => _UserEntriesViewState();
}

class _UserEntriesViewState extends State<UserEntriesView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  late final int? userId;
  late final EntryRepository entryRepository;
  int pageNumber = 0;
  int? totalPages;
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    entryRepository = context.read<EntryRepository>();
  }

  Future<void> getEntriesOfUser() async {
    Page<Entry>? response = await entryRepository.getEntriesOfUser(
      userId: userId!,
      pageNumber: pageNumber,
      totalPages: totalPages,
    );

    if (response != null) {
      pageNumber++;
      totalPages = response.totalPages;
      entries.addAll(response.content!);
    }
  }

  Future<void> onRefresh() async {
    if (widget.onRefresh != null) widget.onRefresh!();

    pageNumber = 0;
    totalPages = null;
    entries.clear();
    await getEntriesOfUser();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) return const SizedBox.shrink();

    return BlocConsumer<EntryRepository, BaseEntityState>(
      listener: (context, state) {},
      builder: (context, state) => AppRefreshIndicator(
        controller: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: ListView.separated(
          itemCount: entries.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) => SingleEntryView(entry: entries[index], showTitle: true),
        ),
      ),
    );
  }

  void onLoading() async {
    await getEntriesOfUser();
    _refreshController.loadComplete();
  }
}
