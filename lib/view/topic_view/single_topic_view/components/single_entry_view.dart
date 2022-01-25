import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/bold_text.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_actions_bar.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_reader.dart';

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
          if (showTitle) TopicTitle(title: entry.topic!.name!),
          EntryReader(entry: entry),
          const EntryActionsBar(),
          AboutEntry(entry: entry, onAvatarPressed: onAvatarPressed),
        ],
      ),
    );
  }
}

class TopicTitle extends StatelessWidget {
  final String title;

  const TopicTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoldText(text: title),
        const AppSizedBox(),
      ],
    );
  }
}
