import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_text_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/form_field_wrapper.dart';

class CheckboxFormField extends StatelessWidget {
  final void Function(bool? value)? onChanged;
  final String text;
  final String? leadingText;
  final String? trailingText;
  final bool value;

  const CheckboxFormField(
      {Key? key, this.onChanged, required this.text, this.leadingText, this.trailingText, this.value = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
        child: Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        AppTextButton(
          textAlign: TextAlign.start,
          leadingText: leadingText,
          title: text,
          trailingText: trailingText,
        ),
      ],
    ));
  }
}
