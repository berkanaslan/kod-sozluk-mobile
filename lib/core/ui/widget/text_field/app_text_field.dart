import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/form_field_wrapper.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final void Function(String? value)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String? value)? validator;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final String? initialValue;
  final TextEditingController? controller;
  final double? width;
  final bool? obscureText;
  final Widget? suffixIcon;

  const AppTextField({
    Key? key,
    this.hintText,
    this.icon = AppIcons.person,
    this.onChanged,
    this.labelText,
    this.onSaved,
    this.errorText,
    this.textInputType,
    this.initialValue,
    this.controller,
    this.validator,
    this.textInputAction,
    this.width,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        initialValue: initialValue,
        keyboardType: textInputType,
        onSaved: onSaved,
        obscureText: obscureText!,
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
