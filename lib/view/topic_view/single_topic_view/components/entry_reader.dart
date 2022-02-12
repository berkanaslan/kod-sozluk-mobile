import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/read_more_button.dart';
import 'package:kod_sozluk_mobile/model/entry.dart';
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/entry_message_from_html.dart';

class EntryReader extends StatelessWidget {
  final Entry entry;

  const EntryReader({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(entry),
          buildReadMoreButton(setState),
        ],
      ),
    );
  }

  Widget buildText(final Entry entry) {
    if (entry.message!.length <= 240 || entry.expanded!) {
      return EntryMessageFromHTML(message: entry.message!);
    }

    return EntryMessageFromHTML(message: entry.message!.substring(0, 240));
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
