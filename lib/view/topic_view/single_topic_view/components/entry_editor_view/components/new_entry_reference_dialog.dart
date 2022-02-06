import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/rounded_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_alert_dialog.dart';

class NewEntryReferenceDialog {
  final void Function(String? value) onCompleted;
  final BuildContext context;

  const NewEntryReferenceDialog({required this.context, required this.onCompleted});

  show() {
    final TextEditingController controller = TextEditingController();

    AppDialog.showCustomDialog(
      title: "hangi başlığa bkz verilecek?",
      content: TextFormField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(filled: true, fillColor: context.theme.hoverColor, border: InputBorder.none),
      ),
      actions: [
        DialogRoundedButton(title: "vazgeç", positive: false, onPressed: () => context.navigator.pop()),
        DialogRoundedButton(
          title: "tamam",
          onPressed: () {
            if (controller.text.trim().isEmpty) return;
            context.navigator.pop();
            onCompleted("(bkz: ${controller.text.trim()})");
          },
        ),
      ],
    );
  }
}
