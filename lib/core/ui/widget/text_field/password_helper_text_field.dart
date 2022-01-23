import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/form_field_wrapper.dart';

class PasswordHelperTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordHelperTextField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordHelperTextField> createState() => _PasswordHelperTextFieldState();
}

class _PasswordHelperTextFieldState extends State<PasswordHelperTextField> {
  late final TextEditingController controller;

  bool isGreaterThanEight = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;

    Future.microtask(() {
      controller.addListener(() {
        isGreaterThanEight = RegExp(AppConstants.EIGHT_CHAR_REGEX).hasMatch(controller.text);
        hasUpperCase = RegExp(AppConstants.UPPERCASE_REGEX).hasMatch(controller.text);
        hasLowerCase = RegExp(AppConstants.LOWERCASE_REGEX).hasMatch(controller.text);
        hasNumber = RegExp(AppConstants.DIGIT_REGEX).hasMatch(controller.text);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    //  context.read<AuthViewModel>().passwordController.dispose();
    // context.read<AuthViewModel>().passwordController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      child: RichText(
        text: TextSpan(
          text: LocaleKeys.password_minimum.locale,
          style: const TextStyle(color: AppColors.grey),
          children: <TextSpan>[
            TextSpan(
              text: LocaleKeys.eight_chars.locale,
              style: TextStyle(fontWeight: FontWeight.bold, color: getColor(isGreaterThanEight)),
            ),
            TextSpan(text: LocaleKeys.be_and_includes.locale),
            TextSpan(
              text: LocaleKeys.upper_case_letter.locale,
              style: TextStyle(fontWeight: FontWeight.bold, color: getColor(hasUpperCase)),
            ),
            const TextSpan(text: ", "),
            TextSpan(
              text: LocaleKeys.lower_case_letter.locale,
              style: TextStyle(fontWeight: FontWeight.bold, color: getColor(hasLowerCase)),
            ),
            TextSpan(text: LocaleKeys.and.locale),
            TextSpan(
                text: LocaleKeys.number.locale,
                style: TextStyle(fontWeight: FontWeight.bold, color: getColor(hasNumber))),
            TextSpan(text: LocaleKeys.should_includes.locale)
          ],
        ),
        maxLines: 3,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Color getColor(bool value) {
    if (value) return AppColors.success;
    return context.theme.textTheme.headline1!.color!;
  }
}
