import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/entry_actions_bar.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/entry_reader.dart';

class SingleEntryView extends StatelessWidget {
  final Entry entry;
  final void Function()? onAvatarPressed;

  const SingleEntryView({Key? key, required this.entry, this.onAvatarPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIConstants.SMALL_PADDING,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryReader(entry: entry),
          const EntryActionsBar(),
          AboutEntry(entry: entry, onAvatarPressed: onAvatarPressed),
        ],
      ),
    );
  }
}
