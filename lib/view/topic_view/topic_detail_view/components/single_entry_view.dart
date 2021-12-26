import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/about_entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/entry_actions_bar.dart';
import 'package:kod_sozluk_mobile/view/topic_view/topic_detail_view/components/entry_reader.dart';

class SingleEntryView extends StatelessWidget {
  final Entry entry;

  const SingleEntryView({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EntryReader(entry: entry),
          const EntryActionsBar(),
          AboutEntry(entry: entry),
        ],
      ),
    );
  }
}
