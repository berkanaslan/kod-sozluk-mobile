import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';

class EntryEditorButton extends StatelessWidget {
  final String title;
  final void Function()? onTapped;
  final int flex;

  const EntryEditorButton({Key? key, required this.title, this.onTapped, this.flex = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: SizedBox(
          height: 28,
          child: TextButton(
            child: Text(title, style: const TextStyle(color: AppColors.lightGrey, fontSize: 13)),
            onPressed: onTapped,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.all(AppColors.transparent),
              side: MaterialStateProperty.all(const BorderSide(color: AppColors.lightGrey, width: 1)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
        ),
      ),
    );
  }
}
