import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';

class AppListTile extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const AppListTile({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          onTap: onPressed ?? () {},
          trailing: const Icon(AppIcons.forward),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
