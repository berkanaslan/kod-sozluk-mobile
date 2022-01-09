import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/context_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/ui_constants.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/app_text_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/button/rounded_button.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/image/logo.dart';

class NotLoggedProfileView extends StatelessWidget {
  final void Function()? onRegisterButtonPressed;
  final void Function()? onLoginButtonPressed;

  const NotLoggedProfileView({Key? key, this.onRegisterButtonPressed, this.onLoginButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          const Logo(),
          const Spacer(flex: 2),
          const Icon(AppIcons.person, size: 128),
          const Spacer(),
          Text(LocaleKeys.my_kod_sozluk_account.locale, style: context.textTheme.headline5),
          Text(LocaleKeys.register_then_start_write.locale),
          const Spacer(flex: 2),
          RoundedButton(title: LocaleKeys.register.locale, onPressed: onRegisterButtonPressed),
          UIConstants.VERTICAL_SMALL_SIZED_BOX,
          AppTextButton(
            leadingText: LocaleKeys.already_have_an_acount.locale,
            title: LocaleKeys.login.locale,
            onPressed: onLoginButtonPressed,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
