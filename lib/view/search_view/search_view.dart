import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/scaffold/app_scaffold.dart';

class SearchView extends StatefulWidget {
  static const String PATH = "/search";

  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.search.locale,
      body: Center(child: Text(LocaleKeys.nothing_found.locale)),
    );
  }
}
