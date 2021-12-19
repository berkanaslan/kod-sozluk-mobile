import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';

class SearchView extends StatefulWidget {
  static const String PATH = "/search";

  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "ara"),
      body: Center(child: Text("inşaat devam ediyor.")),
    );
  }
}
