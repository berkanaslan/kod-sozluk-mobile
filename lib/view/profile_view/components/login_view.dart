import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_text_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/rounded_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/image/logo.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/app_text_field.dart';
import 'package:kod_sozluk_mobile/model/dto/user_dto.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/user_repository.dart';

import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  static const String PATH = "/profile/login";

  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final UserRepository viewModel;

  UserDTO userDTO = UserDTO();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    viewModel = context.read<UserRepository>();
  }

  @override
  void deactivate() {
    viewModel.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          const Spacer(),
          const Expanded(child: Logo()),
          usernameTextField,
          passwordTextField,
          forgotMyPasswordTextField,
          const SizedBox(height: 16.0),
          loginButton,
          const Spacer(flex: 3),
        ],
      ),
    ));
  }

  Widget get forgotMyPasswordTextField {
    return SizedBox(
      width: context.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppTextButton(
            title: "şifremi unuttum",
            onPressed: () {
              AppSnackBar.showSnackBar(message: "henüz daha erken; bir ara geliştireceğiz burayı da.");
            },
          ),
        ],
      ),
    );
  }

  AppTextField get usernameTextField {
    return AppTextField(
      labelText: LocaleKeys.username.locale,
      icon: AppIcons.person,
      textInputType: TextInputType.emailAddress,
      onSaved: (value) => userDTO.username = value,
    );
  }

  AppTextField get passwordTextField {
    return AppTextField(
      icon: AppIcons.password,
      labelText: LocaleKeys.password.locale,
      obscureText: true,
      onSaved: (value) => userDTO.password = value,
    );
  }

  RoundedButton get loginButton => RoundedButton(title: LocaleKeys.try_login.locale, onPressed: onLoginButtonPressed);

  void onLoginButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final User? user = await viewModel.login(userDTO);
    if (user != null) context.navigator.pop();
  }
}
