import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/topic_tile.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/view/navigation_provider.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/topic_detail_view.dart';
import 'package:kod_sozluk_mobile/viewmodel/topic_viewmodel.dart';
import 'package:provider/provider.dart';

class LatestTopicView extends StatefulWidget {
  const LatestTopicView({Key? key}) : super(key: key);

  @override
  _LatestTopicViewState createState() => _LatestTopicViewState();
}

class _LatestTopicViewState extends State<LatestTopicView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final TopicViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<TopicViewModel>();
    Future.microtask(() => viewModel.getPagedLatestTopics());
  }

  @override
  void deactivate() {
    viewModel.clearLatestTopics();
    super.deactivate();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    Logger.buildLogger("LatestTopicView");

    return RefreshIndicator(
      onRefresh: viewModel.refreshLatestTopics,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: NavigationProvider.of(context).screens[HOME_SCREEN].scrollController,
        shrinkWrap: true,
        itemCount: context.watch<TopicViewModel>().latestTopics.length,
        itemBuilder: (context, i) {
          if (viewModel.latestTopics.isEmpty) return Text(LocaleKeys.nothing_found.locale);
          return TopicTile(topic: viewModel.latestTopics[i], onTap: () => onTopicSelected(viewModel.latestTopics[i]));
        },
      ),
    );
  }

  void onTopicSelected(final Topic topic) {
    context.rootNavigator.pushNamed(EntryDetailView.PATH, arguments: EntryDetailArgs(topic: topic));
  }
}
