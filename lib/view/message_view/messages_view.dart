import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';

class MessagesView extends StatefulWidget {
  static const String PATH = "/message";

  const MessagesView({Key? key}) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "mesajlar"),
      body: Center(child: Text("inşaat devam ediyor.")),
    );
  }
}
