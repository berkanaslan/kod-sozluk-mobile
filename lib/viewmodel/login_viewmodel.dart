import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/model/dto/user_dto.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/service/auth_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/base_viewmodel.dart';

import 'base/i_base_viewmodel.dart';

class LoginViewModel extends Cubit<AuthState> {
  LoginViewModel() : super(const InitialAuthState()) {
    checkAuthenticationAndEmit();
  }

  BaseViewModel<User> loginService = BaseViewModel(const InitialState(), locator<LoginService>());

  User? user;

  UserDTO userDTO = UserDTO();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // ------------------------------------------------------------------------------------------------------------------
  // LOGIN                                                                                                            /
  // ------------------------------------------------------------------------------------------------------------------
  Future<User?> onLoginButtonPressed() async {
    if (!loginFormKey.currentState!.validate()) {
      return null;
    }

    loginFormKey.currentState!.save();

    User? user = await loginService.post(requestBody: userDTO);

    if (user != null) {
      await SharedPrefs.setUser(user);
      emit(const AuthenticatedState());
      loginFormKey = GlobalKey<FormState>();
    } else {
      emit(const NotAuthenticatedState());
    }

    return user;
  }

  void checkAuthenticationAndEmit() {
    user = SharedPrefs.getUser();
    if (user == null) {
      emit(const NotAuthenticatedState());
    } else {
      emit(const AuthenticatedState());
    }
  }

  // ------------------------------------------------------------------------------------------------------------------
  // CLEAR                                                                                                            /
  // ------------------------------------------------------------------------------------------------------------------
  void clear() {
    userDTO = UserDTO();
    loginFormKey = GlobalKey<FormState>();
  }
}

abstract class AuthState {
  const AuthState();
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState();
}

class NotAuthenticatedState extends AuthState {
  const NotAuthenticatedState();
}
