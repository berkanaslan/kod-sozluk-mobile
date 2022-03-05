import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/add_entry_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/refresh/refresh_indicator.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/entry_repository.dart';
import 'package:kod_sozluk_mobile/view/profile_view/profile_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/single_entry_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/topic_customization_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingleTopicViewArgs {
  final Topic topic;

  SingleTopicViewArgs({required this.topic});
}

class SingleTopicView extends StatefulWidget {
  static const String PATH = "/topic/detail";

  final SingleTopicViewArgs args;

  const SingleTopicView({Key? key, required this.args}) : super(key: key);

  @override
  _SingleTopicViewState createState() => _SingleTopicViewState();
}

class _SingleTopicViewState extends State<SingleTopicView> {
  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  late final EntryRepository entryRepository;
  late final Topic topic;

  int pageNumber = 0;
  int? totalPages;
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    entryRepository = context.read<EntryRepository>();
    topic = widget.args.topic;
  }

  Future<void> onRefresh() async {
    pageNumber = 0;
    totalPages = null;
    entries.clear();
    await getEntriesByTopicId();
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await getEntriesByTopicId();
    _refreshController.loadComplete();
  }

  Future<void> getEntriesByTopicId() async {
    Page<Entry>? response =
        await entryRepository.getEntriesByTopicId(topicId: topic.id!, pageNumber: pageNumber, totalPages: totalPages);

    if (response != null) {
      pageNumber++;
      totalPages = response.totalPages;
      entries.addAll(response.content!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // TODO: Translation
  @override
  Widget build(BuildContext context) {
    if (topic.id == 0) {
      return const Text("böyle bir şey yok!");
    }

    return scaffold;
  }

  AppScaffold get scaffold {
    return AppScaffold(
      title: "${topic.name}",
      actions: [
        AddEntryIconButton(onPressed: onAddEntryButtonPressed),
      ],
      body: body,
    );
  }

  Future<void> onAddEntryButtonPressed() async {
    context.rootNavigator
        .pushNamed(EntryEditorView.PATH, arguments: EntryEditorViewArgs(topic: topic))
        .then((entrySaved) {
      if (entrySaved is bool && entrySaved) {
        onRefresh();
      }
    });
  }

  Widget get body {
    return Column(
      children: [
        TopicCustomizationBar(title: LocaleKeys.favs_all.locale),
        Expanded(child: buildEntryListViewBody(context)),
      ],
    );
  }

  Widget buildEntryListViewBody(BuildContext context) {
    return BlocConsumer<EntryRepository, BaseEntityState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppRefreshIndicator(
          controller: _refreshController,
          onRefresh: onRefresh,
          onLoading: onLoading,
          child: buildEntryListView(),
        );
      },
    );
  }

  ListView buildEntryListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: entries.length,
      itemBuilder: (context, i) => SingleEntryView(
        entry: entries[i],
        onAvatarPressed: () => onAvatarPressed(context, i),
      ),
    );
  }

  void onAvatarPressed(BuildContext context, int i) {
    context.rootNavigator.pushNamed(
      ProfileView.PATH,
      arguments: ProfileViewArgs(userId: entries[i].author!.id!),
    );
  }
}
