import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:kod_sozluk_mobile/view/topic_view/single_topic_view/components/entry_editor_view/components/entry_message_from_html.dart';

class NewEntryPreviewMode extends StatelessWidget {
  final void Function()? onTap;
  final String message;
  final void Function(String? url, RenderContext context, Map<String, String> attributes, dom.Element? element)?
      onLinkTapped;

  const NewEntryPreviewMode({Key? key, this.onTap, required this.message, this.onLinkTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: onTap,
        child: EntryMessageFromHTML(message: message, margin: const EdgeInsets.symmetric(vertical: 16)),
      ),
    );
  }
}
