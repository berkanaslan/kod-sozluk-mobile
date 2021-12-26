import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';

class FollowingTopicsView extends StatefulWidget {
  static const String PATH = "/followings";

  const FollowingTopicsView({Key? key}) : super(key: key);

  @override
  _FollowingTopicsViewState createState() => _FollowingTopicsViewState();
}

class _FollowingTopicsViewState extends State<FollowingTopicsView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.following_topics.locale,
      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
