import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/add_entry_icon_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/single_entry_view.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/topic_customization_bar.dart';
import 'package:kod_sozluk_mobile/viewmodel/entry_viewmodel.dart';
import 'package:provider/provider.dart';

class TopicDetailArgs {
  final Topic topic;

  TopicDetailArgs({required this.topic});
}

class TopicDetailView extends StatefulWidget {
  static const String PATH = "/topic/detail";

  final TopicDetailArgs args;

  const TopicDetailView({Key? key, required this.args}) : super(key: key);

  @override
  _TopicDetailViewState createState() => _TopicDetailViewState();
}

class _TopicDetailViewState extends State<TopicDetailView> {
  late final EntryViewModel viewModel;
  late final Topic topic;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<EntryViewModel>();
    topic = widget.args.topic;
    Future.microtask(() => viewModel.getPagedEntriesByTopicId(topic.id!));
  }

  @override
  void dispose() {
    viewModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.buildLogger("TopicDetailView");
    return scaffold;
  }

  AppScaffold get scaffold {
    return AppScaffold(
      title: "${topic.name}",
      actions: [AddEntryIconButton(onPressed: () {})],
      body: body,
    );
  }

  Column get body {
    return Column(
      children: [
        TopicCustomizationBar(title: LocaleKeys.favs_all.locale),
        Expanded(child: buildEntryListView(context)),
      ],
    );
  }

  ListView buildEntryListView(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: context.watch<EntryViewModel>().entries.length,
      itemBuilder: (context, i) => SingleEntryView(entry: viewModel.entries[i]),
    );
  }
}
