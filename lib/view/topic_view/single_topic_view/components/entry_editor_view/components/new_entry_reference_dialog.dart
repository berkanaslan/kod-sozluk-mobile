import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';

enum EntryEditorType { REFERENCE, TITLE, ASTERISK, SPOILER, URL, IMAGE }

class EntryEditorTextField extends StatelessWidget {
  final EntryEditorType type;
  final void Function(String? value, EntryEditorType type) onCompleted;
  final FocusNode focusNode;

  const EntryEditorTextField({
    Key? key,
    required this.type,
    required this.onCompleted,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Expanded(
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        autofocus: true,
        decoration: buildInputDecoration(context),
        textInputAction: TextInputAction.done,
        onEditingComplete: () => onCompleted(generateString(controller.text), type),
      ),
    );
  }

  String generateString(String entered) {
    switch (type) {
      case EntryEditorType.REFERENCE:
        return "(bkz: ${entered.trim()})";
      case EntryEditorType.TITLE:
        return "`${entered.trim()}`";
      default:
        return "";
    }
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: context.theme.hoverColor,
      border: InputBorder.none,
      hintText: generateHintText(),
    );
  }

  String generateHintText() {
    switch (type) {
      case EntryEditorType.REFERENCE:
        return "hangi başlığa bkz verilecek?";
      case EntryEditorType.TITLE:
        return "hangi başlık için link oluşturulacak?";
      default:
        return "";
    }
  }
}
