import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/topic_tile.dart';
import 'package:kod_sozluk_mobile/view/navigation/navigation_provider.dart';
import 'package:kod_sozluk_mobile/viewmodel/topic_viewmodel.dart';
import 'package:provider/provider.dart';

class TopicView extends StatefulWidget {
  static const String PATH = "/topic";

  const TopicView({Key? key}) : super(key: key);

  @override
  _TopicViewState createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final TopicViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<TopicViewModel>();
    Future.microtask(() => viewModel.getPagedTopics());
  }

  @override
  void deactivate() {
    viewModel.clean();
    super.deactivate();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    Logger.buildLogger("TopicView");

    return RefreshIndicator(
      onRefresh: viewModel.refresh,
      child: ListView.builder(
        controller: NavigationProvider.of(context).screens[HOME_SCREEN].scrollController,
        shrinkWrap: true,
        itemCount: context.watch<TopicViewModel>().topics.length,
        itemBuilder: (context, i) {
          return TopicTile(topic: viewModel.topics[i], onTap: () {});
        },
      ),
    );
  }
}
