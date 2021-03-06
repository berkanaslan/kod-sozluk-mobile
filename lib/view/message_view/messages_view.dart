import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';

class MessagesView extends StatefulWidget {
  static const String PATH = "/message";

  const MessagesView({Key? key}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.messages.locale,
      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
