import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/user.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';

class LoginService extends EntityService<User> {
  LoginService() : super(path: URLConstants.LOGIN, fromJson: User.fromJson);
}

class UserService extends EntityService<User> {
  UserService() : super(path: URLConstants.USER, fromJson: User.fromJson);
}
