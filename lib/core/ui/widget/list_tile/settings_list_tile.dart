import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SettingsListTile({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onPressed ?? () {},
      trailing: const Icon(AppIcons.forward),
    );
  }
}
