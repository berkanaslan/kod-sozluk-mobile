import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/locator.dart';
import 'package:kod_sozluk_mobile/core/shared_preferences/shared_preferences.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/snackbar.dart';
import 'package:kod_sozluk_mobile/model/dto/user_dto.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/repository/base/base_entity_state.dart';
import 'package:kod_sozluk_mobile/repository/base/base_repository.dart';
import 'package:kod_sozluk_mobile/service/auth_service.dart';

class UserRepository extends Cubit<AuthState> {
  UserRepository() : super(const InitialAuthState()) {
    checkAuthenticationAndEmit();
  }

  User? user;
  final _loginService = BaseRepository(const InitialState(), locator<LoginService>());
  final _userService = BaseRepository(const InitialState(), locator<UserService>());

  // ------------------------------------------------------------------------------------------------------------------
  // LOGIN                                                                                                            /
  // ------------------------------------------------------------------------------------------------------------------
  Future<User?> login(final UserDTO userDTO) async {
    User? user = await _loginService.post(requestBody: userDTO);

    if (user != null) {
      await SharedPrefs.setUser(user);
      emit(const AuthenticatedState());
    } else {
      emit(const NotAuthenticatedState());
    }

    return user;
  }

  // ------------------------------------------------------------------------------------------------------------------
  // REGISTER                                                                                                         /
  // ------------------------------------------------------------------------------------------------------------------
  Future<User?> register(final UserDTO userDTO) async {
    User? user = await _userService.post(requestBody: userDTO);

    if (user != null) {
      AppSnackBar.showSnackBar(message: LocaleKeys.successful_registration.locale, type: SnackBarType.SUCCESS);
    }

    return user;
  }

  Future<User?> saveUser(final User user) async {
    return await _userService.post(requestBody: user);
  }

  Future<User?> getUserByUsername(final String username) async {
    return await _userService.get(requestParams: "?username=$username");
  }

  // ------------------------------------------------------------------------------------------------------------------
  // EMIT AUTH STATE                                                                                                  /
  // ------------------------------------------------------------------------------------------------------------------
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
  void clear() {}
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
