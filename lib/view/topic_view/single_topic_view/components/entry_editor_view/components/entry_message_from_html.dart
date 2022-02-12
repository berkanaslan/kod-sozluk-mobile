import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';

class EntryMessageFromHTML extends StatelessWidget {
  final String message;
  final EdgeInsets margin;
  final void Function(String? url, RenderContext context, Map<String, String> attributes, dom.Element? element)?
      onLinkTapped;

  const EntryMessageFromHTML({
    Key? key,
    required this.message,
    this.onLinkTapped,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: message,
      style: {
        "body": Style(
          margin: margin,
          fontSize: FontSize(context.textTheme.bodyText2?.fontSize ?? 14),
        ),
        "a": Style(
          color: context.theme.primaryColor,
          textDecoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
        )
      },
      onLinkTap: onLinkTapped,
    );
  }
}
