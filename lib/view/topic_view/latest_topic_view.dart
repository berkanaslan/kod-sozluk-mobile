// ignore_for_file: must_call_super

import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/logger.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/list_tile/topic_tile.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/topic_repository.dart';
import 'package:kod_sozluk_mobile/view/navigation_provider.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/single_topic_view.dart';

class LatestTopicView extends StatefulWidget {
  const LatestTopicView({Key? key}) : super(key: key);

  @override
  _LatestTopicViewState createState() => _LatestTopicViewState();
}

class _LatestTopicViewState extends State<LatestTopicView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final TopicRepository topicRepository;

  int pageNumber = 0;
  int? totalPages;
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    topicRepository = context.read<TopicRepository>();
    Future.microtask(getLatestTopics);
  }

  Future<void> getLatestTopics() async {
    Page<Topic>? response = await topicRepository.getLatestTopics(pageNumber: pageNumber, totalPages: totalPages);

    if (response != null) {
      pageNumber++;
      totalPages = response.totalPages;
      topics.addAll(response.content!);
    }
  }

  Future<void> onRefresh() async {
    pageNumber = 0;
    totalPages = null;
    topics.clear();
    await getLatestTopics();
  }

  @override
  Widget build(BuildContext context) {
    Logger.buildLogger("LatestTopicView");

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: BlocConsumer<TopicRepository, BaseEntityState>(
        listener: (context, state) {},
        builder: (context, state) => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: NavigationProvider.of(context).screens[HOME_SCREEN].scrollController,
          shrinkWrap: true,
          itemCount: topics.length,
          itemBuilder: (context, i) {
            if (topics.isEmpty) return Text(LocaleKeys.nothing_found.locale);
            return TopicTile(topic: topics[i], onTap: () => onTopicSelected(topics[i]));
          },
        ),
      ),
    );
  }

  void onTopicSelected(final Topic topic) {
    context.rootNavigator.pushNamed(SingleTopicView.PATH, arguments: SingleTopicViewArgs(topic: topic));
  }
}
