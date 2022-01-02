import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/form_field_wrapper.dart';

class DateTimeFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final void Function(DateTime? dateTime)? onSaved;
  final String? Function(DateTime? value)? validator;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final TextEditingController? controller;
  final double? width;

  const DateTimeFormField({
    Key? key,
    this.hintText,
    this.labelText,
    this.icon,
    this.onSaved,
    this.validator,
    this.errorText,
    this.textInputType,
    this.textInputAction,
    this.initialValue,
    this.controller,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      child: DateTimeField(
        showCursor: false,
        format: DateFormat("dd MMM yyyy"),
        onShowPicker: (context, currentValue) => _onShowPicker(context, currentValue),
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          suffixIcon: const SizedBox(width: 0),
        ),
      ),
    );
  }

  Future<DateTime> _onShowPicker(BuildContext context, DateTime? currentValue) async {
    final DateTime initialDate = (currentValue != null) ? currentValue : DateTime((DateTime.now().year - 18), 1, 1);

    final DateTime? date = await _buildShowDatePicker(context, initialDate);

    if (date != null) return date;
    return initialDate;
  }

  Future<DateTime?> _buildShowDatePicker(BuildContext context, DateTime initialDate) {
    return showDatePicker(
      helpText: LocaleKeys.birthday.locale,
      cancelText: LocaleKeys.cancel.locale,
      confirmText: LocaleKeys.confirm.locale,
      context: context,
      firstDate: DateTime(1900),
      initialDate: initialDate,
      lastDate: DateTime(2100),
    );
  }
}
