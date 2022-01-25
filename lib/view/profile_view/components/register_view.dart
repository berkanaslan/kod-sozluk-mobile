import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/rounded_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_exit_dialog.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/image/logo.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/app_text_field.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/checkbox_form_field.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/date_time_form_field.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/gender_text_field.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/password_helper_text_field.dart';
import 'package:kod_sozluk_mobile/model/dto/user_dto.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/user_repository.dart';
import 'package:kod_sozluk_mobile/view/profile_view/components/login_view.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  static const String PATH = "/profile/register";

  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final UserRepository authRepository;

  UserDTO userDTO = UserDTO();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authRepository = context.read<UserRepository>();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: registerFormKey,
      child: Column(
        children: [
          const Spacer(),
          const Expanded(child: Logo()),
          usernameTextField,
          emailTextField,
          birthdayTextField,
          genderSelectionTextField,
          newPasswordTextField,
          PasswordHelperTextField(controller: newPasswordController),
          newPasswordAgainTextField,
          userAgreementTextField,
          registerButton,
          const Spacer(),
        ],
      ),
    ));
  }

  AppTextField get usernameTextField {
    return AppTextField(
      labelText: LocaleKeys.nick.locale,
      onSaved: (value) => userDTO.username = value,
      validator: (value) {
        if (value == null || RegExp(AppConstants.UPPERCASE_REGEX).hasMatch(value)) {
          return LocaleKeys.username_not_correct.locale;
        }

        return null;
      },
    );
  }

  AppTextField get emailTextField {
    return AppTextField(
      labelText: LocaleKeys.email.locale,
      icon: AppIcons.mail,
      textInputType: TextInputType.emailAddress,
      onSaved: (value) => userDTO.email = value,
      validator: (value) {
        if (value == null || !RegExp(AppConstants.EMAIL_REGEX).hasMatch(value)) {
          return LocaleKeys.email_not_correct.locale;
        }

        return null;
      },
    );
  }

  DateTimeFormField get birthdayTextField {
    return DateTimeFormField(
      icon: AppIcons.calendar,
      labelText: LocaleKeys.birthday.locale,
      onSaved: (value) {
        DateFormat formatter = DateFormat("yyyy-MM-dd");
        userDTO.dateOfBirth = formatter.format(value!);
      },
      validator: (value) {
        if (value == null) return LocaleKeys.birthday_required.locale;
        if (DateTime.now().difference(value).inDays ~/ 365 < 18) return LocaleKeys.youre_not_adult.locale;
        return null;
      },
    );
  }

  StatefulBuilder get genderSelectionTextField {
    return StatefulBuilder(
      builder: (context, setState) => GenderSelectionFormField(
        value: userDTO.genderEnum,
        onChanged: (Gender? value) {
          userDTO.genderEnum = value!;
          setState(() {});
        },
      ),
    );
  }

  AppTextField get newPasswordTextField {
    return AppTextField(
      controller: newPasswordController,
      icon: AppIcons.password,
      labelText: LocaleKeys.new_password.locale,
      obscureText: true,
      onSaved: (value) => userDTO.password = value,
      validator: (value) {
        if (value == null || !RegExp(AppConstants.PASSWORD_REGEX).hasMatch(value)) {
          return LocaleKeys.check_password_rule.locale;
        }

        return null;
      },
    );
  }

  AppTextField get newPasswordAgainTextField => AppTextField(
        icon: AppIcons.password,
        labelText: LocaleKeys.new_password_again.locale,
        obscureText: true,
        validator: (value) {
          if (value != newPasswordController.text) return LocaleKeys.passwords_are_not_same.locale;
          return null;
        },
      );

  StatefulBuilder get userAgreementTextField {
    return StatefulBuilder(
      builder: (context, setState) => CheckboxFormField(
        value: userDTO.agreementConfirmed,
        text: LocaleKeys.privacy_agreement.locale,
        trailingText: LocaleKeys.read_and_accept.locale,
        onChanged: (value) {
          userDTO.agreementConfirmed = value!;
          setState(() {});
        },
      ),
    );
  }

  RoundedButton get registerButton {
    return RoundedButton(
      title: LocaleKeys.register_like_that.locale,
      onPressed: onRegisterButtonPressed,
    );
  }

  Future<void> onRegisterButtonPressed() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (!userDTO.agreementConfirmed) {
      AppAlertDialog.show(LocaleKeys.warning.locale, LocaleKeys.user_agreement_must_be_ok.locale);
      return;
    }

    registerFormKey.currentState!.save();
    userDTO.gender = userDTO.genderEnum.toString().split(".").last;

    User? user = await authRepository.register(userDTO);
    if (user != null) context.navigator.pushReplacementNamed(LoginView.PATH);
  }
}
