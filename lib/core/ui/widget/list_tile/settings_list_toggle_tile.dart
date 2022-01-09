import 'package:flutter/material.dart';

class SettingsListToggleTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final void Function(bool value)? onChanged;
  final bool value;

  const SettingsListToggleTile({Key? key, required this.title, this.onChanged, this.value = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Switch(value: value, onChanged: onChanged),
      onTap: onTap,
    );
  }
}
