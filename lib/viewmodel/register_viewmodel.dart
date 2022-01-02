import 'package:flutter/material.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_exit_dialog.dart';
import 'package:kod_sozluk_mobile/model/dto/user_dto.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/service/auth_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel<User> {
  RegisterViewModel() : super(const InitialState(), locator<UserService>());

  // ------------------------------------------------------------------------------------------------------------------
  // PROPS                                                                                                            /
  // ------------------------------------------------------------------------------------------------------------------
  UserDTO userDTO = UserDTO();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // ------------------------------------------------------------------------------------------------------------------
  // REGISTER                                                                                                         /
  // ------------------------------------------------------------------------------------------------------------------
  Future<User?> onRegisterButtonPressed() async {
    if (!registerFormKey.currentState!.validate()) {
      return null;
    }

    if (!userDTO.agreementConfirmed) {
      AppAlertDialog.show(LocaleKeys.warning.locale, LocaleKeys.user_agreement_must_be_ok.locale);
      return null;
    }

    registerFormKey.currentState!.save();
    userDTO.gender = userDTO.genderEnum.toString().split(".").last;

    User? user = await post(requestBody: userDTO);

    if (user != null) {
      AppSnackBar.showSnackBar(message: LocaleKeys.successful_registration.locale, type: SnackBarType.SUCCESS);
      registerFormKey = GlobalKey<FormState>();
    }

    return user;
  }

  // ------------------------------------------------------------------------------------------------------------------
  // PASSWORD VALIDATION CHECKER                                                                                      /
  // ------------------------------------------------------------------------------------------------------------------
  TextEditingController newPasswordController = TextEditingController();

  // ------------------------------------------------------------------------------------------------------------------
  // CLEAR                                                                                                            /
  // ------------------------------------------------------------------------------------------------------------------
  clear() {
    userDTO = UserDTO();
    registerFormKey = GlobalKey<FormState>();
    newPasswordController = TextEditingController();
  }
}
