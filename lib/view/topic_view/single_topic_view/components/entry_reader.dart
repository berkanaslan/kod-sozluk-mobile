import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/read_more_button.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/repository/topic_repository.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/entry_message_from_html.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/single_topic_view.dart';
import 'package:provider/provider.dart';

class EntryReader extends StatelessWidget {
  final Entry entry;

  const EntryReader({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(entry, context),
          buildReadMoreButton(setState),
        ],
      ),
    );
  }

  Widget buildText(final Entry entry, BuildContext context) {
    if (entry.message!.length <= 240 || entry.expanded!) {
      return EntryMessageFromHTML(
        message: entry.message!,
        onLinkTapped: (url, renderContext, attributes, element) => onLinkTapped(element?.text ?? "", context),
      );
    }

    return EntryMessageFromHTML(
      message: entry.message!.substring(0, 240),
      onLinkTapped: (url, renderContext, attributes, element) => onLinkTapped(element?.text ?? "", context),
    );
  }

  void onLinkTapped(String topicName, BuildContext context) async {
    Topic? topic = await context.read<TopicRepository>().getByName(name: topicName);
    context.rootNavigator.pushNamed(SingleTopicView.PATH, arguments: SingleTopicViewArgs(topic: topic!));
  }

  ReadMoreButton buildReadMoreButton(StateSetter setState) {
    return ReadMoreButton(
      visible: !entry.expanded!,
      onPressed: () {
        entry.expanded = true;
        setState(() {});
      },
    );
  }
}
