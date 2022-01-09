import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;
  final void Function()? onTap;

  const TopicTile({
    Key? key,
    required this.topic,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(topic.name ?? ""),
      trailing: Text("${topic.dailyTotalEntryCount ?? ""}", style: const TextStyle(color: AppColors.lightGrey)),
      onTap: onTap,
    );
  }
}
