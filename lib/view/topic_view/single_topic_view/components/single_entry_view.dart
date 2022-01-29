import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_actions_bar.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_reader.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/single_topic_view.dart';

class SingleEntryView extends StatelessWidget {
  final Entry entry;
  final bool showTitle;
  final void Function()? onAvatarPressed;

  const SingleEntryView({
    Key? key,
    required this.entry,
    this.onAvatarPressed,
    this.showTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIConstants.SMALL_PADDING,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle) TopicTitle(topic: entry.topic!),
          EntryReader(entry: entry),
          EntryActionsBar(entry: entry),
          AboutEntry(entry: entry, onAvatarPressed: onAvatarPressed),
        ],
      ),
    );
  }
}

class TopicTitle extends StatelessWidget {
  final Topic topic;

  const TopicTitle({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleEntryTopicTitle(topic: topic),
        const AppSizedBox(),
      ],
    );
  }
}

class SingleEntryTopicTitle extends StatelessWidget {
  final Topic topic;

  const SingleEntryTopicTitle({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BoldText(text: topic.name ?? ""),
      onTap: () {
        context.rootNavigator.pushNamed(SingleTopicView.PATH, arguments: SingleTopicViewArgs(topic: topic));
      },
    );
  }
}
