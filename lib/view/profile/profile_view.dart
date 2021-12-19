import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/appbar/appbar.dart';

class ProfileView extends StatefulWidget {
  static const String PATH = "/profile";

  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "profil"),
      body: Center(child: Text("inşaat devam ediyor.")),
    );
  }
}
