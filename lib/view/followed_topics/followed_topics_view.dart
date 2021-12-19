import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';

class FollowedTopicsView extends StatefulWidget {
  static const String PATH = "/followed";

  const FollowedTopicsView({Key? key}) : super(key: key);

  @override
  _FollowedTopicsViewState createState() => _FollowedTopicsViewState();
}

class _FollowedTopicsViewState extends State<FollowedTopicsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "takip ettiğim başlıklar"),
      body: Center(child: Text("inşaat devam ediyor.")),
    );
  }
}
