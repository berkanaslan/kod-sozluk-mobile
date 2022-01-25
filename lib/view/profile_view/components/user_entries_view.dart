// ignore_for_file: must_call_super

import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

class UserEntriesView extends StatefulWidget {
  final bool wantKeepAlive;
  final int userId;

  const UserEntriesView({Key? key, this.wantKeepAlive = true, required this.userId}) : super(key: key);

  @override
  _UserEntriesViewState createState() => _UserEntriesViewState();
}

class _UserEntriesViewState extends State<UserEntriesView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

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
    Future.microtask(() => getEntriesOfUser);
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
    pageNumber = 0;
    totalPages = null;
    entries.clear();
    await getEntriesOfUser();
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) return const SizedBox.shrink();

    return BlocConsumer<EntryRepository, BaseEntityState>(
      listener: (context, state) {},
      builder: (context, state) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ...entries.map((e) => SingleEntryView(entry: e, showTitle: true)).toList(),
          buildVisibilityDetector(),
        ],
      ),
    );
  }

  Widget buildVisibilityDetector() {
    return VisibilityDetector(
      key: Key("UK_$hashCode"),
      onVisibilityChanged: onEndOfDrag,
      child: const AppSizedBox(),
    );
  }

  void onEndOfDrag(info) async {
    if (info.visibleFraction == 1.0) {
      await getEntriesOfUser();
    }
  }
}
